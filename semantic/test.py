import os
import subprocess
import difflib

semantic= "semantic.py"
input_dir = "./tests"

# compile semantic analyzer
subprocess.run(["ocamlc","-o","semantic","semantic.ml"])
for fname in os.listdir(input_dir):
    if fname.endswith(".cl"):
        input_cl = os.path.join(input_dir,fname)

        subprocess.run(["python3", "../scanner/scanner.py",input_cl])
        input_lex = os.path.join(input_dir,fname+"-lex")

        subprocess.run(["python3", "../parser/parser.py",input_lex])
        input_parse= os.path.join(input_dir,fname+"-ast")

        input_type= os.path.join(input_dir,fname+"-type")
        reference_type= input_cl[:-3] + "-reference.cl-type"


        # subprocess.run(["python3",semantic,input_parse])
        subprocess.run(["./semantic",input_parse])
        subprocess.run(["cool",input_lex,"--type","--out",reference_type[:-8]])
        
        with open(input_type, "r") as f1, open(reference_type, "r") as f2:
            output1 = f1.read()
            output2 = f2.read()
        if output1 == output2:
            print(input_type+ " ✅")
        else:
            print(input_type+ " ❌")
            # diff = difflib.unified_diff(
            #     output2.splitlines(),  
            #     output1.splitlines(),  
            #     fromfile=reference_type,
            #     tofile=input_type,
            #     lineterm=''
            # )
            # for line in diff:
            #     print(line)

        subprocess.run(["rm",input_lex])
        subprocess.run(["rm",input_parse])
        subprocess.run(["rm",input_type])
        subprocess.run(["rm",reference_type])
        
        

        
        
