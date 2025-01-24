#!/bin/bash

#SBATCH --job-name=sam_to_bam # you can give your job a name
#SBATCH --ntasks=24 # the number of processors or tasks
#SBATCH --account=itcga # our account
#SBATCH --reservation=ITCGA2025 # this gives us special access during the workshop
#SBATCH --time=10:00:00 # the maximum time for the job
#SBATCH --mem=32gb # the amount of RAM
#SBATCH --partition=itcga # the specific server in chimera we are using
#SBATCH --error=logs/%x-%A.err   # a filename to save error messages into
#SBATCH --output=logs/%x-%A.out  # a filename to save any printed output into

# Usage: Convert sam to bam format

# Module load
module load samtools-1.10-gcc-9.3.0-flukja5

# Define the input directory and output directory
input_dir=$1 # look for sam directory
output_dir=$2 # look for bam directory

# Loop through .sam files in the input directory
for file in "$input_dir"/*.sam; do
  # Extract the base name without the suffix (e.g., "C1_S4_L001")
  base=$(basename "$file" .sam)

  # Convert SAM to BAM using samtools
  samtools view -S -b "$file" > "$output_dir/${base}.bam"
done

echo "Finish Run"
echo "End time: $(date)"

