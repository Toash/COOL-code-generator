cool --out reference --lex $1
python scanner.py $1

vimdiff $1-lex reference.cl-lex
# diff -b -B -E -w $1-lex reference.cl-lex

# cat $1-lex
# cat reference.cl-lex

# rm reference.cl-lex
# rm $1-lex