echo "Plese enter the option:"
echo "1. Lower to Upper"
echo "2. Upper to Lower"
echo "3. quit"
echo "enter choice"
read ch
case "$ch" in

1) echo "etner file:"
read file 
if [ -f $file]
then 
echo "lower to upper:"
tr '[a-z]' '[A-Z]' <$file
else
echo "$file does not exist"
fi
;;
2) echo "enter file"
read file
if [ -f $file]
echo " form upper to lower:"
tr '[A-Z]' '[a-z]' <$file
else 
echo "$file does not exists"
fi
;;
3) *)
echo "Exit"
exit;;
