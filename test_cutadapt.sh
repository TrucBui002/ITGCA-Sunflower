#!/bin/bash

#SBATCH --job-name=cutadapt # you can give your job a name
#SBATCH --nodes 1 # the number of processors or tasks
#SBATCH --cpus-per-task=2
#SBATCH --account=itcga # our account
#SBATCH --time=1:00:00 # the maximum time for the job
#SBATCH --mem=4gb # the amount of RAM
#SBATCH --partition=itcga # the specific server in chimera we are using
#SBATCH --reservation=ITCGA2025 # we have reserved access
#SBATCH --error=logs/%x-%A_%Y-%m-%d-%H-%M.err   # a filename to save error messages $
#SBATCH --output=logs/%x-%A_%Y-%m-%d-%H-%M.out  # a filename to save any printed messages

module load py-dnaio-0.4.2-gcc-10.2.0-gaqzhv4
module load py-xopen-1.1.0-gcc-10.2.0-5kpnvqq
module load py-cutadapt-2.10-gcc-10.2.0-2x2ytr5

cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --trim-n -m 25 -o /itcgastorage/share_home/truc.bui002/1_project/data/C1_S4_L001_R1_001_downsampled_trimmed.fastq -p/itcgastorage/share_home/truc.bui002/1_project/data/C1_S4_L001_R2_001_downsampled_trimmed.fastq /itcgastorage/share_home/truc.bui002/1_project/data/C1_S4_L001_R1_001_downsampled.fastq /itcgastorage/share_home/truc.bui002/1_project/data/C1_S4_L001_R2_001_downsampled.fastq

echo "Script done :)"
