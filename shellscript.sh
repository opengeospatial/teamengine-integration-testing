#!/bin/sh
dir=$(pwd)

printHelp(){
echo "---------"
echo "-f		:	path of jmeter script"
echo "-u		:	path of URL"
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
port=""
testurl=$(echo $url | tr "/" "\n")
set -- $testurl
server=$(echo $1 | tr ":" "\n")
warName=/$3/
if echo $2 | grep -q ":";
then
urlid=$(echo $2 | tr ":" "\n")
set -- $urlid
host=$1
port=$2
else
host=$2
fi
rm index.html
rm savedata
rm -rf result
directory=`ls -F1 ${folder_of_jmeter} | grep /`
now=$(date +"%Y/%m/%d  %H:%M:%S")
echo "<b>TE integration testing - </b>$now" >> index1.html
echo "<BR/><b>URL :</b> $url<BR/>" >> index1.html
jmeter -n -t $folder_of_jmeter/teamenginePlan.jmx -Juser=$user -Jpassword=$password -Jserver=$server -Jhost=$host -Jport=$port -Jwarname=$warName -Jurl=$url
teVersion=$(cat -n $folder_of_jmeter/savedata | grep "&lt;p&gt;" | tail -2)
teVersion=${teVersion#*&gt;}
teVersion=${teVersion%&lt;\/p*}
finalresult="PASS"
echo "<BR/><b>TE version :</b> $teVersion" >> index1.html
teBuild=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'lb="teamenginetestResult" rc="\K.*?(?=")')
teRegister=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'lb="registrationTest" rc="\K.*?(?=")')
echo "<BR/><b>Default build  :</b> " >> index1.html
if echo $teBuild | grep -q "200";
then 
echo "SUCCESS">> index1.html
else
echo "FAILED">> index1.html
finalresult="FAIL"
fi
echo "<BR/><b>User can be created and logins   :</b> " >> index1.html
if echo $teRegister | grep -q "200";
then 
echo "SUCCESS<BR/>">> index1.html
else
echo "FAILED<BR/>">> index1.html
finalresult="FAIL"
fi
for var in $directory
do
rm $folder_of_jmeter/${var}savedata
jmeter -n -t $folder_of_jmeter/${var}test.jmx -Juser=$user -Jpassword=$password -Jserver=$server -Jhost=$host -Jport=$port -Jwarname=$warName -Jurl=$url
result=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'lb="checkResult" rc="\K.*?(?=")')
formResult=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'lb="formResult" rc="\K.*?(?=")')
testName=$(cat $folder_of_jmeter/${var}savedata | grep -Po 'tn="\K.*?(?=")')
echo "<BR/><b>Test Name :</b> " >> index1.html
echo $testName | { read first rest ; echo $first ; } | cut -c1-3 >> index1.html
string=$(xmllint --xpath "//testResults/httpSample[@lb='formResult']/java.net.URL" $folder_of_jmeter/${var}savedata )
var=$(echo $string | awk -F"&amp;" '{print $1,$2,$3}')
set -- $var
var1=$(echo $3 | awk -F"_" '{print $1,$2,$3,$4}')
set -- $var1
echo " $3 revision $4" >> index1.html
echo "<BR/><b>Test can be run  :</b> " >> index1.html
if echo $formResult | grep -q "200";
then 
echo "SUCCESS">> index1.html
else
echo "FAILED">> index1.html
finalresult="FAIL"
fi
echo "<BR/><b>Test run finishes successfully  :</b> " >> index1.html
if echo $result | grep -q "200";
then 
echo "SUCCESS<BR/>">> index1.html
else
echo "FAILED<BR/>">> index1.html
finalresult="FAIL"
fi
done
mkdir result
if echo $finalresult | grep -q "PASS";
then
echo "<b>Final Result :</b> SUCCESS<BR/><BR/>" >> index.html
echo -n "" > result/SUCCESS
else
echo "<b>Final Result :</b> FAILED<BR/><BR/>" >> index.html
echo -n "" > result/FAIL
fi
index1=$(cat index1.html)
echo $index1 >> index.html
rm index1.html
