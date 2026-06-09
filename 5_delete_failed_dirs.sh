#!/bin/bash

simulations_dir="/projects/cnncae/2m_drivAer_r1025_n49/simulations"
base_dir="/projects/cnncae/2m_drivAer_r1025_n49"
failed_meshing_file="$base_dir/failed_meshes.txt"

while IFS= read -r dir_name; do
  sim_dir_path="$simulations_dir/$dir_name"
  
  if [ -d "$sim_dir_path" ]; then
    echo "Deleting $sim_dir_path"
    rm -rf "$sim_dir_path"
  else
    echo "Directory $sim_dir_path does not exist"
  fi
done < "$failed_meshing_file"

