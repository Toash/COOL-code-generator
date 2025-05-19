#!/bin/bash

# shell script to run the PA4 benchmarks

TESTS=(
  "cells-40-21"
  "hairy-scary-double"

  "if-boolean"
  "int-basic-block"
  "int-temporary"

  "loop-int"
  "matrix-multiply-5"

  "list-20"
  "pi-100"
  "primes-500"
)

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' 

for test in "${TESTS[@]}"; do
  echo "Running $test..."

  # check for input file
  INPUT_FILE="./$test.input"
  HAS_INPUT=false
  if [[ -f "$INPUT_FILE" ]]; then
    HAS_INPUT=true
  fi

  cool --type "./$test.cl"
  python3 ../src/main.py "./$test.cl-type"
  gcc -no-pie -static ./$test.s -o my_out
  
  if $HAS_INPUT; then
    cat "$INPUT_FILE" | ./my_out > my_output.txt
  else
    ./my_out > my_output.txt
  fi

  # cool "./tests/$test.cl" > ref_output.txt
  cool --x86 "./$test.cl" 
  gcc -no-pie -static ./$test.s -o ref_output 

  if $HAS_INPUT; then
    cat "$INPUT_FILE" | ./ref_output > ref_output.txt
  else
    ./ref_output > ref_output.txt
  fi


  if diff -q my_output.txt ref_output.txt > /dev/null; then
    echo -e "${GREEN}[PASS]${NC} $test"
  else
    echo -e "${RED}[FAIL]${NC} $test"
    echo "Diff:"
    diff my_output.txt ref_output.txt
  fi

  echo
done

rm my_out
rm my_output.txt
rm ref_output
rm ref_output.txt
rm -rf ../src/__pycache__