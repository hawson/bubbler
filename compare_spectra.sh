#!/bin/bash

F=${1:-sample-20200125-170527-B16R8000-timestamped.wav}
L=low.wav
N=nreduct.wav

RATE=2000

SSTART=15
SEND=18
NPROF=${F/wav/profile}

echo Source: $F
echo LowPass: $L
echo NR: $N

echo "Profiling noise from $SSTART to $SEND"
sox $F -n  noiseprof ${NPROF}

echo "Low pass filter @ $RATE Hz"
sox $F --rate $RATE $L sinc -1k

echo "Noise reduction..."
sox $F $N noisered ${NPROF} 0.1 

echo "Noise reduction on LP output"
sox $N LP-$N noisered ${NPROF} 0.1 

echo "Spectrograms..."
sox $F    -n spectrogram -o orig.png 
sox $L    -n spectrogram -o ${L/wav/png}
sox $N    -n spectrogram -o nreduct.png
sox LP-$N -n spectrogram -o LP-nreduct.png

for file in $F $L $N LP-$N; do
	echo "parsing/dumping $file"
	./parse.py $file | tail -n +6 | nl > ${file/wav/dat}
done

