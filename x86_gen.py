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
            self.c_placeholders()
            self.outfile.close()

    # I guess we dont need named tuples for x86?
    def cool_asm_to_x86(self,cool_asm):
        for instr in cool_asm:
            match instr:
                case ASM_Label(label):
                    if label == "start":
                        label = "main"
                    self.outfile.write(f".globl {label}\n")
                    self.outfile.write(f"{label}:\n")
                case ASM_Li(reg,imm):
                    self.tab()
                    # FIXME : declare literal value or word value.
                    self.outfile.write(f"movq ${int(imm)*8}, {self.get_reg(reg)}\n")
                case ASM_Mov(dest,src):
                    self.tab()
                    self.outfile.write(f"movq {self.get_reg(src)}, {self.get_reg(dest)}\n")
                case ASM_Add(dst,left,right):
                    self.tab()
                    self.outfile.write(f"addq {self.get_reg(right)}, {self.get_reg(left)}\n")
                case ASM_Call_Label(label):
                    self.tab()
                    self.outfile.write(f"call {label}\n")
                case ASM_Call_Reg(reg):
                    self.tab()
                    self.outfile.write(f"call *{self.get_reg(reg)}\n")
                case ASM_Return():
                    self.tab()
                    # we need to handle returns differently.
                    # in cool_asm, return just jumps to ra.
                    # in x86, it pops from the top of the stack and jumps to that average
                    self.outfile.write("ret\n")

                case ASM_Push(reg):
                    
                    # x86 pushes return address from caller.
                    if(reg == "ra"):
                        continue

                    self.tab()
                    self.outfile.write(f"pushq {self.get_reg(reg)}\n")
                case ASM_Pop(reg):

                    # x86 already pops return address in call instruction.
                    if(reg == "ra"):
                        continue

                    self.tab()
                    self.outfile.write(f"popq {self.get_reg(reg)}\n")
                case ASM_Ld(dest,src,offset):
                    self.tab()
                    self.outfile.write(f"movq {offset*8}({self.get_reg(src)}), {self.get_reg(dest)}\n")
                case ASM_St(dest,src,offset):
                    self.tab()
                    self.outfile.write(f"movq {self.get_reg(src)}, {offset*8}({self.get_reg(dest)})\n")
                    pass

                case ASM_La(reg,label):
                    self.tab()
                    self.outfile.write(f"movq ${label}, {self.get_reg(reg)}\n")
                    pass

                case ASM_Alloc(dest,src):
                    # self.tab()
                    # self.outfile.write(f"movq {self.get_reg(src)}, %rdi");
                    # self.outfile.write("\t ## first argument - number of entries to allocate\n")

                    self.tab()
                    self.outfile.write(f"movq ${8}, %rsi")
                    self.outfile.write("\t ## second argument - size of each entry\n")

                    self.tab()
                    self.outfile.write(f"call calloc\n")
                    
                    self.tab()
                    
                    self.outfile.write(f"movq %rax, {self.get_reg(dest)}\n")
                    pass


                case ASM_Syscall(name):
                    #depending on name, call the respective function.
                    match name:
                        case "exit":
                            self.tab()
                            self.outfile.write("movl $0, %edi\n")
                            self.tab()
                            self.outfile.write("call exit\n")
                        case "IO.out_int":
                            self.tab()
                            self.outfile.write("movq $percent.d, %rdi\n")
                            
                            self.tab()
                            self.outfile.write("movl %eax, %eax ## truncate higher 32 bits\n")
                            self.tab()
                            self.outfile.write("cdqe\t## sign extend the 32 bit integer\n")
                            
                            self.tab()
                            self.outfile.write("movq %rax, %rsi\n")
                            self.tab()
                            self.outfile.write("movl $0, %eax\t## required by printf.\n")
                            self.tab()
                            self.outfile.write("call printf\n")
                        case _:
                            self.tab()
                            self.outfile.write(f"TODO: implement system call for \"{name}\".\n")
                case ASM_Constant_label(label):
                    self.tab()
                    self.outfile.write(f".quad {label}\n")
                case ASM_Comment(comment,not_tabbed):
                    # lol
                    if not not_tabbed:
                        self.tab()

                    self.outfile.write("## " + comment.strip()+"\n")
                    

                case _:
                    print("x86: Unhandled Cool_asm:",instr)
    def tab(self):
        self.outfile.write("\t\t")

    #cool_asm to x86 register
    def get_reg(self,reg):
        # TODO: register spillover ( more than 6 arguments)
        return {
           "r0":"%rdi",
            "r1":"%rax",
            "r2":"%r10",
            "r3":"%r11",
            "fp":"%rbp",
            "sp":"%rsp",
            "ra":"CHANGE - just use call / ret"

        }[reg]


    # used when passing into printf.
    def c_placeholders(self):
        # integer
        self.outfile.write("percent.d:\n")
        self.tab()
        self.outfile.write(".byte 37 \t# '%'\n")
        self.tab()
        self.outfile.write(".byte 108 \t# 'l'\n")
        self.tab()
        self.outfile.write(".byte 100 \t# 'd'\n")
        self.tab()
        self.outfile.write(".byte 0\n")
        


if __name__ == "__main__":
    x86_gen = X86Gen(sys.argv[1])
