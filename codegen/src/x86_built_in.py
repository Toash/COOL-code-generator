import os
def emit_built_in(outfile):
    builtin_path = os.path.join(os.path.dirname(__file__), "x86_built_in.txt")
    outfile.write("\n")
    outfile.write("\n")
    outfile.write("## REFERENCE COMPILER BUILT-INS\n")
    with open(builtin_path,"r") as src:
        outfile.write(src.read())

    outfile.write("\n")
    