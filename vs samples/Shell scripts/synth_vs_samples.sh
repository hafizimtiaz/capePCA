#!/bin/bash

## The submit script for MATLAB multicore run.
## It runs matlab threads on one node only.
## 1. Specify the job name in '--job-name='.
## 2. Specify the number of requested CPUs/Cores in '--ntasks-per-node=' 
## 3. Load matlab module: "module purge; module load matlab" 
## 4. Submit the script to the cluster through SLURM: "sbatch matlab_multicore_batch.sh"  


#SBATCH --job-name=synth_s
#SBATCH --output=synth_s.out
#SBATCH --error=synth_s.err
#SBATCH --partition=SOE_main
#SBATCH --ntasks-per-node=4
#SBATCH --mail-type=ALL														
#SBATCH --mail-user=hafiz.imtiaz@rutgers.edu											

MYHDIR=$SLURM_SUBMIT_DIR													
MYTMP="/tmp/$USER/$SLURM_JOB_ID"    												
mkdir -p $MYTMP                     												
cp $MYHDIR/synth_try1.m  $MYTMP
cp $MYHDIR/my_AG.m  $MYTMP
cp $MYHDIR/my_dPCA_hafiz.m  $MYTMP
cp $MYHDIR/my_dPCA_djica.m  $MYTMP
cp $MYHDIR/synth_d_2000_n_60000.mat  $MYTMP


cd $MYTMP                           										

matlab -nodisplay -nosplash -r "synth_try1, exit"

cp $MYTMP/* $MYHDIR                 										
rm -rf  $MYTMP                      										