#!/bin/bash

TESTS=(
  # "cool_arith" #takes  input
  "cool_atoi"
  "cool_cells"
  "cool_hs" #hairy scary indeed
  "cool_list"
  "cool_new-complex"
  "cool_primes"
  "cool_print-cool"
  # "cool_sort-list"
  "cool_list" 
  "book_list"
  "staircase"
  "more_arith"
  "pa3c2"
  "aliasing"
  "case_no_branch1"
  "case_no_branch2"
  "case_no_branch3"
  "case_no_branch4"
  "dispatch-selftype-sideeffect"
  "div_by_zero"
  "str_out_of_bounds"
  "void_case"
  "void_dispatch"
  "arith"
  "divide_by_zero"
  "assignment"
  "bool_no_let"
  "bool_let"
  "let_no_init"
  "let_init"
  "unary"
  "scopes"
  "pa3"
  "while"
  "string"
  "string_out_of_range"
  "THE_ULTIMATE_TEST"
  "string_comparison"
  "attributes"
  "methods"
  "method_other_class"
  "method_inheritance"
  "method_overriding"
  "dynamic_dispatch"
  "static_dispatch"
  "dispatch_void"
  "abort"
  "type_name"
  "copy"
  "case"
  "case2"
  "case3"
  "isvoid"
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