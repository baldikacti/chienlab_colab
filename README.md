# Chienlab Colab

**chienlab_colab** is a convenience pipeline for using [ColabFold](https://github.com/sokrypton/ColabFold) in the [Unity HPC](https://unity.rc.umass.edu/index.php) cluster in a more user friendly and high-throughtput way. This pipeline is meant for setting a bait protein and number of other proteins where you want to have structure predictions for **bait:pray**.

Briefly, you will only need to provide a list of [Uniprot](https://www.uniprot.org/) accession values of proteins and a bait status of each protein in a csv file, and the pipeline will do the rest for you.

## Pipeline Summary

This pipeline will perform the following steps:

1. Read the accession list and generate pairs based on the bait status
2. Pull amino acid fasta files for each protein
3. Generate bait-pray pairs and export them as fasta files
4. Paired fasta files will be fed into colabfold_batch to generate paired structure predictions

## Installation

**Warning**: This pipeline is setup to be run on the [Unity HPC](https://unity.rc.umass.edu/index.php) cluster. It will not run on other systems, however, it won't be particularly hard to set it up to for other system, but it is not my priority right now.

1. Git clone the repository

It is better to clone to repository somewhere in your `/work` directory.

``` 
git clone https://github.com/baldikacti/chienlab_colab.git
```

2. Open **chienlab_colab.config** file and modify the environment variable paths.
3. Run the `setup.sh` script to setup the containers and alphafold weights

This will take about 20 minutes, but it will only needs to be run once.

It will download 2 containers that the pipeline requires and setup the weights required for colabfold_batch in the directory called **cache**. If you delete this directory, you need to run the `setup.sh` again to rebuild the weights.

```
sbatch setup.sh
```
4. Done!

## Run Pipeline

1. Create an accession csv file with the accession numbers of your proteins of interest.

Example can be found in `tests/acclist.csv` file.

**geneID:** Uniprot accession numbers for proteins

**bait:** **1** for bait **0** for prey proteins.

| geneID   | bait  |
| :------: | :--:  |
| P41797   | 1     |
| P25685   | 0     |
| Q9UNE7   | 0     |
| Q02790   | 0     |

In this example the protein pairs will be **P41797:P25685, P41797:Q9UNE7, P41797:Q02790**.

2. Run the pipeline

```
sbatch main.sh
```

3. Voila!  

Your results will pop up in a directory called `results` and each pair prediction will be in a separate directory.
