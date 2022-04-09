#! bin/bash

#when i create the file from touch command:
# chmod +x test2.h 
#now from -rw-rw-r-- it gets to be executed: -rwxrwx-x


echo $BASH #-> this var gives s the name of the bash 
echo $BASH_VERSIOM # the version of bash 
echo $HOME # home directory
echo $PWD # do not remember

#TO change the name of the file:

function mv(){
  if [ "$#" -ne 1] || [ ! -e "$1"]; 
  then
    command mv "$0"
    return
  fi 
  read -ei "$1" newname
  command mv -v -- "$1" "$newname"
}

#SOURCE : https://gist.github.com/glynhudson
# convert to lower case :
function lc(){
  if [-z $1]; 
  then
    echo Insert the new directory
#    exit 0
  fi
  
  find "$1" -depth -name '*' 
  while read file 
  do 
    directory = $(dirname "$file"
    oldfile = $(basename "$file")
   
   #WHYYY???
   newfile = $(echo "$oldfile" | tr ' ' '_'  |tr ',' '_' | tr '+' '_' | tr '&' '_' | tr '!' '_' | tr "'" "-" | tr "(" "-" | tr ")" "-" | tr "~" "-" | tr ']' '_' | tr '[' 'p')
    if [ "$oldfilename" != "$newfilename" ]; then
      mv -i "$directory/$oldfilename" "$directory/$newfilename"
                echo ""$directory/$oldfilename" ---> "$directory/$newfilename""
                #echo "$directory"
                #echo "$oldfilename"
                #echo "$newfilename"
                #echo
    fi     
    done
# MAYBE USUFULL : https://github.com/topics/rename-script   
        
    


}
