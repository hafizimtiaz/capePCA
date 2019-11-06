#!/bin/bash

## The submit script for MATLAB multicore run.
## It runs matlab threads on one node only.
## 1. Specify the job name in '--job-name='.
## 2. Specify the number of requested CPUs/Cores in '--ntasks-per-node=' 
## 3. Load matlab module: "module purge; module load matlab" 
## 4. Submit the script to the cluster through SLURM: "sbatch matlab_multicore_batch.sh"  


#SBATCH --job-name=mnist_s
#SBATCH --output=mnist_s.out
#SBATCH --error=mnist_s.err
#SBATCH --partition=SOE_main
#SBATCH --ntasks-per-node=4
#SBATCH --mail-type=ALL														
#SBATCH --mail-user=hafiz.imtiaz@rutgers.edu											

MYHDIR=$SLURM_SUBMIT_DIR													
MYTMP="/tmp/$USER/$SLURM_JOB_ID"    												
mkdir -p $MYTMP                     												
cp $MYHDIR/mnist_try1.m  $MYTMP
cp $MYHDIR/my_AG.m  $MYTMP
cp $MYHDIR/my_dPCA_hafiz.m  $MYTMP
cp $MYHDIR/my_dPCA_djica.m  $MYTMP
cp $MYHDIR/mnist_d_784_n_60000.mat  $MYTMP


cd $MYTMP                           										

matlab -nodisplay -nosplash -r "mnist_try1, exit"

cp $MYTMP/* $MYHDIR                 										
rm -rf  $MYTMP                      										