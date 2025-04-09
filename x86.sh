cool --type "$1"
python3 ./src/main.py "$1-type"

newname="${1%.cl}.s"
gcc -no-pie -static $newname 
./a.out
