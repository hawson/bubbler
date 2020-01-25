#!/bin/bash

# AUDIODEV="hw:1,0" rec -S -c 1  -t raw -n spectrogram

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
fi

EXTRA=""
if [[ -n "$3" ]]; then
	EXTRA="-$3"
fi

BIT=16

# This seems to be good enough (and saves space
RATE=8000

FILTER="highpass -1 700 noisered silence.prof 0.1"
FILTER=""

if [[ -z "$FILENAME" ]]; then
	FILENAME="sample-${TS}-B${BIT}R${RATE}${EXTRA}.wav"
fi

#rec -V -S -c 1 -b 16 --rate $RATE sample_$RATE.wav  trim 0 10 

#rec -V --show-progress --no-dither -c 1 -b 8 -t wav --rate $RATE $FILENAME trim 0 $TIME  highpass -1 1200 noisered silence.prof 0.1
#rec -V --show-progress --no-dither -c 1 -b 8 -t wav --rate $RATE $FILENAME trim 0 $TIME
rec -V --show-progress --no-dither -c 1 -b $BIT -t wav --rate $RATE $FILENAME trim 0 $TIME $FILTER


# apply highpass filter and noise reduction
#sox 1min.wav reduct.wav highpass -1 1200   noisered silence.prof 0.1 

