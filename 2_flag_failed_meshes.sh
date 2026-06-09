#!/bin/bash

output_file="failed_meshes.txt"
> $output_file

for dir in simulations/*; do
  if [ ! -f "$dir/mesh.mles" ]; then
    echo $(basename $dir) >> $output_file
  fi
done

