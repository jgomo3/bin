#!/bin/bash

# Usage: sampledir <size> <src> <dst>

# Depends on:
# * parallel

size=$1
src=$2
dst=$3

find $src -type f | shuf -n $size | parallel -X cp {} $dst
