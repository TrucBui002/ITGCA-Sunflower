#!/bin/bash

#SBATCH --job-name=fastqc # you can give your job a name
#SBATCH --nodes 1 # the number of processors or tasks
#SBATCH --cpus-per-task=2
#SBATCH --account=itcga # our account
#SBATCH --time=10:00:00 # the maximum time for the job
#SBATCH --mem=4gb # the amount of RAM
#SBATCH --partition=itcga # the specific server in chimera we are using
#SBATCH --reservation=ITCGA2025 # we have reserved access
#SBATCH --error=logs/%x-%A.err   # a filename to save error messages into
#SBATCH --output=logs/%x-%A.out # a filename to save any printed output into

module load fastqc-0.11.9-gcc-10.2.0-osi6pqc # I am telling Chimera to load the module 

fastqc -o /itcgastorage/share_home/truc.bui002/sunflower_project/results/fastqc/ \
 /itcgastorage/share_home/truc.bui002/sunflower_project/data/raw_fastq/*.fq
 # running fastqc program on ALL the raw files in my data folder using direct pathway. I've also found a way to direct outputs into a specific directiory 

#mv /itcgastorage/share_home/truc.bui002/1_project/data/*fastqc* /itcgastorage/share_home/truc.bui002/1_project/results
# telling the script to put result into specific path

echo "Script Finished!"
