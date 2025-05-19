import os
import subprocess

lexer = "scanner.py"
input_dir = "./tests"

for fname in os.listdir(input_dir):
    if fname.endswith(".cl"):
        input = os.path.join(input_dir,fname)
        input_lex = os.path.join(input_dir,fname+"-lex")
        reference_lex = "reference.cl-lex"


        subprocess.run(["python3",lexer,input])
        subprocess.run(["cool",input,"--lex","--out","reference"])
        
        with open(input_lex, "r") as f1, open(reference_lex, "r") as f2:
            output1 = f1.read()
            output2 = f2.read()
        if output1 == output2:
            print(input_lex + " ✅")
        else:
            print(input_lex + " ❌")


        # remove the lex files
        subprocess.run(["rm",input_lex])
        subprocess.run(["rm",reference_lex])
        
        

        
        
