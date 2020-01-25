#!/bin/bash

F=${1:-sample-20200125-170527-B16R8000-timestamped.wav}
L=low.wav
N=nreduct.wav

SSTART=15
SEND=18
NPROF=${F/wav/profile}



sox $F -n  spectrogram -o orig.png 
sox $F -n  noiseprof ${NPROF}

sox $F --rate 2000 $L sinc -1k
sox $L -n spectrogram -o ${L/wav/png}

sox $F $N noisered ${NPROF} 0.1 
sox $N -n spectrogram -o nreduct.png
