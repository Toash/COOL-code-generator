import subprocess
import sys



input = sys.argv[1]

# run lexer
subprocess.run(["python3", "../scanner/scanner.py",input])
# run parser
subprocess.run(["python3", "../parser/parser.py",input + "-lex"])

# run semantic analyzer
# subprocess.run(["../semantic/semantic",input + "-ast"])
# Cool reference compiler is stubbed in for this stage.
subprocess.run(["cool","--type",input + "-ast"])

# run codegen
subprocess.run(["python3", "../codegen/src/main.py",input + "-type"])



subprocess.run(["rm",input + "-lex"])
subprocess.run(["rm",input + "-ast"])
subprocess.run(["rm",input + "-type"])
        
        

        
        
