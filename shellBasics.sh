# ! /usr/bin/bash


# echo "Input from user:"
# read name1 
# echo "Name: " $name

# # to put input in the same line -> -p

# read -p 'username: ' user_var
# echo "username : $user_var " 

# # not to show what the user is typing ->sp

# read -sp 'password: ' user_pass
# echo "password: " $user_pass

# # multiple inputs inside an array save:  read an array -> -a

# echo "Enter names: "
# read -a names 
# echo "The names are :  ${names[0]} "
# echo "The names are :  ${names[1]}"

# # default variable REPLY 

# echo "what?"
# read
# echo "Well : $REPLY"

# ## Pass arguments to a bash-script 

# # $1 the first arguments will be saved there etc..
# echo $0 $1 $2 $3 ' > echo $1 $2 $3'
# # $0 saves the schript name 

# i=0
# args=("$@") #it saves all the arguments in an array but not the name of the file
# while [ $i -le $# ]
# do
#     echo ${args[$i]}
#     i=$(( $i + 1 ))
# done

# ## IF STATEMENT

# # if [condition]
# # then
# #     statement
# # fi 

# # Condition I can use:
# # Int comparison: 
# # -eq ~ is equal to ~ if [ "$a" -eq "$b" ]
# # -ne ~ not equal to
# # -gt ~ is greater than 
# # -ge ~ is greater than or equal to 
# # -lt ~ is less than 
# # -le ~ is less than or equal to
# # < ~ is less than ~ (("$a" < "$b")) 
# # similar: <=, >, >= 

# # String comparison:
# # = ~ is equal to ~ if [ "$a" = "$b" ]
# # == ~ is equal to 
# # != ~ not equal 
# # < ~ less than in ASCII alphabetical order, similar: >
# # -z ~ string is null that is has zero length

# word=abc

# if [[ $word < "abd" ]]
# then 
#     echo "condition b is True"
# elif [[ $word == "abc" ]]; then
#     echo "condition a is True"
# else
#     echo "condition False stupid potato"
# fi 

# ## FILE OPERATORS: 

# echo -e "Enter the name of the file: \c" # -e and \c keeps the cursor in the same line
# read file_name

# #check if the file exists or not -> -e
# if [ -e $file_name ]
# then
#     echo "$file_name found !"
# else 
#     echo "$file_name not found !"
# fi

# #check if it is a file or not -> -f

# if [ -f $file_name ] 
# then
#     echo "$file_name is a file !"
# else 
#     echo "$file_name is not a file !"
# fi

# #check directory -> -d

# if [ -d $file_name ] 
# then
#     echo "$file_name is a dir !"
# else 
#     echo "$file_name is not dir !"
# fi

# #check block special file(binary file) and characters special file(readable file)
# # for blocks -> -b and for characters -> -c

# if [ -c $file_name ] 
# then
#     echo "$file_name char file !"
# else 
#     echo "$file_name not char file !"
# fi

# #check if a file is empty: -s

# if [ -s $file_name ] 
# then
#     echo "$file_name not empty !"
# else 
#     echo "$file_name empty !"
# fi

# #check if i want to see if the file is readbale or writeable or executable -> -r -w -x

# #  OUTPUT INTO A TEXT FILE

# to see the permission in a file: ls -al
# to remove a permission : chmod -w $filename (here we remove write rights)
# to add a permission : chmod +w $file_name

# ## AND -> &&, -a        OR -> ||, -o

# age=21
# if [ "$age" -gt 18 ] && [ "$age" -lt 30 ] 
# then 
#     echo "Success"
# else
#     echo "Failure..."
# fi 

# if [ "$age" -gt 18 -a "$age" -lt 30 ] 
# then 
#     echo "Success"
# else
#     echo "Failure..."
# fi 

# ## ARITHMETIC OPERATIONS : *,/,-,+,% mod

# num1=2
# num2=33
# echo $(( num1 / num2 ))

# # for intergers: expr command -> one () and $ and \*


# echo $(expr $num1 + $num2)
# echo $(expr $num1 \* $num2)

# ## TODO: SKIP LESSON 11

# ## CASE STATEMENT

# # case expression in
# #     patter1 )
# #         statements ;;
# #     pattern2 )
# #         statements ;;
# #     ...
# # esac

# vehicle=$1

# case $vehicle in
#     "car" )
#         echo "Rent $vehicle" ;;
#     "van" )
#         echo "Rent $vehicle" ;;
#     "velo" )
#         echo "Rent $vehicle" ;;
#     * )
#         echo "Cannot rent $vehicle" ;;
# esac

# echo -e "Enter some character: \c"
# read value

# case $value in
#     [a-z] ) # expect a small letter
#         echo "$value is a small letter" ;;
#     [A-Z] ) # expect capital letter
#         echo "$value is a capital letter" ;;
#     [0-9] )
#         echo "$value is int between 0-9" ;;
#     ? ) # expect ant special character -> one letter
#         echo "$value is a special character";;
#     * ) # expect more than one or one special character ex string
#         echo "$value unknown " ;;
# esac

# ## ARRAY 
# os=('ubuntu' 'linux' 'windows')
# echo "${os[@]}"
# echo "${!os[@]}" #prints the index of the array
# echo "${#os[@]}" # the legnth of the array 

# # add element:
# os[3]='mac'
# echo "${os[@]}"

# # remove element: unset
# unset os[1]
# echo "${os[@]}"

# string=donotknowwhatiamwriting
# echo "${string[0]}"

# ## WHILE

# # while [ condition ]
# # do 
# #     command1
# #     command2
# # done

# n=1
# while [ $n -le 10 ] # or: (( $n <= 10 ))
# do 
#     echo -e "$n \c"
#     # n=$(($n+1)) 
#     # (( ++n ))
#     (( n++ ))
#     # gnome-terminal & # open new terminal
# done
# echo 

# ## READ A FILE CONTENT IN BASH

# cat dir | while read p 
# do 
#     echo $p 
# done 

# echo "METHOD 2"

# while read p 
# do 
#     echo $p 
# done < dir 

# echo "METHOD 3"
# # recognise word space -> IFS 
# while IFS= read -r line
# do 
#     echo $line
# done < /etc/host.conf

# ## TODO:  SKIP UNTIL LOOP -> 18

# ## FOR LOOP

# # for VARIABLE in 1 2 3 4 ... N 
# # do 
# #     command1
# #     command2
# # done 
# # # or
# # for VARIABLE in file1 file2 file3
# # do
# #     command1 om $VARIABLE
# #     command2
# # done 
# # # or 
# # for OUTPUT in $(Linux-Or-Unix-Command-Here)
# # do 
# #     command1
# #     command2
# # done
# # #or
# # for (( EXP1; EXP2; EXP3 ))
# # do 
# #     command1
# #     command2
# # done
# echo ${BASH_VERSION}
# for i in 1 3 5 6
# do 
#     echo $i
# done

# for i in {3..6..2} # {start..end..step}
# do 
#     echo -e "$i \c"
# done
# echo
# for ((i=0; i<5; i++))
# do 
#     echo -e "$i \c"
# done

# for command in ls pwd date 
# do 
#     echo "---------------$command---------------"
#     $command
# done

# for item in * # every file or dir in this dir that i am in now
# do 
#     if [ -d $item ]; then 
#         echo "DIR: $item"
#     elif [ -f $item ]; then
#         echo "FILE: $item"
#     fi 
# done 

# ## TODO: SKIP 21, 22

# ## FUNCTIONS 

# function name(){
#     commands 
# }

# name (){
#     commands
# }

# function Hello(){
#     echo "Hello world"
# }

# quit(){
#     exit
# }

# function print(){
#     echo $0 $1
# }
# print ena einai to aidoni
# Hello
# quit
# Hello

# # LOCAL VARIABLES 
# [...]
