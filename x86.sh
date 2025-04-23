# compile .cl file into .s, and run it 

cool --type "$1"
python3 ./src/main.py "$1-type" $2 $3

newname="${1%.cl}.s"
gcc -no-pie -static $newname 
./a.out