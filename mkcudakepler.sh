#!/bin/sh
nvcc -m64 -arch sm_21 cusrc/simpleraykernel.cu -o bin/cudakernels.cubin --cubin
