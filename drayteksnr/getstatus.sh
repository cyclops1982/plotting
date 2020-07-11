#!/bin/bash
#
# Simple script to read Draytek Vigor 130 modem's VDSL status. This is aimed to see if the SNR changes or not...
#

if [ $# -lt 1 ]; then
	echo "Usage: $0 <modem> <session key> <outputfile>"
	exit 99
fi

MODEM=$1
SESSION=$2
OUTPUT=$3

if [ ! -e ${OUTPUT} ]
then
	echo "Timestamp, LinkStatus, FirmwareVersion, Profile, Upstream, Downstream, SNR1, SNR2" > ${OUTPUT}
fi

while [ 1 ]
do
	url="http://${MODEM}/doc/online1.sht"
	curl ${url} -s --compressed -H "Cookie: SESSION_ID_VIGOR=${SESSION}" | grep -i -o -E "##VDSL2##([^'.*]*)" > tmp
	LINKSTATUS=`cat tmp  | sed -n -e 's/^.*##Link Status:\t\([A-Z]*\).*$/\1/p' | tr -d '[:space:]'`
	FIRMWARE=`cat tmp  | sed -n -e 's/^.*##Firmware Version:\t\([0-9A-F-]*\).*$/\1/p' | tr -d '[:space:]'`
	PROFILE=`cat tmp  | sed -n -e 's/^.*##VDSL2 Profile:\t\([0-9A-F-]*\).*$/\1/p' | tr -d '[:space:]'`
	UPSTREAM=`cat tmp  | sed -n -e 's/^.*##Actual Data Rate:\t\([ 0-9]*\).*$/\1/p' | tr -d '[:space:]'`
	DOWNSTREAM=`cat tmp  | sed -n -e 's/^.*##Actual Data Rate:\t[ 0-9]*\t\(.*\)\t.*##.*$/\1/p' | tr -d '[:space:]'`
	SNR1=`cat tmp  | sed -n -e 's/^.*##SNR:\t\([0-9]\)*/\1/p' | cut -f 2 -d ' ' | tr -d '[:space:]'`
	SNR2=`cat tmp  | sed -n -e 's/^.*##SNR:\t\([0-9]\)*/\1/p' | cut -f 4 -d ' ' | tr -d '[:space:]'`
	TSTAMP=`date +%s`
	#echo "${TSTAMP}, ${LINKSTATUS}, ${FIRMWARE}, ${PROFILE}, ${UPSTREAM}, ${DOWNSTREAM}, ${SNR1}, ${SNR2}"
	echo "${TSTAMP}, ${LINKSTATUS}, ${FIRMWARE}, ${PROFILE}, ${UPSTREAM}, ${DOWNSTREAM}, ${SNR1}, ${SNR2}" >> ${OUTPUT}
	sleep 10
done

