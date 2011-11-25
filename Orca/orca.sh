#!/bin/bash

SFILE=orca-ompi.sub
WD=$PWD

for j in XRQTC.Orca_BLYP XRQTC.Orca_localCCSD #XRQTC.Orca_B3LYP
	do
        cd $WD/$j

	cat $SFILE | sed s/TEST/$j/g > orca-ompi-${j}
	TFILE=orca-ompi-${j}

	for i in 1 4 6 8 12 16 24
	#for i in 24 32
		do 
		cat $TFILE | sed s/ncores/$i/g > OUT/$TFILE-${i}.sub
		qsub -q nehalem-dp.q OUT/$TFILE-${i}.sub > OUT/$TFILE-${i}.jobid
		sleep 2
		done

	done
	rm $TFILE
