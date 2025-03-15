# compare output from tac between my implementation and the cool compiler
cool --type $1
ocamlc main.ml
./a.out "$1"-type

cool --tac $1 --out ref

echo my output:
cool "$1"-tac
echo

echo cool output:
cool ref.cl-tac
echo
