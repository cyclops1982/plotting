#!/bin/bash
#
# Simple script to read Draytek Vigor 130 modem's VDSL status. This is aimed to see if the SNR changes or not...
#
OUTPUT=output.csv
CARID[0]="0b1ddf5e-3094-46f6-a172-33ce342ee463"
CARID[1]="c7b66665-de6c-41b4-b51f-6a41dbc10a88"
CARID[2]="1f9c1ee6-b72d-4f90-b811-a931fb85674b"
CARID[3]="9c6947d3-239d-473a-b5cf-0ac70b389d51"


if [ ! -e ${OUTPUT} ]
then
	echo "Timestamp, CarId, HTTPResponse, time_namelookup, time_connect, time_appconnect, time_pretransfer, time_redirect, time_starttransfer, time_total" > ${OUTPUT}
fi

while [ 1 ]
do
	for index in ${!CARID[*]}
	do
		URL="https://europe-west1-fcg-dev-4.cloudfunctions.net/ar_k2-gateway/car/${CARID[$index]}/categories/purchase-documents"
		TSTAMP=`date +%s`
		TIMING=`curl -s -o /dev/null -w "@curl-format.txt" -H "accept: application/json" -X GET $URL`
		echo ${TSTAMP}, ${CARID[$index]}, $TIMING
		echo ${TSTAMP}, ${CARID[$index]}, $TIMING >> ${OUTPUT}
	done
	sleep 3
done

