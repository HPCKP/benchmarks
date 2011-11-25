#!/bin/bash

SFILE=vasp-5.2-ompi.sub
mkdir OUT

for j in XRQTC.VASP_DFT
	do

	cat $SFILE | sed s/TEST/$j/g > vasp-5.2-ompi-${j}
	TFILE=vasp-5.2-ompi-${j}

	for i in 2 4 6 8 12 16 24 32
		do 
		cat $TFILE | sed s/ncores/$i/g > OUT/$TFILE-${i}.sub
		qsub -hard -q nehalem-dp.q OUT/$TFILE-${i}.sub > OUT/$TFILE-${i}.jobid
		done

	done
	rm $TFILE

