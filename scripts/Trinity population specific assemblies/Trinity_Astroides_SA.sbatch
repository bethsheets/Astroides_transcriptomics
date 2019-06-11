#!/bin/bash 
#SBATCH -p hns,spalumbi
#################
#set a job name  
#SBATCH --job-name=Astroides_SA
#################  
#a file for job output, you can check job progress
#SBATCH --output=Astroides_SA
#################
# a file for errors from the job
#SBATCH --error=Astroides_SA.err
#################
#time limit, default is 2 hours
#SBATCH --time 48:0:0
#number of CPUs
#SBATCH -c 16
#amount of RAM, most hns have 124 or 191
#SBATCH --mem=191G


ml biology trinity/2.8.4/

Trinity --seqType fq --max_memory 191G --CPU 16 --min_contig_length 300 --trimmomatic --monitoring --left /scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X5_1.fq,/scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X6_1.fq,/scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X7_1.fq --right /scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X5_2.fq,/scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X6_2.fq,/scratch/groups/spalumbi/beth/Astroides/raw/fastq/14283X7_2.fq
 
