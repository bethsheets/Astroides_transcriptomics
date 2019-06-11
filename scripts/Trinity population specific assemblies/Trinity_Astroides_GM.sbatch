#!/bin/bash 
#SBATCH -p hns,spalumbi
#SBATCH --mail-type=FAIL
#################
#set a job name  
#SBATCH --job-name=Astroides_GM
#################  
#a file for job output, you can check job progress
#SBATCH --output=Astroides_GM
#################
# a file for errors from the job
#SBATCH --error=Astroides_GM.err
#################
#time limit, default is 2 hours
#SBATCH --time 48:0:0
#number of CPUs
#SBATCH -c 16
#amount of RAM, most hns have 124 or 191
#SBATCH --mem=191G

ml biology trinity/2.8.4/

Trinity --seqType fq --max_memory 191G --CPU 16 --min_contig_length 300 --trimmomatic --monitoring --left /scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X1_1.fq,/scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X2_1.fq,/scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X3_1.fq,/scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X4_1.fq --right /scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X1_2.fq,/scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X2_2.fq,/scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X3_2.fq,/scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X4_2.fq

 
