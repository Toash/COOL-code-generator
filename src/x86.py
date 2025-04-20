import sys
from asm import CoolAsmGen
from asm_instructions import *
from x86_strings import *
from x86_ints import *


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
    def __init__(self, cl_type, comments=False):
        outfile_name = cl_type.replace(".cl-type",".s") 
        cool_asm_gen = CoolAsmGen(file=cl_type,x86=True)

        try:
            self.outfile = open(outfile_name,"w")
            self.cool_asm_to_x86(cool_asm_gen.get_asm(include_comments=comments))
        finally:
            c_placeholders(self.outfile)

            # out_string
            emit_cooloutstr_start(self.outfile)
            emit_cooloutstr_loop_start(self.outfile)
            emit_cooloutstr_check_newline(self.outfile)
            emit_cooloutstr_check_tab(self.outfile)
            emit_cooloutstr_print(self.outfile)

            emit_coolstrlen_start(self.outfile)
            emit_coolstrlen_test(self.outfile)
            emit_coolstrlen_increment(self.outfile)

            emit_cat_placeholders(self.outfile)

            emit_coolstrcat_start(self.outfile)
            emit_coolstrcat_check_second(self.outfile)
            emit_coolstrcat_concat(self.outfile)
            emit_coolstrcat_return(self.outfile)

            emit_coolsubstr_start(self.outfile)
            emit_coolsubstr_null(self.outfile)
            emit_coolsubstr_substr(self.outfile)
            emit_coolsubstr_end(self.outfile)

            emit_empty_string(self.outfile)
            emit_coolgetstr_start(self.outfile)
            emit_coolgetstr_loop_start(self.outfile)
            emit_coolgetstr_end_condition(self.outfile)
            emit_coolgetstr_return_buffer(self.outfile)
            emit_coolgetstr_check_null_char(self.outfile)
            emit_coolgetstr_store_char(self.outfile)
            emit_coolgetstr_return(self.outfile)

            emit_coolinint(self.outfile)
            emit_coolinint_read_success(self.outfile)
            emit_coolinint_advance_pointer(self.outfile)
            emit_coolinint_skip_whitespace(self.outfile)
            emit_coolinint_null(self.outfile)
            emit_coolinint_parse_int(self.outfile)
            emit_coolinint_int_out_of_range(self.outfile)
            emit_coolinint_newline_continue(self.outfile)
            emit_coolinint_skip_newline_check(self.outfile)
            emit_coolinint_return_result(self.outfile)
            emit_coolinint_function_exit(self.outfile)
            emit_coolinint_check_canary_passed(self.outfile)

            # mark stack as non executabale
            self.outfile.write(".section .note.GNU-stack,\"\",@progbits\n")
            self.outfile.close()

    def write(self,string, not_tabbed = False):
        if not not_tabbed: 
            self.outfile.write("\t\t")
        self.outfile.write(string)

    # makes last 4 bits of rsp 0, so 16 byte aligns rsp

    def align_rsp(self):
        self.write("## 16 byte align rsp before call\n")
        self.write("andq\t $0xFFFFFFFFFFFFFFF0, %rsp\n")

    def cool_asm_to_x86(self,cool_asm):
        for instr in cool_asm:
            match instr:
                case ASM_Label(label):
                    if label == "start":
                        label = "main"
                        self.write(f".globl {label}\n",True)
                    self.write(f"{label}:\n",True)
                case ASM_Li(reg,imm):
                    if isinstance(imm,ASM_Value):
                        self.write(f"movq\t ${imm.value}, {self.get_reg(reg)}\n")
                    elif isinstance(imm, ASM_Word):
                        
                        self.write(f"movq\t ${int(imm.value) * 8}, {self.get_reg(reg)}\n")
                    else:
                        raise Exception("Immediate should be ASM_Value or ASM_Word")
                case ASM_Mov(dest,src):
                    self.write(f"movq\t {self.get_reg(src)}, {self.get_reg(dest)}\n")

                case ASM_Add(left,right):
                    self.write(f"addq\t {self.get_reg(left)}, {self.get_reg(right)}\n")
                case ASM_Sub(left,right):
                    self.write(f"subq\t {self.get_reg(left)}, {self.get_reg(right)}\n")
                case ASM_Mul(left,right):
                    self.write(f"imulq\t {self.get_reg(left)}, {self.get_reg(right)}\n")
                case ASM_Div(left,right):
                    self.write(f"movq\t {self.get_reg(right)}, %rax\n")
                    self.write(f"movq\t {self.get_reg(left)}, %rbx\n")
                    # sign extend RAX into RDX:RAX (RDX will be all 1s or 0s)
                    self.write("cqto\n") 
                    self.write(f"idivq\t %rbx\n")
                    self.write(f"movq\t %rax, {self.get_reg(right)}\n")

                case ASM_Jmp(label):
                    self.write(f"jmp\t {label}\n")
                case ASM_Bz(reg, label):
                    self.write(f"cmpq\t $0, {self.get_reg(reg)}\n")
                    self.write(f"je\t {label}\n")
                case ASM_Bnz(reg, label):
                    self.write(f"cmpq\t $0, {self.get_reg(reg)}\n")
                    self.write(f"jne\t {label}\n")
                case ASM_Beq(left, right, label):
                    self.write(f"cmpq\t {self.get_reg(left)}, {self.get_reg(right)}\n")
                    self.write(f"je\t {label}\n")
                case ASM_Blt(left,right,label):
                    self.write(f"cmpq\t {self.get_reg(right)}, {self.get_reg(left)}\n")
                    self.write(f"jl\t {label}\n")
                case ASM_Ble(left,right,label):
                    self.write(f"cmpq\t {self.get_reg(right)}, {self.get_reg(left)}\n")
                    self.write(f"jle\t {label}\n")


                case ASM_Call_Label(label):
                    self.write(f"call\t {label}\n")
                case ASM_Call_Reg(reg):
                    self.write(f"call\t *{self.get_reg(reg)}\n")
                case ASM_Return():
                    # we need to handle returns differently.
                    # in cool_asm, return just jumps to ra.
                    # in x86, it pops from the top of the stack and jumps to that average
                    self.write("ret\n")

                case ASM_Push(reg):
                    
                    # x86 pushes return address from caller.
                    if(reg == "ra"):
                        continue

                    self.write(f"pushq\t {self.get_reg(reg)}\n")
                case ASM_Pop(reg):

                    # x86 already pops return address in call instruction.
                    if(reg == "ra"):
                        continue

                    self.write(f"popq\t {self.get_reg(reg)}\n")
                case ASM_Ld(dest,src,offset):
                    self.write(f"movq\t {offset*8}({self.get_reg(src)}), {self.get_reg(dest)}\n")
                case ASM_St(dest,src,offset):
                    self.write(f"movq\t {self.get_reg(src)}, {offset*8}({self.get_reg(dest)})\n")

                case ASM_La(reg,label):
                    self.write(f"movq\t ${label}, {self.get_reg(reg)}\n")

                case ASM_Alloc(dest,src):

                    self.write(f"## --- CALLOC ---\n")
                    self.write("## first argument - amount of entries\n")
                    self.write(f"movq\t %r12, %rdi\n")

                    self.write("## second argument - size of each entry\n")
                    self.write(f"movq\t ${8}, %rsi\n")

                    self.write(f"call calloc\n")
                    
                    self.write(f"movq\t %rax, {self.get_reg(dest)}\n")


                case ASM_Syscall(name):
                    #depending on name, call the respective function.
                    match name:
                        case "exit":
                            self.write("movl\t $0, %edi\n")
                            self.write("call\t exit\n")
                        case "IO.out_int":
                            self.write("## out_int\n")
                            self.write("movq\t $percent.d, %rdi\n")
                            
                            self.write("movl\t %eax, %eax ## truncate higher 32 bits\n")
                            self.write("cdqe\t## sign extend the 32 bit integer\n")
                            
                            # accumulator should hold the value we want to print.
                            self.write("movq\t %r13, %rsi\n")
                            self.write("movl\t $0, %eax\t## required by printf.\n")

                            self.align_rsp()
                            self.write("call\t printf\n")
                        case "IO.in_int":
                            self.write("## in_int\n")
                            self.align_rsp()
                            self.write("call\t coolinint\n")
                            self.write("movq\t %rax, %r13\n")

                        case "IO.out_string":
                            self.write("## out_string\n")
                            self.write("movq\t %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.\n")
                            self.align_rsp()
                            self.write("call\t cooloutstr\n")

                        case "IO.in_string":
                            self.write("## in_string\n")
                            self.align_rsp()
                            self.write("call\t coolgetstr\n")
                            self.write("movq\t %rax, %r13\n")

                        case "String.length":
                            self.write("## String.length\n")
                            self.write("movq\t %r13, %rdi\n")
                            self.write("movl\t $0, %eax\n")
                            self.write("call\t coolstrlen\n")
                            self.write("movq\t %rax, %r13\n")
                        case "String.concat":
                            self.write("movq\t %r13, %rdi\n")
                            self.write("movq\t %r14, %rsi\n")
                            self.write("## String.concat\n")
                            self.align_rsp()
                            self.write("call coolstrcat\n")

                            # modify the combined stinrg we made earlier.
                            self.write("movq\t %rax, %r13\n")
                        case "String.substr":
                            # self
                            self.write("movq\t %r12, %rdi\n")
                            # starting index
                            self.write("movq\t %r13, %rsi\n")
                            # ending index
                            self.write("movq\t %r14, %rdx\n")
                            self.align_rsp()
                            self.write("call\t coolsubstr\n")
                            self.write("movq\t %rax, %r13\n")


                        case "string_compare_eq":
                            self.write("movq\t %r13, %rdi\n")
                            self.write("movq\t %r14, %rsi\n")
                            self.align_rsp()
                            self.write("call\t strcmp\n")
                            self.write("cmp\t $0, %eax\n")
                            self.write("je\t eq_true\n")
                            self.write("jmp\t eq_false\n")
                        case "string_compare_le":
                            self.write("movq\t %r13, %rdi\n")
                            self.write("movq\t %r14, %rsi\n")
                            self.align_rsp()
                            self.write("call\t strcmp\n")
                            self.write("cmp\t $0, %eax\n")
                            self.write("jle\t le_true\n")
                            self.write("jmp\t le_false\n")
                        case "string_compare_lt":
                            self.write("movq\t %r13, %rdi\n")
                            self.write("movq\t %r14, %rsi\n")
                            self.align_rsp()
                            self.write("call\t strcmp\n")
                            self.write("cmp\t $0, %eax\n")
                            self.write("jl\t lt_true\n")
                            self.write("jmp\t lt_false\n")
                            
                        case _:
                            self.write(f"TODO: implement system call for \"{name}\".\n")
                case ASM_Constant_raw_string(string):
                    for char in string:
                        self.write(f".byte\t {ord(char)} \t ")
                        self.write(fr"## " + repr(char))

                        self.write("\n")
                    self.write(f".byte\t 0 \t ## null char\n")
                case ASM_Constant_label(label):
                    self.write(f".quad\t {label}\n")
                case ASM_Comment(comment,not_tabbed):
                    self.write("## " + comment.strip()+"\n",not_tabbed)
                    

                case _:
                    print("x86: Unhandled Cool_asm:",instr)


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
            "%eax":"%eax",
            "%rax":"%rax",
        }[reg]


        

if __name__ == "__main__":
    if len(sys.argv) > 2:
        print("comments enabled.")
        x86_gen = X86Gen(sys.argv[1],comments=True)
    else:
        x86_gen = X86Gen(sys.argv[1],comments=False)

