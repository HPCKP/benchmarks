#!/bin/bash

SFILE=gromacs-ompi.sub

for j in XRQTC.Gromacs_DSPC
	do

	cat $SFILE | sed s/TEST/$j/g > gromacs-ompi-${j}
	TFILE=gromacs-ompi-${j}

	for i in 1 4 6 8 12 16 24
	#for i in 24 32
		do 
		cat $TFILE | sed s/ncores/$i/g > OUT/$TFILE-${i}.sub
		qsub -q nehalem-dp.q OUT/$TFILE-${i}.sub > OUT/$TFILE-${i}.jobid
		sleep 2
		done

	done
	rm $TFILE
