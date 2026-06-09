#!/bin/bash
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --time=4:00:00
#SBATCH --partition=shared
#SBATCH --mem-per-cpu=32G
#SBATCH --account=cnncae
#SBATCH --job-name=charles
#SBATCH -o job.cpu.out

source ~/.bashrc

conda activate base

cp ./starter-files/concat_npys.py .

python3 concat_npys.py
