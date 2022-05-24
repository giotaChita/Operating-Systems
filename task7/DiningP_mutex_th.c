/* https://stackoverflow.com/questions/69578246/c-dining-philosophers-how-to-make-concurrent-threads-wait-till-a-condition-i */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define N	5
#define LEFT	( i + N - 1 ) % N
#define RIGHT	( i + 1 ) % N

#define THINKING 0
#define HUNGRY 1
#define EATING 2

pthread_mutex_t m;
int state[N];
pthread_mutex_t s[N];
int eat_count[N];
int running = 1;
void test(int i){
    if(state[i] == HUNGRY && state[LEFT] != EATING && state[RIGHT] != EATING){
        state[i] = EATING;
        eat_count[i]++;
        pthread_mutex_unlock(&s[i]);
    }
}

void grab_forks(int i){
    pthread_mutex_lock(&m);
    state[i] = HUNGRY;
    test(i);
    pthread_mutex_unlock(&m);
    pthread_mutex_lock(&s[i]);
}

void put_away_forks(int i){
    pthread_mutex_lock(&m);
    state[i] = THINKING;
    printf("Philosopher[%d] finishes eating...\n", i);
    test(LEFT);
    test(RIGHT);
    pthread_mutex_unlock(&m);
}


void think(int i){
    printf("Philosopher[%i] is thinking...\n", i);
    sleep(rand() %5+1);
}

void eat(int i){
    printf("Philosopher[%i] is eating...\n",i);
    sleep(rand()%5+1);
}

void* philosopher(void* arg){
    int id =*(int *)arg;
    free(arg);
    printf("Philosopher[%d] join the table.\n", id);
    while(running){
        think(id);
        grab_forks(id);
        eat(id);
        put_away_forks(id);
        printf("=============================\n");
    }
}

void* runtime(){
   sleep(40); 
   running=0;
}

int main(void){
    pthread_t p_id[N],total_time;
    pthread_mutex_init(&m,NULL);
    int *arg;
    for(int i = 0; i<N;i++){
        pthread_mutex_init(s+1,NULL);
        pthread_mutex_lock(&s[i]);
    }
    pthread_create(&total_time,NULL,&runtime,NULL);

    for(int i = 0; i< N; i++){
        arg = (int *)malloc(sizeof(int));
        *arg = i;
        pthread_create(&p_id[i], NULL, &philosopher, arg);
    }

    for(int i = 0; i < N; i++){
        pthread_join(p_id[i], NULL);
    }

    pthread_mutex_destroy(&m);
    for(int i=0;i<N;i++){
        pthread_mutex_destroy( &s[i] );
    }
    printf("End of dinner\n");
    for(int i=0;i<N;i++){
      printf("Philosopher [%d] ate %d times\n",i,eat_count[i]);
    }
    return 0;
}
