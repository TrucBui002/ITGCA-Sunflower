#!/bin/bash

#SBATCH --job-name=trim # you can give your job a name
#SBATCH --nodes 1 # the number of processors or tasks
#SBATCH --cpus-per-task=2
#SBATCH --account=itcga # our account
#SBATCH --reservation=ITCGA2025 # this gives us special access during the workshop
#SBATCH --time=10:00:00 # the maximum time for the job
#SBATCH --mem=4gb # the amount of RAM
#SBATCH --partition=itcga # the specific server in chimera we are using
#SBATCH --error=logs/%x-%A.err   # a filename to save error messages into
#SBATCH --output=logs/%x-%A.out  # a filename to save any printed output into

# Usage: sbatch cutadapt.sh path/to/input_dir path/to/output_dir
# Works for paired end reads where both end in the same *_001_downsampled.fastq

# Module load (load cutadapt & its dependency, in this case it's dnaio and xopen)
# This is all being run in python
module load py-dnaio-0.4.2-gcc-10.2.0-gaqzhv4
module load py-xopen-1.1.0-gcc-10.2.0-5kpnvqq
module load py-cutadapt-2.10-gcc-10.2.0-2x2ytr5

# Define variables
input_dir=$1 # takes this from the command line, first item after the script
# First command line input gets saved into input_dir
output_dir=$2 # takes this from the command line, second item
# Second command line input gets saved into output_dir

# For each files that ends with R1_etc, look in input_dir/$1 for files
# which containing the name *_R1_001_downsampled.fastq
# Use bracket to specify the variable and keep it contain
for base in "$input_dir"/*_1.fq; do
 	# Pull basename
 	# File will only be saved as anything before R1 (give it unique name)
 	name=$(basename "$base" _1.fq)

 # Run cutadapt
 # It's going to look into the input and look for read 1&2 and trimmed it
 # It'll then put it into the output as renamed as trim
 # \ allow line break and still be read as one line of code
 cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
 -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --trim-n \
 -m 25 \
 -o "${output_dir}/${name}_trimmed_1.fq" \
 -p "${output_dir}/${name}_trimmed_2.fq" \
 "${input_dir}/${name}_1.fq" \
 "${input_dir}/${name}_2.fq"

 # Four loop is there only for R1 as a sample to indicate that specific file is finished
 echo "cutadapt is finished with ${name}"

done

 echo "Totally done! :D"

