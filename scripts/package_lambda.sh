#!/bin/bash

cd "$(dirname "$0")"

lambda_build_dir="../build/lambda"

printf "Packaging lambda\n"

mkdir -p $lambda_build_dir
cp -R ../app $lambda_build_dir/app
cd $lambda_build_dir
zip -r lambda.zip .
rm -rf app

printf "Lambda packaged\n"