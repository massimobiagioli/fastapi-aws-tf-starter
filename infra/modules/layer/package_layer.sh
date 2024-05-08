#!/bin/bash

# Package a layer for a Lambda function
#
# Parameters:
#   $1: Layer name
#   $2: Path of the requirements file
#   $3: Build directory
#
# Example:
#   ./package_layer.sh fastapi_layer ../../../requirements_layer_fastapi.txt ../../../build/layers

cd "$(dirname "$0")"

layer_dir="$3/$1"

mkdir -p "$layer_dir"

printf "Packaging layer: $1\n"

pip install \
    --platform manylinux2014_x86_64 \
    --implementation cp \
    --only-binary=:all: \
    --upgrade \
    -r "$2" \
    -t "$layer_dir/python"

cd "$layer_dir"
zip -r "$1.zip" .
mv "$1.zip" "../$1.zip"
rm -rf "../$1"

printf "Layer packaged: $1\n"
