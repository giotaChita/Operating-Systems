#!/usr/bin/bash

file_name=`basename $0`

help() {

    #Dislpay help 
    echo "[-h]  help "

    echo "The availiable commands are: "  
    echo "[-l]  for lowerizing file name"
    echo "[-u]  for uppercasing a file name"
    echo "[-r]  for recursion"
    echo "<sed pattern> for sed pattern"
    echo 
    echo "Syntax:"
    echo "$file_name [-l] <dir/file names...>"
    echo "$file_name [-u] <dir/file names...>"
    echo "$file_name [-r] [-l] <dir/file names...>"
    echo "$file_name [-r] [-u] <dir/file names...>"
    echo "$file_name <sed pattern> <dir/file names...> "

}

error() {
    #Display error
	echo "$file_name: ERROR"
    echo "Type -h for help" 1>&2
}

userRenameFile() {
    if test -z "$1"
    then
            error "missing argument for -rne2"
            exit 1
    fi
    #Rename the file name with another input of user new file name
    read newname
    if [ "$1" == $newname ]
    then
        echo "$1 and $newname are the same file"
    else
        mv -v -- "$1" "$newname"
    fi
}

renameFile() {
    if test -z "$1" || test -z "$2"
    then
            error; echo "missing argument for -rne"
            exit 1
    fi
    #Rename the file_name saved in $1 with the new file name saved in $2
    if [ "$1" == "$2" ]
    then
        echo "$1 and $2 are the same file"
    else
        mv "$1" "$2" 
    fi
}

upperToLower(){
    if test -z "$1"
    then
            error 
            echo "missing argument for -l"
            exit 1
    fi
    #lowerizing file name without recursion 
    newfile="${1,,}"
    renameFile $1 $newfile
    echo $newfile
}

lowerToUpper(){
    if test -z "$1"
    then
            error
            echo "wrong argument for -u"
            exit 1
    fi
    #uppercasing file name without recursion 
    file="$1"
    newfile="${file^^}"
    renameFile $file $newfile
    echo $newfile
}

# sedReplace() {
#     if test -z "$1" || test -z "$2" || test -z "$3"
#     then
#             error "missing argument for sed"
#             exit 1
#     fi
#     #Replace a letter from file names with another one
#     file=$1
#     echo "$file"
#     newfile=`echo $file | sed 's/'$2'/'$3'/g'`
#     mv $file $newfile
#     echo "$newfile"
# }

sedCommand() {
    if test -z "$1" || test -z "$2" 
    then
            error "missing argument for sed"
            exit 1
    fi
    filename=$2
    sedcomm=$1
    newfile=$(echo $filename | sed $sedcomm)
    renameFile $filename $newfile 
    echo $newfile
}

recursive(){
    local pwdCurrent=`pwd`
    local filename=`basename $1`
    local newdirec=`dirname $1`

    cd $newdirec
    newpdw=`pwd`

    #check if it is a directory
    if [ -d $filename ]; then
        local temp=`ls $filename`

        if [ "$(ls -A "$newdirec/$filename")" ]; then

            cd $filename 
            for file in *
            do  
                recursive "$(pwd)/$file" $2

            done

            cd ..
        fi
    fi

    if test -f "$filename"; then
        filefound=true 
    elif test -d "$filename"; then
        filefound=true
    else 
        filefound=false
    fi 

    if [ $filefound ];then 
        if [ $2 == "-u" ]; then 
            oldname=$filename     
            lowerToUpper $filename
        elif [ $2 == "-l" ]; then
            oldname=$filename
            upperToLower $filename
        else
            oldname=$filename 
            sedCommand $2 $filename 
        fi 
    else 
        error 
        echo "$filename not found !"
    fi 
    # cd $pwdCurrent
}

input_user() {
    case "$1" in 
        -h ) help; exit 0;;
        -u ) lowerToUpper $2;;      
        -l ) upperToLower $2;;   
        -r ) recursive $3 $2;;
        * ) sedCommand $1 $2;; 
        -* ) error; echo "not valid command";exit 0;;
    esac
}

if [ -z "$1" ];then 
    error 
    echo "Empty file/directory"
    exit 1 
fi

while test "x$1" != "x"
do 

    if [ -z "$2" ];then 
        input_user $1 $2 $3 $4
        exit 1
    elif [ "$1" != "-r" ] ; then         
        if [ ! -f "$2" ] && [ ! -d "$2" ];
        then
            error 
            echo "file $2 does not exists"
            exit 1
        fi 
    fi 
    input_user $1 $2 $3 $4
    exit 1
done
exit 0

