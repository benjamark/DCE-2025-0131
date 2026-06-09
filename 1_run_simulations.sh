#!/bin/bash

STL_DIR="/projects/cnncae/didymus/src/projects/drivAer_r1025_n49/surfer-stls"
STARTER_DIR="/projects/cnncae/2m_drivAer_r1025_n49/starter-files"
SIMULATION_DIR="/projects/cnncae/2m_drivAer_r1025_n49/simulations"

mkdir -p "$SIMULATION_DIR"

# iterate over each .stl file in the surfer-stls directory
for STL_FILE in "$STL_DIR"/*.stl; do
  STL_NAME=$(basename "$STL_FILE" .stl)

  TARGET_DIR="$SIMULATION_DIR/$STL_NAME"
  mkdir -p "$TARGET_DIR"

  cp "$STL_FILE" "$TARGET_DIR/car.stl"
  cp "$STARTER_DIR"/* "$TARGET_DIR/"

  cd "$TARGET_DIR"

  sbatch gpu.slurm &
  
  # use below lines for separate cpu/gpu jobs
#  # submit the CPU job
#  CPU_JOB_ID=$(sbatch --parsable cpu.slurm)
#
#  # submit the GPU job with a dependency on the CPU job
#  sbatch --dependency=afterok:$CPU_JOB_ID gpu.slurm &
done

echo "All jobs have been submitted."
