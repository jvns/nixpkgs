#!/bin/bash

echo $PATH
tar -xf "$SOURCE" -C .
ls
mkdir -p "$out/bin"
mv jj "$out/bin"
