#!/bin/bash 
#SBATCH -p hns,owners
#SBATCH --time=48:00:00
#SBATCH --mem=32000
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
########################
# -outfmt 5
# to call: sbatch blastx-uniprot.sh input.fa

#this echoes your TEMP file name to the slurm output in case any files are aborted on owners nodes or have errors
echo $1

#blast against uniprot_db
#remember to update the uniprot database on sherlock regularly

ml biology ncbi-blast+/2.7.1
blastx -db /scratch/groups/spalumbi/BLAST_db/uniprot_trembl/uniprot_sprot_trembl_April2019 -query $1 -out $1.blast.out -evalue 0.001 -max_hsps 1 -num_threads 6 -outfmt 5

