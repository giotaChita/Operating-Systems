// Panagiota Chita 

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>
#include <string.h>


#define NUM_CHILD 5
#define WITH_SIGNAL
static int interrupt_occured = 0;

void handler_ignore(int sig){
    printf("Parent[%d] : handling signals\n", getppid());
    // void since I want nothing to happen
}

void handle_inter(int sig){
    printf("Parent[%d] : CAUGHT SIGINT!\n", getppid());
    interrupt_occured = 1;
}

void handle_inter_child(int sig){
    printf("Child[%d] : CAUGHT SIGINT!\n", getpid());
}

void handle_sgtrm_child(int sig){
    printf("Child[%d]: received SIGTERM signal, terminating \n", getpid());
}

int main(int argc, char* argv[]){
    
    pid_t pid[NUM_CHILD];
    #ifdef WITH_SIGNAL
    for(int i =1; i <= NUM_CHILD; i++){
        printf("=======================================================\n");
        pid[i] = fork();
        sleep(1);
        printf("Current id : %d, ", getpid());
        printf("Parent id : %d\n", getppid());

        if (pid[i]==0){
            //restore the sigchld 
            signal(SIGCHLD,SIG_DFL);
            printf("Child[%d]  No.%d created correctly!\n", getpid(), i);
            signal(SIGINT, handle_inter_child);
            signal(SIGTERM, handle_sgtrm_child);
            sleep(10);
            exit(0);
        }
        else if(pid[i]<0){
            printf("Error! Fail creating child.\n");
            for(int j = i ; j > 0 ; j--){
                kill(pid[j], SIGKILL);
            }
            exit(1);
        }
        else{
            if (interrupt_occured==1){
                for(int j=i;j>0;j--){
                    printf("Parent[%d] : sending SIGTERM signal\n", getppid());
                    kill(pid[j], SIGTERM);
                    printf("\nProcess[%d] was interrupted!\n", getpid());
                    interrupt_occured = 0;
                } 
            }
            printf("Parent[%d] \n", getppid());
            // igonre all the signals
            int k;
            for(k = 0; k < 32; k++){
                signal(k,handler_ignore);
            }
            signal(SIGINT, handle_inter);


            wait(NULL); //parent wait for the child to complete
            printf("Child[%d] process complete.\n", getpid());
            printf("\n");

        }
    }
    #endif
    #ifndef WITH_SIGNAL
    for(int i =1; i <= NUM_CHILD; i++){
        pid[i] = fork();
        sleep(1);
        printf("Current id : %d, ", getpid());
        printf("Parent id : %d\n", getppid());

        if (pid[i]==0){
            
            printf("%d Child[%d] created correctly!\n", i,getpid());
            sleep(10);
            exit(0);
        }
        else if(pid[i]<0){
            printf("Error! Fail creating child.\n");
            for(int j = i ; j > 0 ; j--){
                kill(pid[j], SIGKILL);
            }
            exit(1);
        }
        else{
            printf("Parent[%d]\n", getppid());
            wait(NULL); //parent wait for the child to complete
            printf("Child process complete.\n");
            printf("\n");
        }
    }
    #endif
    printf("All children have been created!\n");

    struct sigaction act;
    memset(&act, 0, sizeof(struct sigaction));
    act.sa_flags = SA_RESETHAND;
    act.sa_handler = SIG_DFL;
    for(int s = 0; s < 32; s++){
        sigaction(s, &act, NULL);
    }
    while(1){ 
    }

    return 0;
}



    
