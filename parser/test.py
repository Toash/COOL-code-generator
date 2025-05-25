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
        reference_parse= input_cl[:-3] + "-reference.cl-ast"


        subprocess.run(["python3",parser,input_lex])
        subprocess.run(["cool",input_lex,"--parse","--out",reference_parse[:-7]])
        
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
                # fromfile='reference.cl-ast',
                fromfile=reference_parse,
                tofile=input_parse,
                lineterm=''
            )
            for line in diff:
                print(line)

        subprocess.run(["rm",input_lex])
        subprocess.run(["rm",input_parse])
        subprocess.run(["rm",reference_parse])
        
        

        
        
