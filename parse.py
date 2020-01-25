#!/usr/bin/env python3

import wave
import struct
from scipy.io import wavfile
import sys


if sys.argv[1]:
    sound_file = sys.argv[1]
else:
    sound_file = 'sound.wav'


# key is bytes
fmt_chars = {
    1: 'b',
    2: 'h',
    4: 'i',
}

WINDOW=10

if __name__ == "__main__":

    obj = wave.open(sound_file,'r')
    FRAME_WIDTH=obj.getsampwidth()
    print( "Number of channels",obj.getnchannels())
    print ( "Sample width " + str(FRAME_WIDTH)+ ' bytes (' + str(FRAME_WIDTH*8) + ' bits)')
    print ( "Frame rate.",obj.getframerate())
    print ("Number of frames",obj.getnframes())
    print ( "parameters:",obj.getparams())

    nframes = obj.getnframes()

    fmt = '<'+fmt_chars[FRAME_WIDTH]

    for i in range(0, nframes, FRAME_WIDTH):
        frame =  obj.readframes(1)
        data = struct.unpack(fmt, frame)
        print(int(data[0]))






