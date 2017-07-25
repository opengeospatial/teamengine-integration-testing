#!/bin/bash

if [ -n "$1" ]; then
    csvfile="$1"
else
    echo "[Error] The Input CSV file not provided."
    exit 0;	
fi
#Array of tests present in te-integration script
tests=( "csw" "gml32" "sos10" "wms13" "kml22" "wfs" )


while IFS=, read col1 col2
do

if [ "$col1" != "" ] && [ "$col2" != "" ] && [ -n "$col1" ]; then

	curr_dir=$(pwd)	
	if [ -f "$curr_dir/test.properties" ]; then
		for i in "${tests[@]}"
		do
		    testResult=$(grep -q "$i" <<< $col1 && echo "true" || echo "false")
		
		    if [ "$testResult" = "true" ]; then
			
			sed -i "/$i.revision=/c $i.revision=$col2" test.properties 
			
		    fi
		done
	fi
fi

done < $csvfile
