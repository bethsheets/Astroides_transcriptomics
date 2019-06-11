#!/bin/bash
#USAGE: bash batch-hisat2-fq-paired.sh index 4 *_1.txt.gz
#if you don't have a hisat2 index, build it with "hisat2-build <reference>.fa basename"
module load java
CHUNK=$2
COUNTER=0
FQ="${@:3}"
for i in $FQ; do
    if [ $COUNTER -eq 0 ]; then
    echo -e "#!/bin/bash\n#SBATCH -p owners\n#SBATCH --ntasks=1\n#SBATCH --cpus-per-task=3\n#SBATCH -t 12:00:00\n#SBATCH --mem 24000" > TEMPBATCH.sbatch; fi
    BASE=$(basename $(basename $(basename $( basename $i .gz) .txt) .fq) .fastq)
    echo "srun hisat2 --end-to-end --very-sensitive --no-spliced-alignment -p 3 -X 1500 --rg-id $BASE --rg SM:$BASE -x $1 -1 ${BASE}_1.txt.gz -2 ${BASE}_2.txt.gz > $BASE.sam" >> TEMPBATCH.sbatch
    echo "samtools view -bSq 10 ${BASE}.sam > ${BASE}_BTVS-UNSORTED.bam " >> TEMPBATCH.sbatch
    echo "srun samtools sort ${BASE}_BTVS-UNSORTED.bam > ${BASE}_UNDEDUP.bam" >> TEMPBATCH.sbatch
    echo "srun java -Xmx4g -jar /share/PI/spalumbi/programs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true INPUT=${BASE}_UNDEDUP.bam OUTPUT=${BASE}.bam METRICS_FILE=${BASE}-metrics.txt VALIDATION_STRINGENCY=LENIENT" >> TEMPBATCH.sbatch 
    echo "srun samtools index ${BASE}.bam" >> TEMPBATCH.sbatch
    echo "rm ${BASE}.sam" >> TEMPBATCH.sbatch
    echo "rm ${BASE}_BTVS-UNSORTED.bam" >> TEMPBATCH.sbatch
    echo "rm ${BASE}_UNDEDUP.bam" >> TEMPBATCH.sbatch
    let COUNTER=COUNTER+1
    if [ $COUNTER -eq $CHUNK ]; then
    sbatch TEMPBATCH.sbatch
    COUNTER=0; fi
done
if [ $COUNTER -ne 0 ]; then
sbatch TEMPBATCH.sbatch; fi 
