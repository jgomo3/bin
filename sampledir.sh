#!/bin/bash

# Usage: sampledir <size> <src> <dst>

size=$1
src=$2
dst=$3

find $src -type f | shuf -n $size | xargs cp -t $dst
