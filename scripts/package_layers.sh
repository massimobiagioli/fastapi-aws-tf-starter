#!/bin/bash

cd "$(dirname "$0")"

requirements_dir="../requirements/layers"
output_dir="../build/layers"

mkdir -p "$output_dir"

for file in $requirements_dir/requirements_*.txt; do
    layer_name=$(basename "$file" .txt)
    layer_name=${layer_name#"requirements_"}_layer    
    layer_dir="$output_dir/$layer_name"

    printf "Packaging layer: $layer_name\n"
    
    pip install \
        --platform manylinux2014_x86_64 \
        --implementation cp \
        --only-binary=:all: \
        --upgrade \
        -r "$file" \
        -t "$layer_dir/python"

    cd "$layer_dir"
    zip -r "$layer_name.zip" .
    rm -rf "python"

    printf "Layer packaged: $layer_name\n"
done