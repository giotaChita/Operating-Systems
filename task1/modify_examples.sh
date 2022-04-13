#!/usr/bin/bash

# echo "create directories..."
# mkdir "university"
# cd "university"
# mkdir "SUMMERCOURS"
# mkdir "wintercours" 
# mkdir "wintercours/OPTICALFIBER"
# mkdir "wintercours/SAE"
# mkdir "wintercours/deepLearning"
# mkdir "SUMMERCOURS/telecommunations"
# mkdir "SUMMERCOURS/AI"
# mkdir "SUMMERCOURS/optimization" 
# ls -R 

# echo "----------------"
# echo "modify -h"
# ../task1.sh -h

echo "-------ls before---------"
ls
echo 
echo "-------uppercasing--------"

./modify.sh -u testfile
echo
echo "-------lowerizing---------"
./modify.sh -l TESTFORL
echo
echo "-------sed pattern---------"
./modify.sh s/t/T/g testingSED
echo
echo "-------ls after---------"
ls 
echo 
echo "-------file not exists---------"
./modify.sh -u testestest 
echo
echo "-------no argument given---------"
./modify.sh 
echo
echo "-------wrong command---------"
./modify.sh -k  
# ls -R

# ls -R

# echo "----------------"

# ls -R

# echo "----------------"

# ls -R

# echo "----------------"

# ls -R

# echo "----------------"

# ls -R
