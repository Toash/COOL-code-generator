from asm_instructions import *
from asm_registers import *
from asm_constants import *

   
def write(outfile,string,not_tabbed = False):
    if not_tabbed:
        outfile.write(string+ '\n')
    else:
        outfile.write("\t\t" + string + '\n')

def emit_coolinint(outfile):
    write(outfile,"coolinint:",not_tabbed=True) 
    write(outfile,"coolinint_start:",not_tabbed=True) 

    write(outfile,"pushq\t %rbp") 
    write(outfile,"movq\t %rsp, %rbp") 
    write(outfile,"subq\t $304, %rsp") 

    # canary sits at higher memory address from the buffer
    write(outfile,"movq\t %fs:40, %rax") 
    write(outfile,"movq\t %rax, -8(%rbp)") 

    write(outfile,"xorl\t %eax, %eax") 
    write(outfile,"movq\t stdin(%rip), %rdx") 
    # move address of local buffer into rax
    write(outfile,"leaq\t -272(%rbp), %rax") 
    write(outfile,"movl\t $256, %esi") 
    write(outfile,"movq\t %rax, %rdi") 

    # populate the buffer with the int input.
    write(outfile,"call fgets") 
    write(outfile,"testq\t %rax, %rax") 

    write(outfile,"jne\t coolinint_read_success") 
    write(outfile,"movl\t $0, %eax") 
    write(outfile,"jmp\t coolinint_function_exit") 

# L26
def emit_coolinint_read_success(outfile):    
    write(outfile,"coolinint_read_success:",not_tabbed=True) 
    write(outfile,"leaq\t -272(%rbp), %rax") 
    # store pointer to buffer
    write(outfile,"movq %rax, -288(%rbp)") 
    write(outfile,"jmp\t coolinint_skip_whitespace") 

# L29
# advance pointer to next charawcter 
def emit_coolinint_advance_pointer(outfile):    
    write(outfile,"coolinint_advance_pointer:",not_tabbed=True) 
    write(outfile,"addq\t $1, -288(%rbp)") 

# L28
# loop to skip leading whitespace
def emit_coolinint_skip_whitespace(outfile):    
    write(outfile,"coolinint_skip_whitespace:",not_tabbed=True) 
    write(outfile,"call\t __ctype_b_loc") 
    write(outfile,"movq\t (%rax), %rdx") 
    write(outfile,"movq\t -288(%rbp), %rax") 

    write(outfile,"movzbl\t (%rax), %eax") 
    write(outfile,"movzbl\t %al, %eax") 

    write(outfile,"addq\t %rax, %rax") 
    write(outfile,"addq\t %rdx, %rax") 

    write(outfile,"movzwl\t (%rax), %eax") 
    write(outfile,"movzwl\t %ax, %eax") 
    write(outfile,"andl\t $8192, %eax") 
    write(outfile,"testl\t %eax, %eax") 
    # it is whitespacew
    write(outfile,"jne\t coolinint_advance_pointer") 

    write(outfile,"movq\t -288(%rbp), %rax") 
    write(outfile,"movzbl\t (%rax), %eax") 
    write(outfile,"testb\t %al, %al") 
    # null charcter (end)
    write(outfile,"je\t coolinint_null") 

    write(outfile,"movq\t -288(%rbp), %rax") 
    write(outfile,"movzbl\t (%rax), %eax") 
    # negative sign
    write(outfile,"cmpb\t $45, %al") 
    write(outfile,"je\t coolinint_parse_int") 

    write(outfile,"movq\t -288(%rbp), %rax") 
    write(outfile,"movzbl\t (%rax), %eax") 
    #addition sign
    write(outfile,"cmpb\t $43, %al") 
    write(outfile,"je\t coolinint_parse_int") 

    # check if digit
    write(outfile,"call\t __ctype_b_loc") 
    write(outfile,"movq\t (%rax), %rdx") 
    write(outfile,"movq\t -288(%rbp), %rax") 
    write(outfile,"movzbl\t (%rax), %eax") 
    write(outfile,"movzbl\t %al, %eax") 
    write(outfile,"addq\t %rax, %rax") 
    write(outfile,"addq\t %rdx, %rax") 
    write(outfile,"movzwl\t (%rax), %eax") 
    write(outfile,"movzwl\t %ax, %eax") 
    write(outfile,"andl\t $2048, %eax") 
    write(outfile,"testl\t %eax, %eax") 
    write(outfile,"jne\t coolinint_parse_int") 

#L30
def emit_coolinint_null(outfile):
    write(outfile,"coolinint_null:",not_tabbed=True) 
    write(outfile,"movl\t $0, %eax") 
    write(outfile,"jmp\t coolinint_function_exit") 


#L31
def emit_coolinint_parse_int(outfile):
    write(outfile,"coolinint_parse_int:",not_tabbed=True) 
    write(outfile,"leaq\t -296(%rbp), %rcx") 
    write(outfile,"movq\t -288(%rbp), %rax") 
    # the base
    write(outfile,"movl\t $10, %edx") 
    write(outfile,"movq\t %rcx, %rsi") 
    write(outfile,"movq\t %rax, %rdi") 

    # string to integer
    write(outfile,"call\t strtol") 

    # -280(%rbp) contains the int that was read in.
    write(outfile,"movq\t %rax, -280(%rbp)") 
    write(outfile,"movabsq\t $-2147483649, %rax") 
    write(outfile,"cmpq\t %rax, -280(%rbp)") 
    write(outfile,"jle coolinint_int_out_of_range") 

    write(outfile,"movl\t $2147483648, %eax") 
    write(outfile,"cmpq\t %rax, -280(%rbp)") 
    write(outfile,"jl coolinint_skip_newline_check") 


#L32
def emit_coolinint_int_out_of_range(outfile):
    write(outfile,"coolinint_int_out_of_range:",not_tabbed=True) 
    write(outfile,"movl\t $0, %eax") 
    write(outfile,"jmp\t coolinint_function_exit") 

#L36
def emit_coolinint_newline_continue(outfile):
    write(outfile,"coolinint_newline_continue:",not_tabbed=True) 
    write(outfile,"movq\t -296(%rbp), %rax") 
    write(outfile,"addq\t $1, %rax") 
    write(outfile,"movq\t %rax, -296(%rbp)") 


#L34
def emit_coolinint_skip_newline_check(outfile):
    write(outfile,"coolinint_skip_newline_check:",not_tabbed=True) 
    write(outfile,"movq\t -296(%rbp), %rax") 
    write(outfile,"movzbl\t (%rax), %eax") 
    write(outfile,"testb\t %al, %al") 
    write(outfile,"je\t coolinint_return_result") 
    write(outfile,"movq\t -296(%rbp), %rax") 
    write(outfile,"movzbl\t (%rax), %eax") 
    write(outfile,"cmpb\t $10, %al") 
    write(outfile,"jne\t coolinint_newline_continue") 

#L35
def emit_coolinint_return_result(outfile):
    write(outfile,"coolinint_return_result:",not_tabbed=True) 
    write(outfile,"movq\t -280(%rbp), %rax")
    

#L37
def emit_coolinint_function_exit(outfile):
    write(outfile,"coolinint_function_exit:",not_tabbed=True) 
    write(outfile,"movq\t -8(%rbp), %rdx")
    write(outfile,"subq\t %fs:40, %rdx")
    write(outfile,"je\t coolinint_check_canary_passed")
    write(outfile,"call\t __stack_chk_fail")

#L38
def emit_coolinint_check_canary_passed(outfile):
    write(outfile,"coolinint_check_canary_passed:",not_tabbed=True) 
    write(outfile,"leave") 
    write(outfile,"ret") 

    


