#!/bin/sh
dir=$(pwd)

printHelp(){
echo "---------"
echo "-f		:	path of jmeter script"
echo "-u		:	path of URL(Not Work)"
echo "-user		:	User name"
echo "-password	:	User password"
echo "---------"
exit 0
}
if [ "$1" = "-h" -o "$1" = "--help" ]; then
printHelp
fi 

while [ "$1" ]; do
  key="$1"

  case $key in
       -f)
      folder_of_jmeter="$2"
      shift
      ;;
      -u)
      url="$2"
      shift
      ;;
      -user)
      user="$2"
      shift
      ;;
      -password)
      password="$2"
      shift
      ;;
  esac
  shift
done 


if [ ! $folder_of_jmeter ];
then
folder_of_jmeter=$dir
fi 
rm index.html
directory=`ls -F1 ${folder_of_jmeter} | grep /`
for var in $directory
do
rm $folder_of_jmeter/${var}savedata
jmeter -n -t $folder_of_jmeter/${var}test.jmx -Juser=$user -Jpassword=$password
emails=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'lb="checkResult" rc="\K.*?(?=")')
testName=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'tn="\K.*?(?=")')
echo "<b>Test Name :</b> " >> index.html
echo $testName | { read first rest ; echo $first ; } >> index.html
echo "<BR/><b>Test Run  :</b> " >> index.html
if echo $emails | grep -q "200";
then 
echo "SUCCESS<BR/><BR/>">> index.html
else
echo "FAILED<BR/><BR/>">> index.html
fi
done

