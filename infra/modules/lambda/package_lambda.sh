#!/bin/bash

# Package a lambda function
#
# Parameters:
#   $1: Lambda name
#   $2: Lambda source directory
#   $2: Build directory
#
# Example:
#   ./package_lambda.sh app_lambda ../../../app ../../../build/lambda

cd "$(dirname "$0")"

printf "Packaging lambda $1\n"

mkdir -p $3
cp -R $2 $3/$1

cd $3/$1
rm -rf __pycache__/
rm *.pyc

cd $3
zip -r $1.zip .
rm -rf $1

printf "Lambda $1 packaged\n"