#!/bin/bash

#SBATCH --job-name=alignment # you can give your job a name
#SBATCH --ntasks=24 # the number of processors or tasks
#SBATCH --account=itcga # our account
#SBATCH --reservation=ITCGA2025 # this gives us special access during the workshop
#SBATCH --time=10:00:00 # the maximum time for the job
#SBATCH --mem=32gb # the amount of RAM
#SBATCH --partition=itcga # the specific server in chimera we are using
#SBATCH --error=logs/%x-%A.err   # a filename to save error messages into
#SBATCH --output=logs/%x-%A.out  # a filename to save any printed output into

# Module Loading
module load gcc-10.2.0-gcc-9.3.0-f3oaqv7
module load python-3.8.12-gcc-10.2.0-oe4tgov
module load hisat2-2.1.0-gcc-9.3.0-u7zbyow

# Define variables
index_dir=$1
input_dir=$2 # takes this from the command line, first item after the script
output_dir=$3 # takes this from the command line, second item

# Loop through R1 files in the input directory
for file in "$input_dir"/*_trimmed_1.fq; do
  # Extract the base name without the suffix (e.g., "C1_S4_L001")
  base=$(basename "$file" _trimmed_1.fq)

  hisat2 -p 24 \
  -x "$index_dir" \
  -1 "$input_dir/${base}_trimmed_1.fq" \
  -2 "$input_dir/${base}_trimmed_2.fq" \
  -S "$output_dir/${base}.sam"

done

echo "Finish Run"
echo "End time: $(date)"

