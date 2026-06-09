#!/bin/bash

#conda activate keras_env
module load conda/2022.05
conda activate base

parent_dir="/projects/cnncae/2m_drivAer_r1025_n49/simulations"
starter_dir="/projects/cnncae/2m_drivAer_r1025_n49/starter-files"
output_file="/projects/cnncae/2m_drivAer_r1025_n49/cds.txt"
order_file="/projects/cnncae/2m_drivAer_r1025_n49/samples_ordering.txt"

# clear
> "$output_file"
> "$order_file"

for dir in $(find "$parent_dir" -mindepth 1 -maxdepth 1 -type d | sort); do
  echo "Processing directory: $dir"
  full_path_dir="$parent_dir/$(basename "$dir")"
  cp "$starter_dir/proc.py" "$full_path_dir/"
  cd "$full_path_dir/" || continue
  result=$(python3 proc.py)
  echo "Result from proc.py: $result"
  
  # append the result to the output file
  if [[ -n "$result" ]]; then
    echo "$result" >> "$output_file"
  else
    echo "Warning: No output from proc.py for $dir"
  fi

  basename "$dir" >> "$order_file"
done

