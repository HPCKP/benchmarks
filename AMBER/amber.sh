#!/bin/bash

SFILE=$PWD/amber-ompi.ll
WDIR=$PWD
for j in XRQTC.Amber_ispfv
	do
	cd $WDIR
	cd $j
	mkdir OUT
	rm *.{out,err} 

	cat $SFILE | sed s/TEST/$j/g > amber-5.2-ompi-${j}
	TFILE=amber-5.2-ompi-${j}

	for i in 1 6 12 24 36 48 60
		do 
		cat $TFILE | sed s/ncores/$i/g > OUT/$TFILE-${i}_${k}.sub
		#qsub -q iqtc04.q -pe "ompi_*" $i OUT/$TFILE-${i}_${k}.sub > OUT/$TFILE-${i}_${k}.jobid
		llsubmit OUT/$TFILE-${i}_${k}.sub > OUT/$TFILE-${i}_${k}.jobid
		sleep 1
		done

	rm $TFILE
done
