#!/usr/bin/bash
#SBATCH --job-name=chienlab-colab-run-ba
#SBATCH --partition=cpu-preempt
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH -t 01:00:00
#SBATCH -o logs/chienlab-colab-run-%j.out

module load apptainer/main+py3.8.12

# Initialize variables
source chienlab_colab.config

# Read list of Accession IDs and create combined fasta files for colabfold
$R_CONTAINER Rscript bin/combine_fasta.R \
  --acc_file $ACC_FILE \
  --fasta_dir $FASTA_DIR

find $FASTA_DIR -name "*.fasta" | while read f ;
do

sbatch $WORK_BIN/colab_func.sh $f

done