#!/bin/bash

SIMULATION_DIR="/projects/cnncae/2m_drivAer_r1025_n49/simulations"
STARTER_DIR="/projects/cnncae/2m_drivAer_r1025_n49/starter-files"
PP_SCRIPT="pp.slurm"
CHARLES_PP_IN="charles_pp.in"

for DIR in "$SIMULATION_DIR"/*; do
  if [ -d "$DIR" ]; then
    cp "$STARTER_DIR/$PP_SCRIPT" "$DIR/"
    cp "$STARTER_DIR/$CHARLES_PP_IN" "$DIR/"
    cd "$DIR"
    sbatch "$PP_SCRIPT"
  fi
done
