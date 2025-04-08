cool --type $1"-type"
python3 main.py $1

gcc -no-pie -static file.s
./a.out
