#!/bin/bash

#SBATCH --job-name=sam # you can give your job a name
#SBATCH --nodes 1 # the number of processors or tasks
#SBATCH --cpus-per-task=2
#SBATCH --account=itcga # our account
#SBATCH --reservation=ITCGA2025 # this gives us special access during the workshop
#SBATCH --time=1:00:00 # the maximum time for the job
#SBATCH --mem=4gb # the amount of RAM
#SBATCH --partition=itcga # the specific server in chimera we are using
#SBATCH --error=logs/%x-%A.err   # a filename to save error messages into
#SBATCH --output=logs/%x-%A.out  # a filename to save any printed output into

#Usage: Aligning one trimmed fastq in both directions and outputting it into another file
hisat2 -p 24 -x ~/1_project/data/genome/hg38 \
#Doesn’t need a star because hisat know to look for anything that start with hg38 in the genome file
 -1 /itcgastorage/share_home/truc.bui002/1_project/data/trimmed_fastq/V1_S1_L001_R1_001_ds_trim.fastq \ #first read
 -2 /itcgastorage/share_home/truc.bui002/1_project/data/trimmed_fastq/V1_S1_L001_R2_001_ds_trim.fastq \ #second read
#This is for read one and read two for both directions that has been trimmed
 -S /itcgastorage/share_home/truc.bui002/1_project/results/sam/V1_S1_L001_ds_trim_align.sam

echo "Finished! :)"
