
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <time.h>


void copy_read_write(int fd_from, int fd_to){
    char c;
    while(read(fd_from, &c, 1)!=0)
        write(fd_to,&c,1);
    return;
    
}


void copy_mmap(int fd_from, int fd_to){
    size_t file_size = lseek(fd_from,0,SEEK_END); 
    // is used to change the location of the read/write pointer of a file descriptor. 
    //the file offset is set to the size of the file plus offset.
    // lseek() returns the resulting offset location as measured in bytes from the beginning of the file
    ftruncate(fd_to,file_size);
    char* sourcef=mmap(NULL,file_size,PROT_READ,MAP_PRIVATE,fd_from,0);
    // mmap it returns a pointer to a block of memory and my files contents are gonna be in that array 
	char* destinationf=mmap(NULL,file_size,PROT_READ|PROT_WRITE,MAP_SHARED,fd_to,0);
    if (destinationf == MAP_FAILED)
        perror("mmap() failed.");
    memcpy(destinationf,sourcef,file_size);
    return ;
}

void help_function(){
    printf("\nHELP-OPTIONS: \n");
    printf("    copy [-m] <file_name> <new_file_name>\n");
    printf("    copy [-h]\n");
}

int main(int argc, char* argv[]){
    int opt;
    int fd_from =0, fd_to = 0;
    int mmap_method = 0;
    int help_flag = 0;
    int val = 0;

    if (argc == 1) {
        help_function();
        return 0;
    }

    clock_t start,end;
    double cpu_time_used;

    while ((opt = getopt (argc, argv,"mh")) != -1){
        switch(opt){
            case 'h':
                if (argc == 2){
                    help_flag = 1;
                    break;
                }
                else 
                    printf("Error: not valid arguments.\n");
                return 1;   
            case 'm':
                mmap_method = 1;
                val = 1;
                break;
            default:
                printf("error: unknown option. For help use: copy [-h]\n");
                // break;
                return 1;
        }
    }
    if (!help_flag) {
        char* oldfile=argv[1+val];
        char* newfile=argv[2+val];
        //Open for reading only. 
        int fd_from = open(oldfile,O_RDONLY); // returns a file descriptor > 0 : an index in the process's table of open file descriptors.
        //Open for reading and writin and if the file does not exist the file is created.
        int fd_to = open(newfile,O_RDWR|O_CREAT,0666);
        if(mmap_method){
            start = clock();
            copy_mmap(fd_from,fd_to);
            end = clock();
            cpu_time_used = ((double)(end-start))/CLOCKS_PER_SEC;
            printf("\nmmap method: %f\n", cpu_time_used);
        }
        else{
            start = clock();
            copy_read_write(fd_from,fd_to);
            end = clock();
            cpu_time_used = ((double)(end-start))/CLOCKS_PER_SEC;
            printf("\nread_write method: %f\n", cpu_time_used);
        }
        // close the file descriptor 
        close(fd_from);
        close(fd_to);
       
    }
    else {
        help_function();
        return 0;
    }
    return 1;
}


           
