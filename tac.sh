# compare tac between my implementation and the cool compiler
cool --type $1
ocamlc main.ml
./a.out "$1"-type

cool --tac $1 --out ref

# code --diff "$1"-tac ref.cl-tac