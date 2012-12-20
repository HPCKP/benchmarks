#!/bin/bash 
# Amber PMEMD SubmitScript 
# Optimized for run parallel job of 64 Cores at NeSI (Pandora-SandyBridge)
##########################################################################
#@ job_name = TEST
#@ class = default
#@ group = nesi
#@ notification = never
#@ account_no = uoa
#@ wall_clock_limit = 6:00:00
#@ resources = ConsumableMemory(4096mb) ConsumableVirtualMemory(4096mb)
#@ job_type = MPICH
#@ initialdir = $HOME
#@ output = ${job_name}.${jobid}.out
#@ error = ${job_name}.${jobid}.err
#@ requirements = (Feature=="sandybridge")
#@ total tasks = ncores
#@ node_usage = not_shared
#@ queue
########################################################################## 
###  Load the Enviroment for Amber
. /etc/profile.d/modules.sh
module load amber
########################################################################## 
###  The io files will be allocated in the local scratch FS ($TMPDIR)
###  The shared input files will be allocated in the $INPUTDIR (inside $HOME)
cd $TMPDIR
cp -pr $HOME/benchmarks/AMBER/TEST/input/* .
export INPUTDIR=$HOME/benchmarks/AMBER/TEST/input
########################################################################## 
###  Run the Parallel Program
export OMP_NUM_THREADS=1
ulimit -l unlimited

A1=ispfv_trxm1_04_din
A2=ispfv_trxm1
A3=ispfv_trxm1_03_din
A4=rst

MPIRUN pmemd        \
        -i   $INPUTDIR/$A1.in     \
        -o   $TMPDIR/$A1.out           \
        -p   $INPUTDIR/$A2.top        \
        -c   $INPUTDIR/$A3.$A4         \
        -ref $INPUTDIR/$A3.$A4         \
        -r   $TMPDIR/$A1.rst           \
        -e   $TMPDIR/$A1.mden          \
        -x   $TMPDIR/$A1.mdcrd         \
        -v   $TMPDIR/$A1.mdvel         \
        -l   $TMPDIR/$A1.logfile       \
        -inf $TMPDIR/$A1.inf

########################################################################## 
###  Transfering the results to the home directory ($HOME) 
mkdir $HOME/benchmarks/AMBER/TEST/OUT
cp -pr $TMPDIR $HOME/benchmarks/AMBER/TEST/OUT/
