from cool_asm_gen import CoolAsmGen
import sys
from pprint import pprint

class X86Gen:
    def __init__(self, file):
        cool_asm_gen = CoolAsmGen(file)
        pprint(cool_asm_gen.get_asm())



if __name__ == "__main__":
    x86_gen = X86Gen(sys.argv[1])
