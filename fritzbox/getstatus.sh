#!/bin/bash
#
# Simple script to read Draytek Vigor 130 modem's VDSL status. This is aimed to see if the SNR changes or not...
#

if [ $# -lt 1 ]; then
	echo "Usage: $0 <modem> <sessionid> <outputdir>"
	exit 99
fi

MODEM=$1
SESSION=$2
OUTPUT=$3

while [ 1 ]
do
	TIME=`date +%s`
	url="http://${MODEM}/internet/dsl_spectrum.lua?sid=${SESSION}&no_sidrenew=1&myXhr=1&useajax=1&xhr=1"
	curl ${url} -s --compressed  -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -o ${OUTPUT}/${TIME}_spectrum.json
	url="http://${MODEM}/internet/dsl_stats_tab.lua?update=mainDiv&sid=${SESSION}&useajax=1&xhr=1"
	curl ${url} -s --compressed  -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -o ${OUTPUT}/${TIME}_dslstats.html
	sleep 10
done

