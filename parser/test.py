import os
import subprocess
import difflib

parser = "parser.py"
input_dir = "./tests"

# tests parser for correctness against .cl programs, uses scanner in scanner.py
for fname in os.listdir(input_dir):
    if fname.endswith(".cl"):
        input_cl = os.path.join(input_dir,fname)

        # run our scanner against .cl file to get a .cl-lex file.
        subprocess.run(["python3", "../scanner/scanner.py",input_cl])
        input_lex = os.path.join(input_dir,fname+"-lex")
        input_parse= os.path.join(input_dir,fname+"-ast")
        reference_parse= "reference.cl-ast"


        subprocess.run(["python3",parser,input_lex])
        subprocess.run(["cool",input_lex,"--parse","--out","reference"])
        
        with open(input_parse, "r") as f1, open(reference_parse, "r") as f2:
            output1 = f1.read()
            output2 = f2.read()
        # if output1 == output2:
        #     print(input_parse+ " ✅")
        # else:
        #     print(input_parse+ " ❌")
        if output1 == output2:
            print(input_parse + " ✅")
        else:
            print(input_parse + " ❌")
            diff = difflib.unified_diff(
                output2.splitlines(),  
                output1.splitlines(),  
                fromfile='reference.cl-ast',
                tofile=fname + "-ast",
                lineterm=''
            )
            for line in diff:
                print(line)

        # subprocess.run(["rm",input_lex])
        # subprocess.run(["rm",input_parse])
        # subprocess.run(["rm",reference_parse])
        
        

        
        
