from cool_asm_gen import CoolAsmGen
from cool_asm_instructions import *
import sys
from pprint import pprint


# given cl-type, parses cl-type, converts to cool-asm, then to x86.
# register mappings:

class X86Gen:
    def __init__(self, file):
        outfile_name = "my_output.s"
        cool_asm_gen = CoolAsmGen(file)
        # pprint(cool_asm_gen.get_asm())

        try:
            self.outfile = open(outfile_name,"w")
            self.cool_asm_to_x86(cool_asm_gen.get_asm())
        finally:
            self.outfile.close()

    # I guess we dont need named tuples for x86?
    def cool_asm_to_x86(self,cool_asm):
        for instr in cool_asm:
            match instr:
                case ASM_Label(label):
                    self.outfile.write(f"{label}:\n")
                case ASM_Li(reg,imm):
                    self.outfile.write(f"movq ${imm} {self.get_reg(reg)}")
                case ASM_Mov(dest,src):
                    self.outfile.write(f"movq ${self.get_reg(src)} {self.get_reg(dest)}")

                case ASM_Add(dst,left,right):
                    self.outfile.write(f"addq {self.get_reg(left)} {self.get_reg(right)}")
                case ASM_Call_Label(label):
                    pass
                case ASM_Call_Reg(reg):
                    print("need to implkement call reg")
                    pass
                case ASM_Return():
                    self.tab()
                    # we need to handle returns differently.
                    # in cool_asm, return just jumps to ra.
                    # in x86, it pops from the top of the stack and jumps to that average
                    self.outfile.write("ret\n")

                case ASM_Push(reg):
                    pass
                case ASM_Pop(reg):
                    pass

                case ASM_Ld(dest,src,offset):
                    pass
                case ASM_St(dest,src,offset):
                    pass

                case ASM_La(reg,label):
                    pass

                case ASM_Alloc(dest,src):
                    pass

                case ASM_Constant_label(label):
                    pass

                case ASM_Syscall(name):
                    #depending on name, call the respective function.
                    pass
                case ASM_Constant_label(label):
                    self.tab()
                    self.outfile.write(f".quad {label}\n")

                case _:
                    print("x86: Unhandled Cool_asm:",instr)
    def tab(self):
        self.outfile.write("\t\t\t\t\t")

    #cool_asm to x86 register
    def get_reg(self,reg):
        return {
           "r0":"rdi",
            "r1":"rax",
            "r2":"r10",
            "r3":"r11",
            "fp":"rbp",
            "sp":"rsp",
            "ra":"CHANGE - just use call / ret"

        }[reg]


if __name__ == "__main__":
    x86_gen = X86Gen(sys.argv[1])
