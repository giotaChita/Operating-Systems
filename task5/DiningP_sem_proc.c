#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

#define THINKING 0
#define HUNGRY 1
#define EATING 2
#define PHILOSOPHERS 5


#define LEFT (i + PHILOSOPHERS - 1) % PHILOSOPHERS
#define RIGHT (i + 1) % PHILOSOPHERS

sem_t sem[PHILOSOPHERS];
pthread_mutex_t mutex;

int state[PHILOSOPHERS];

void think(int i){
    printf("Philosopher[%i] is thinking...\n", i);
    sleep(rand() %10);
}

void eat(int i){
    printf("Philosopher[%i] is eating...\n",i);
    sleep(rand()%10);
}

void test(int i){
    if(state[i] == HUNGRY && state[LEFT] != EATING && state[RIGHT] != EATING){
        state[i] = EATING;
        sem_post(&sem[i]); // unlocks the semaphore pointed to by sem.
    }
}

void grap_forks(int i){
    pthread_mutex_lock(&mutex);
    state[i] = HUNGRY;
    test(i);
    pthread_mutex_unlock(&mutex);
    sem_wait(&sem[i]); // locks the semaphore pointed to by sem.
}

void put_away_forks(int i){
    pthread_mutex_lock(&mutex);
    state[i] = THINKING;
    test(LEFT);
    test(RIGHT);
    pthread_mutex_unlock(&mutex);
}


void *philosopher(void *arg){
    int i = *(int *)arg;
    free(arg);
    while(1){
        think(i);
        grap_forks(i);
        eat(i);
        printf("Philosopher[%i] done eating...\n", i);
        printf("==============================\n");

        put_away_forks(i);

    }
}

int main(void){
    int i;
    int j;
    int *arg;
    pthread_t tid[PHILOSOPHERS];

    for(j = 0; j < PHILOSOPHERS; j++){
        sem_init(&sem[j] , 0, 0);
    }

    // create philosopher thread
    for(i = 0; i< PHILOSOPHERS; i++){
        arg = (int *)malloc(sizeof(int));
        *arg = i;
        pthread_create(&tid[i], NULL, philosopher, arg);
    }

    // wait to finish the dinner
    for( i = 0; i < PHILOSOPHERS; i++){
        pthread_join(tid[i], NULL);
    }

    for(j = 0; j < PHILOSOPHERS; j++){
        sem_destroy(&sem[j]);
    }
    return EXIT_SUCCESS;
}

