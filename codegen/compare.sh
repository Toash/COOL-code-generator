# compare my implementation with reference compiler

#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' 

echo "Running $1..."

# check for input file
INPUT_FILE="./$1.input"
HAS_INPUT=false
if [[ -f "$INPUT_FILE" ]]; then
    HAS_INPUT=true
fi

cool --type "./$1.cl"
python3 ./src/main.py "./$1.cl-type"
gcc -no-pie -static ./$1.s -o out/my_executable

if $HAS_INPUT; then
cat "$INPUT_FILE" | ./out/my_executable> ./out/my_output.txt
else
./out/my_executable> ./out/my_output.txt
fi

# cool "./tests/$test.cl" > ref_output.txt
cool --x86 "./$1.cl" --out ref 
gcc -no-pie -static ./ref.s -o out/ref 

if $HAS_INPUT; then
cat "$INPUT_FILE" | ./out/ref > ./out/ref_output.txt
else
./out/ref> ./out/ref_output.txt
fi

if diff -q ./out/my_output.txt ./out/ref_output.txt > /dev/null; then
echo -e "${GREEN}[PASS]${NC} $test"
else
echo -e "${RED}[FAIL]${NC} $test"
echo "Diff:"
diff ./out/my_output.txt ./out/ref_output.txt
fi

echo

rm -rf ./src/__pycache__