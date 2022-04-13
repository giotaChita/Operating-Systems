#!/usr/bin/bash

echo "create directories..."
mkdir "university"
mkdir "university/SUMMERCOURS"
mkdir "university/wintercours" 
mkdir "university/wintercours/OPTICALFIBER"
mkdir "university/wintercours/SAE"
mkdir "university/wintercours/deepLearning"
mkdir "university/SUMMERCOURS/telecommunations"
mkdir "university/SUMMERCOURS/AI"
mkdir "university/SUMMERCOURS/optimization" 
touch "university/wintercours/dir"
chmod +x "university/wintercours/dir"
touch "university/SUMMERCOURS/SHELL"
chmod +x "university/SUMMERCOURS/SHELL"

echo "create files for testing"
touch testfile 
chmod +x testfile
touch TESTFORL
chmod +x TESTFORL
touch testingSED
chmod +x testingSED
echo "--------help--------"
echo "modify -h"
../task1.sh -h

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
echo
echo "-------recursive sed---------"
./modify.sh -r s/e/E/g /home/giota/university
echo
echo "-------recursive upper---------"
./modify.sh -r -u /home/giota/univErsity
echo
echo "-------recursive lower---------"
./modify.sh -r -l /home/giota/UNIVERSITY 

