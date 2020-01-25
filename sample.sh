#!/bin/bash

# AUDIODEV="hw:1,0" rec -S -c 1  -t raw -n spectrogram

# This seems to be good enough (and saves space
RATE=8000
MINUTE=60
HOUR=$(($MINUTE * 60))


if [[ -n "$2" ]]; then
	TIME=$2
else
	# seconds
	TIME=60
fi


# use the USB card
export AUDIODEV="hw:1,0"

if [[ -n "$1" ]] && [[ "$1" != '-' ]]; then
	FILENAME=$1
else
	TS=$(date '+%Y%m%d-%H%M%S')
	FILENAME="sample-${TS}.wav"
fi



#rec -V -S -c 1 -b 16 --rate $RATE sample_$RATE.wav  trim 0 10 

rec -V -S -c 1 -b 8 -t raw --rate $RATE $FILENAME trim 0 $TIME  highpass -1 1200 noisered silence.prof 0.1


# apply highpass filter and noise reduction
#sox 1min.wav reduct.wav highpass -1 1200   noisered silence.prof 0.1 

