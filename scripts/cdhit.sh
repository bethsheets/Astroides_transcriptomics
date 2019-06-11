#!/bin/sh
#SBATCH -p hns,spalumbi
#SBATCH --mail-type=FAIL
#time limit, default is 2 hours
#SBATCH --time 48:0:0
#number of CPUs
#SBATCH -c 8
#amount of RAM, most hns have 124 or 191
#SBATCH --mem=16G

#usage: sbatch cdhit.sh input output
# c= 98% sequence identity threshold
# l = length of throw away sequences

/home/groups/spalumbi/programs/cdhit/cd-hit -i $1 -o $2 -c 0.98 -M 1600 -T 8 -l 500
