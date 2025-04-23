# compile .cl in .cl-asm, and run it
cool --type "$1"

python3 ./src/asm.py "$1-type"

cool "$1-asm"
