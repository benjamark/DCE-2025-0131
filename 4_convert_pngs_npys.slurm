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

module load conda/2022.05
#conda activate base
conda activate cti_img

STARTER_DIR="/projects/cnncae/2m_drivAer_r1025_n49/starter-files"
SIMULATION_DIR="/projects/cnncae/2m_drivAer_r1025_n49/simulations"
FAILED_MESHES_FILE="/projects/cnncae/2m_drivAer_r1025_n49/failed_meshes.txt"
EXCLUDE_DIRS=($(cat "$FAILED_MESHES_FILE"))

for DIR in "$SIMULATION_DIR"/*; do
    if [ -d "$DIR" ]; then
        DIR_NAME=$(basename "$DIR")
        if [[ ! " ${EXCLUDE_DIRS[@]} " =~ " ${DIR_NAME} " ]]; then
            cp "$STARTER_DIR/save_npy.py" "$DIR/"
            cp "$STARTER_DIR/cti_image.py" "$DIR/"
            cd "$DIR"
            python3 save_npy.py
        fi
    fi
done

echo "Processing completed."

