# compare output from tac between my implementation and the cool compiler
echo ------------------
cool --type $1
ocamlc -w -A main.ml
./a.out "$1"-type

cool --tac $1 --out ref
echo ------------------
echo my output:
cool "$1"-tac
echo

echo ------------------
echo cool output:
cool ref.cl-tac
echo

echo ------------------