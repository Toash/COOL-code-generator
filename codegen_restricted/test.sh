cool --type ./tests/"$1"

python3 TAC_Gen.py ./tests/"$1"-type

echo "generating my tac output..."

# my output
cool ./tests/"$1"-tac > ./tests/MY_OUTPUT

# cool reference
echo "getting cool reference output..."
cool --tac ./tests/"$1" --out ./tests/COOL_REFERENCE
cool ./tests/COOL_REFERENCE.cl-tac > ./tests/COOL_REFERENCE

echo "comparing outputs..."
diff ./tests/MY_OUTPUT ./tests/COOL_REFERENCE