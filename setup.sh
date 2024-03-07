#!/usr/bin/bash
#SBATCH --job-name=chienlab-colab-setup-ba   # Job name
#SBATCH --partition=cpu-preempt            # Partition (queue) name
#SBATCH --ntasks=2                   # Number of CPUs
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --mem=16gb                     # Job memory request
#SBATCH --time=01:00:00               # Time limit hrs:min:sec
#SBATCH --output=logs/chienlab-colab-setup-ba_%j.log   # Standard output and error log

# Load modules
module load apptainer/main+py3.8.12

# Initialize variables
source chienlab_colab.config

# Pull Containers if they do not exist
if [ ! -f "$COLABFOLD_CONTAINER" ]; then
  echo "Pulling container ${colabfold:${COLAB_VERSION}-cuda${CUDA_VERSION}}"
  apptainer pull --dir $WORK_BIN docker://ghcr.io/sokrypton/colabfold:${COLAB_VERSION}-cuda${CUDA_VERSION}
fi

if [ ! -f "$R_CONTAINER" ]; then
  echo "Pulling container baldikacti/chienlab_colab:4.3.2"
  apptainer pull --dir $WORK_BIN docker://baldikacti/chienlab_colab:4.3.2
fi

# Setup Alphafold Weights
if [ ! -d "$AFOLD_CACHE" ]; then
  echo "Creating $AFOLD_CACHE"
  echo "Downloading Alphafold weights"
  mkdir $AFOLD_CACHE
  apptainer run -B ${AFOLD_CACHE}:/cache ${COLABFOLD_CONTAINER} python -m colabfold.download
fi
