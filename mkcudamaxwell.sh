#!/bin/sh
nvcc -m64 -arch sm_52 cusrc/simpleraykernel.cu -o bin/cudakernels.cubin --cubin
