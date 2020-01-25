#!/bin/bash

# AUDIODEV="hw:1,0" rec -S -c 1  -t raw -n spectrogram


# use the USB card
export AUDIODEV="hw:1,0"
RATES="8000 16000 44100 44000"


for RATE in $RATES; do

	rec -V -S -c 1 -b 16 --rate $RATE sample_$RATE.wav  trim 0 10 
	

done

