// create semaphore (or connect to existing one) -> segmet
// perform operations on the semaphore -> semop
// control operations on the message queue -> semctl()

#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <unistd.h>
#include <signal.h>
#include <wait.h>

#define PHILOSOPHERS 5
#define THINKING 0
#define HUNGRY 1
#define EATING 2
#define SELF process
#define LEFT (process + PHILOSOPHERS - 1) % PHILOSOPHERS
#define RIGHT (process + 1) % PHILOSOPHERS

volatile int eat_count;
int semset;
int process;
char* state;

// init semaphore : 
void sem_init(int semnr, int value){
  int sem;
  sem = semctl(semset, semnr, SETVAL, value);
}

// send a signal to semaphore to continue
void sem_signal(int semnr){
  struct sembuf semops;
  int sem;
  semops.sem_num = semnr;
  semops.sem_op = 1; // release resources
  semops.sem_flg = 0;

  sem = semop(semset,&semops,1);
}

// wait for semaphore
void sem_wait(int semnr){
  struct sembuf semops;
  int sem;
  semops.sem_num = semnr;
  semops.sem_op = -1; // Blocks the calling process until enough resources have been freed by other processes, so that this process can allocate.
  semops.sem_flg = 0;
  sem = semop(semset, &semops, 1);
}

// signal handler
void handler_term(){
  printf("Philosopher[%d] : ate %d times.\n", process,eat_count);
  exit(0);
}

// test if the philosopher can eat
void test(int i){
  if(state[i] == HUNGRY && state[LEFT] != EATING && state[i] != EATING){
    state[i] = EATING;
    sem_signal(i);
  }
}

void grab_forks(){
  sem_wait(PHILOSOPHERS);
  printf("Philosopher[%d] is hungry...\n", process);
  state[SELF] = HUNGRY;
  test(SELF);
  sem_signal(PHILOSOPHERS);
  sem_wait(SELF);
}

void put_away_forks(){
  sem_wait(PHILOSOPHERS);
  state[SELF] = THINKING;
  test(LEFT);
  test(RIGHT);
  sem_signal(PHILOSOPHERS); 
}

void childProcess(){
  eat_count = 0;
  signal(SIGINT, handler_term);
  while(1){
    printf("Philosopher[%d] is thinking...\n", process);
    sleep(rand() %10);
    grab_forks();
    printf("Philosopher[%d] is eating...\n", process);
    eat_count += 1;
    sleep(rand()%10);
    printf("Philosopher[%d] is done eating...\n",process);
    printf("==================================\n");
    put_away_forks();
  }
}

//the parent process has to wait until all the children process are finished
void parentProcess(){
  wait(NULL); 
}

int main(int argc, char *argv[]){
  int shmID;
// to create shared memory
  shmID = shmget(IPC_PRIVATE, PHILOSOPHERS, IPC_CREAT | 0x1ff);
  state = (char*) shmat(shmID, NULL, 0); 
  /* Before you can use a shared memory segment, you have to attach yourself
to it using shmat. shmid is shared memory id. shmaddr specifies specific address to use but we should set
it to zero and OS will automatically choose the address.*/
  semset = semget(IPC_PRIVATE, PHILOSOPHERS+1,IPC_CREAT | 0x1ff);
  if (semset == -1){
    printf("Error occured creating semaphores...\n");
    exit(1);
  }

// initliaze semaphores to 0
  int i; 
  for(i=0; i < PHILOSOPHERS; i++){
    sem_init(i,0);
  }
  sem_init(i,1); // init mutex to 1
  for(i=0; i<PHILOSOPHERS; i++){
    state[i] = THINKING;
  }
// create children processes
  int pid;
  for(process=0; process<PHILOSOPHERS; process++){
    pid = fork();
    if(pid == 0){
      break;
    }
  }
  if (pid == 0){
    childProcess();
  }
  else if (pid < 0){
    printf("Error ocurred creating child...\n");
    exit(1);
  }
  else{
    parentProcess();
  }

  return 0;

  }



