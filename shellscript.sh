#!/bin/sh
dir=$(pwd)
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
echo $folder_of_jmeter 
rm index.html
directory=`ls -F1 ${folder_of_jmeter} | grep /`
for var in $directory
do
rm $folder_of_jmeter/${var}savedata
jmeter -n -t $folder_of_jmeter/${var}CSW2_0_2.jmx -Juser=$user -Jpassword=$password
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

