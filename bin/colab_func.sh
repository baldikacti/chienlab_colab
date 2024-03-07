#!/usr/bin/bash
#SBATCH --job-name=chienlab-colab-run-ba
#SBATCH --partition=gpu
#SBATCH --cpus-per-gpu=2
#SBATCH --constraint=vram16
#SBATCH --gpus-per-node=1
#SBATCH --mem-per-gpu=20G
#SBATCH -t 08:00:00
#SBATCH -o logs/chienlab-colab-run-%j.out

source chienlab_colab.config

fname=$(basename "$1" .fasta)
apptainer run --nv \
  -B ${AFOLD_CACHE}:/cache -B ${WORKDIR}:/work \
  $COLABFOLD_CONTAINER \
  colabfold_batch /work/$1 /work/results/$fname --msa-mode 'mmseqs2_uniref_env'