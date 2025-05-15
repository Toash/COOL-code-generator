import sys 
from x86 import X86Gen

if __name__ == "__main__":
    
    
    X86Gen(sys.argv[1], opt=True) 

    # if len(sys.argv) > 2:
    #     args = []
    #     for arg in sys.argv[2:]:
    #         args.append(arg)

    #     opt = "-opt" in args
    #     comments = "-comments" in args

    #     if opt:
    #         print("Optimizations enabled.")
    #     if comments:
    #         print("Comments enabled.")

    #     X86Gen(sys.argv[1], opt=opt,comments=comments) 
    # else:
    #     X86Gen(sys.argv[1]) 

