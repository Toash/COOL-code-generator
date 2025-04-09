from asm import CoolAsmGen
from asm_instructions import *
import sys
from pprint import pprint


# given cl-type, parses cl-type, converts to cool-asm, then to x86.
"""
REGISTERS:
r12 - self
r13 - accumulator
r14 - temp
rbp - base pointer 
rsp - stack pointer
"""
class X86Gen:
    def __init__(self, cl_type):
        outfile_name = cl_type.replace(".cl-type",".s") 
        cool_asm_gen = CoolAsmGen(file=cl_type,x86=True)

        try:
            self.outfile = open(outfile_name,"w")
            self.cool_asm_to_x86(cool_asm_gen.get_asm())
        finally:
            self.c_placeholders()
            # mark stack as non executabale
            self.outfile.write(".section .note.GNU-stack,\"\",@progbits\n")
            self.outfile.close()

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
                    if isinstance(imm,ASM_Value):
                        self.outfile.write(f"movq ${imm.value}, {self.get_reg(reg)}\n")
                    elif isinstance(imm, ASM_Word):
                        
                        self.outfile.write(f"movq ${int(imm.value) * 8}, {self.get_reg(reg)}\n")
                    else:
                        raise Exception("Immediate should be ASM_Value or ASM_Word")
                case ASM_Mov(dest,src):
                    self.tab()
                    self.outfile.write(f"movq {self.get_reg(src)}, {self.get_reg(dest)}\n")

                case ASM_Add(left,right):
                    self.tab()
                    self.outfile.write(f"addq {self.get_reg(left)}, {self.get_reg(right)}\n")
                case ASM_Sub(left,right):
                    self.tab()
                    self.outfile.write(f"subq {self.get_reg(left)}, {self.get_reg(right)}\n")
                case ASM_Mul(left,right):
                    self.tab()
                    self.outfile.write(f"imulq {self.get_reg(left)}, {self.get_reg(right)}\n")
                case ASM_Div(left,right):
                    self.tab()
                    self.outfile.write(f"movq {self.get_reg(right)}, %rax\n")
                    self.tab()
                    self.outfile.write(f"movq {self.get_reg(left)}, %rbx\n")
                    self.tab()
                    # sign extend RAX into RDX:RAX (RDX will be all 1s or 0s)
                    self.outfile.write("cqto\n") 
                    self.tab()
                    self.outfile.write(f"idivq %rbx\n")
                    self.tab()
                    self.outfile.write(f"movq %rax, {self.get_reg(right)}\n")

                case ASM_Jmp(label):
                    self.tab()
                    self.outfile.write(f"jmp {label}\n")
                case ASM_Bz(reg, label):
                    self.tab()
                    self.outfile.write(f"cmpq $0, {self.get_reg(reg)}\n")
                    self.tab()
                    self.outfile.write(f"je {label}\n")
                case ASM_Bnz(reg, label):
                    self.tab()
                    self.outfile.write(f"cmpq $0, {self.get_reg(reg)}\n")
                    self.tab()
                    self.outfile.write(f"jne {label}\n")
                case ASM_Beq(left, right, label):
                    self.tab()
                    self.outfile.write(f"cmpq {self.get_reg(left)}, {self.get_reg(right)}\n")
                    self.tab()
                    self.outfile.write(f"je {label}\n")
                case ASM_Blt(left,right,label):
                    self.tab()
                    self.outfile.write(f"cmpq {self.get_reg(right)}, {self.get_reg(left)}\n")
                    self.tab()
                    self.outfile.write(f"jl {label}\n")
                case ASM_Ble(left,right,label):
                    self.tab()
                    self.outfile.write(f"cmpq {self.get_reg(right)}, {self.get_reg(left)}\n")
                    self.tab()
                    self.outfile.write(f"jle {label}\n")


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

                    self.outfile.write("\n")
                    self.tab()
                    self.outfile.write(f"## --- CALLOC ---\n")
                    self.tab()
                    self.outfile.write(f"movq %r12, %rdi")
                    self.outfile.write("\t ## first argument - amount of entries\n")
                    self.tab()
                    self.outfile.write(f"movq ${8}, %rsi")
                    self.outfile.write("\t ## second argument - size of each entry\n")

                    self.tab()
                    self.outfile.write(f"call calloc\n")
                    
                    self.tab()
                    
                    self.outfile.write(f"movq %rax, {self.get_reg(dest)}\n")
                    self.outfile.write("\n")


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
                            # accumulator should hold the value we want to print.
                            self.outfile.write("movq %r13, %rsi\n")
                            self.tab()
                            self.outfile.write("movl $0, %eax\t## required by printf.\n")
                            self.tab()
                            self.outfile.write("call printf\n")
                        case "IO.in_int":
                            self.tab()
                            self.outfile.write("## start of in_int\n")
                            self.tab()
                            self.outfile.write("movl $1, %esi\n")
                            self.tab()
                            self.outfile.write("movl $4096, %edi\n")
                            
                            self.tab()
                            self.outfile.write("## Generate array of 4096 chars\n")

                            self.tab()
                            # generate array of 4096 characters where string will be stored.
                            self.outfile.write("call calloc\n")
                            self.tab()
                            self.outfile.write("pushq %rax\n")
                            # im starting to regret these tabs
                            self.tab()
                            self.outfile.write("movq %rax, %rdi\n")
                            self.tab()
                            self.outfile.write("movq $4096, %rsi\n")
                            self.tab()

                            self.outfile.write("## put stdin stream into %rdx.\n")

                            self.tab()
                            # the stream
                            self.outfile.write("movq stdin(%rip), %rdx\n")
                            
                            self.tab()
                            self.outfile.write("## fgets has\n")
                            self.tab()
                            self.outfile.write("## rdi - char array\n")
                            self.tab()
                            self.outfile.write("## rsi - number of characters to read (4096)\n")
                            self.tab()
                            self.outfile.write("## rdx - the stream to read from (stdin)\n")
                            self.tab()
                            self.outfile.write("call fgets\n")

                            self.tab()
                            self.outfile.write("popq %rdi\n")
                            self.tab()
                            self.outfile.write("movl $0, %eax\n")
                            self.tab()
                            self.outfile.write("pushq %rax\n")
                            self.tab()

                            # sscanf will write to top of stack.
                            self.outfile.write("## sscanf will write to top of stack.\n")

                            self.tab()
                            self.outfile.write("movq %rsp, %rdx\n")
                            self.tab()
                            self.outfile.write("movq $percent.ld, %rsi\n")

                            # with the ld placeholder, only parse an integer from the input string.
                            self.tab()
                            self.outfile.write("## with placeholder, only parse integer from input string.\n")

                            self.tab()
                            self.outfile.write("## sscanf has:\n")
                            self.tab()
                            self.outfile.write("## rdi - char array\n")
                            self.tab()
                            self.outfile.write("## rsi - placeholders\n")
                            self.tab()
                            self.outfile.write("## rdx - output stream\n")


                            self.tab()
                            self.outfile.write("call sscanf\n")
                            self.tab()
                            # inputted integer now in rax.
                            self.outfile.write("popq %rax\n")
                            self.tab()
                            self.outfile.write("movq $0, %rsi\n")
                            self.tab()
                            # clamp to 32 bit signed int range.
                            self.outfile.write("cmpq $2147483647, %rax\n")
                            self.tab()
                            self.outfile.write("cmovg %rsi, %rax\n")
                            self.tab()
                            self.outfile.write("cmpq $-2147483648, %rax\n")
                            self.tab()
                            self.outfile.write("cmovl %rsi, %rax\n")
                            self.tab()
                            self.outfile.write("movq %rax, %r13\n")
                            self.tab()
                            self.outfile.write("## we now have the raw value in %r13.\n")
                        case "IO.out_string":
                            # self.tab()
                            # self.outfile.write("call cooloutstr\n")

                            pass
                        case _:
                            self.tab()
                            raise Exception("Implement system call for ",name)
                            # self.outfile.write(f"TODO: implement system call for \"{name}\".\n")
                case ASM_Constant_raw_string(string):
                    self.tab()
                    for char in string:
                        self.outfile.write(f".byte {ord(char)}\n")
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

    # this was not a good idea
    def tab(self):
        self.outfile.write("\t\t")

    #cool_asm to x86 register
    def get_reg(self,reg):
        # TODO: register spillover ( more than 6 arguments)
        return {
           "r0":"%r12",
            "r1":"%r13",
            "r2":"%r14",
            "r3":"%r15",
            "fp":"%rbp",
            "sp":"%rsp",
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

        # long integer
        self.outfile.write("percent.ld:\n")
        self.tab()
        self.outfile.write(".byte 32 \t# ' '\n")
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
