#!/bin/bash

file=$(readlink -f "$1")
echo "$1"
echo "$file"
dir=$(dirname "$file")
base="${file%.*}"

case "$file" in
    *\.cpp) echo "$file" | entr -c sh -c "clang++ -std=c++20 $file && ./a.out < in" ;;
    *\.c) echo "$file" | entr -c sh -c "clang $file && ./a.out < in" ;;
    *\.py) echo "$file" | entr -c sh -c "python3 $file" ;;
    *\.ts) echo "$file" | entr -c sh -c "tsc --target es6 --outFile out.js $file && node out.js" ;;
esac
