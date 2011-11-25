#!/bin/bash

#SFILE=$PWD/vasp-5.2-ompi.sub
SFILE=$PWD/vasp-4.6-ompi.sub
WDIR=$PWD
for k in vasp_gamma vasp_cd vasp
do 
for j in XRQTC.VASP_ceria-surface
	do
	cd $WDIR
	cd $j
	mkdir OUT
	rm *.{out,err} 

	cat $SFILE | sed s/TEST/$j/g |sed s/BINVASP/$k/g > vasp-ompi-${j}
	TFILE=vasp-ompi-${j}

	for i in 60
		do 
		cat $TFILE | sed s/ncores/$i/g > OUT/$TFILE-${i}_${k}.sub
		qsub -q iqtc04.q -pe "ompi_*" $i OUT/$TFILE-${i}_${k}.sub > OUT/$TFILE-${i}_${k}.jobid
		sleep 1
		done

	done
	rm $TFILE
done
