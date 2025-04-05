echo "Arithmetic test..."
cool --type ./tests/arith.cl
python3 main.py ./tests/arith.cl-type
gcc -no-pie -static file.s
./a.out
echo
cool ./tests/arith.cl
echo

echo "Bool (no let) test..."
cool --type ./tests/bool_no_let.cl
python3 main.py ./tests/bool_no_let.cl-type
gcc -no-pie -static file.s
./a.out
echo
cool ./tests/bool_no_let.cl
echo

echo "Let (no init) test..."
cool --type ./tests/let_no_init.cl
python3 main.py ./tests/let_no_init.cl-type
gcc -no-pie -static file.s
./a.out
echo
cool ./tests/let_no_init.cl
echo


