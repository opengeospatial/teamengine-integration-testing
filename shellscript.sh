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
if [ ! $url ];
then
url="http://cite.opengeospatial.org/te2/"
fi
i=0
testurl=$(echo $url | tr "/" "\n")
set -- $testurl
server=$(echo $1 | tr ":" "\n")
host=$2
warName=/$3/
rm index.html
rm savedata
directory=`ls -F1 ${folder_of_jmeter} | grep /`
now=$(date +"%Y/%m/%d  %H:%M:%S")
echo "<b>TE integration testing - </b>$now<BR/>" >> index.html
jmeter -n -t $folder_of_jmeter/teamenginePlan.jmx -Juser=$user -Jpassword=$password -Jserver=$server -Jhost=$host -Jwarname=$warName -Jurl=$server://$host/$warName/
teVersion=$(cat -n $folder_of_jmeter/savedata | grep "&lt;p&gt;" | tail -2)
teVersion=${teVersion#*&gt;}
teVersion=${teVersion%&lt;\/p*}
echo "<BR/><b>TE version :</b> $teVersion" >> index.html
teBuild=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'lb="teamenginetestResult" rc="\K.*?(?=")')
teRegister=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'lb="registrationTest" rc="\K.*?(?=")')
echo "<BR/><b>Default build  :</b> " >> index.html
if echo $teBuild | grep -q "200";
then 
echo "SUCCESS">> index.html
else
echo "FAILED">> index.html
fi
echo "<BR/><b>User can be created and logins   :</b> " >> index.html
if echo $teRegister | grep -q "200";
then 
echo "SUCCESS<BR/>">> index.html
else
echo "FAILED<BR/>">> index.html
fi
for var in $directory
do
rm $folder_of_jmeter/${var}savedata
jmeter -n -t $folder_of_jmeter/${var}test.jmx -Juser=$user -Jpassword=$password -Jserver=$server -Jhost=$host -Jwarname=$warName -Jurl=$server://$host/$warName/
result=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'lb="checkResult" rc="\K.*?(?=")')
formResult=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'lb="formResult" rc="\K.*?(?=")')
testName=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'tn="\K.*?(?=")')
echo "<BR/><b>Test Name :</b> " >> index.html
echo $testName | { read first rest ; echo $first ; } >> index.html
echo "<BR/><b>Test can be run  :</b> " >> index.html
if echo $formResult | grep -q "200";
then 
echo "SUCCESS">> index.html
else
echo "FAILED">> index.html
fi
echo "<BR/><b>Test run finishes successfully  :</b> " >> index.html
if echo $result | grep -q "200";
then 
echo "SUCCESS<BR/>">> index.html
else
echo "FAILED<BR/>">> index.html
fi
done

