from asm_instructions import *
from asm_registers import *
from asm_constants import *

   
def write(outfile,string,not_tabbed = False):
    if not_tabbed:
        outfile.write(string+ '\n')
    else:
        outfile.write("\t\t" + string + '\n')

# used when passing into printf.
def c_placeholders(outfile):
    # integer
    write(outfile,"percent.d:",not_tabbed=True)
    write(outfile,".byte 37 \t# '%'")
    write(outfile,".byte 108 \t# 'l'")
    write(outfile,".byte 100 \t# 'd'")
    write(outfile,".byte 0")

    # long integer
    write(outfile,"percent.ld:", not_tabbed = True)
    write(outfile,".byte 32 \t# ' '")
    write(outfile,".byte 37 \t# '%'")
    write(outfile,".byte 108 \t# 'l'")
    write(outfile,".byte 100 \t# 'd'")
    write(outfile,".byte 0")
    

# loads string pointer into offset from rbp,
#   string pointer should be at rdi. 

# initializes loop index and jumps to loop start.
def emit_cooloutstr_start(outfile):
    # write(outfile,".globl cooloutstr", not_tabbed  = True)
    # metadata for assembler
    # write(outfile,".type\tcooloutstr, @function")
    write(outfile,"cooloutstr:", not_tabbed  = True)
    write(outfile,"cooloutstr_start:",not_tabbed=True)

    write(outfile,"pushq\t%rbp")
    write(outfile,"movq\t%rsp, %rbp")

    # we allocate this much for padding.
    write(outfile,"subq\t$32, %rsp")

    # rdi should be string pointer
    write(outfile,"movq\t%rdi, -24(%rbp) ## rdi should be the string pointer (label to the string).")

    # initialize loop index 
    # -4(%rbp) expects 4 bytes! cannot use movq.
    write(outfile,"movl\t$0, -4(%rbp)")
    # ^ has gap for alignment.

    write(outfile,"jmp\tcooloutstr_loop_start")

def emit_cooloutstr_loop_start(outfile):
    write(outfile,"cooloutstr_loop_start:", not_tabbed  = True)
    write(outfile,"movl\t-4(%rbp), %eax")

    # eax -> rax
    write(outfile,"cltq")
    # add string pointer to index to get arrry[index]
    write(outfile,"addq\t -24(%rbp), %rax")

    # make upper 32 bits of rax 0s.
    # avoid undefined behaviour
    write(outfile,"movzbl\t (%rax), %eax")

    # check for null character (\0)
    write(outfile,"testb\t %al, %al")
    write(outfile,"jne\t cooloutstr_check_newline")

    write(outfile,"movq\t stdout(%rip),%rax")
    write(outfile,"movq\t %rax, %rdi")
    # write data from buffer (stdout) to disk 
    write(outfile,"call\t fflush")

    write(outfile,"## leave is short for:")
    write(outfile,"## mov  %rbp, %rsp")
    write(outfile,"## pop %rbp")
    write(outfile,"## It cleans up the temporary stack that was allocated previously.")

    write(outfile,"leave")
    write(outfile,"ret")


# checks  if the  next two chars are for newline ()
# if not, check if they are for tab (\t)
def emit_cooloutstr_check_newline(outfile):
    write(outfile,"cooloutstr_check_newline:",not_tabbed=True)
    # load loop index
    write(outfile,"movl\t -4(%rbp), %eax")
    # convert eax to 64 bit (rax)
    write(outfile,"cltq")
    # add string pointer to get input[i]
    write(outfile,"addq\t -24(%rbp), %rax")
    # load byte at input[i]
    write(outfile,"movzbl\t (%rax), %eax")

    # check for backslash
    write(outfile,"cmpb\t $92, %al ## backslash ")
    # no backslash, check if its tab 
    write(outfile,"jne\t cooloutstr_check_tab")

    # load loop index
    write(outfile,"movl\t -4(%rbp), %eax")
    write(outfile,"cltq")
    # load next charcter (1 char = 1 byte)
    write(outfile,"addq\t $1, %rax")
    # add string pointer to get input[i+1]
    write(outfile,"addq\t -24(%rbp), %rax")
    # load byte at input[i+1] into eax.
    write(outfile,"movzbl\t (%rax), %eax")

    # check for n (newline) 
    # is input[i+1] == n?
    write(outfile,"cmpb\t $110, %al ## n for newline")
    #no n, check if its tab.
    write(outfile,"jne\t cooloutstr_check_tab")
    # -------- print newline --------
    # set up second argument  (stdout  for a call to putc.)
    # load address of stdout into rax
    # RIP relative addressing
    write(outfile,"movq\t stdout(%rip), %rax")
    write(outfile,"movq\t %rax, %rsi")
    # newline
    write(outfile,"movl\t $10, %edi ## line feed aka newline")

    # put newline to stdout buffer.
    write(outfile,"call\t fputc")

    # add 2 to index
    write(outfile,"addl\t $2, -4(%rbp)")
    write(outfile,"jmp\t cooloutstr_loop_start")


# checks  if the  next two chars are for tab (\t)
# if not, print normally. 
def emit_cooloutstr_check_tab(outfile):
    write(outfile,"cooloutstr_check_tab:",not_tabbed=True)
    # load index
    write(outfile,"movl\t -4(%rbp), %eax")
    write(outfile,"cltq")
    # add address of string.
    write(outfile,"addq\t -24(%rbp), %rax")
    write(outfile,"movzbl\t (%rax), %eax")
    
    # check for backslash
    write(outfile,"cmpb\t $92, %al ## backslash")
    # we dont have a backslash, so just print normally at this point.
    write(outfile,"jne\t cooloutstr_print")


    write(outfile,"movl\t -4(%rbp), %eax")
    write(outfile,"cltq")
    # lookahead
    write(outfile,"addq\t $1, %rax")
    write(outfile,"addq\t -24(%rbp), %rax")
    write(outfile,"movzbl\t (%rax), %eax")
    # t ( tab,  \t)
    write(outfile,"cmpb\t $116, %al ## t for tab")
    write(outfile,"jne\t cooloutstr_print")

    # print tab
    write(outfile,"movq\t stdout(%rip), %rax")
    write(outfile,"movq\t %rax, %rsi")
    write(outfile,"movl\t $9, %edi ## horizontal tab")

    # put horizontal tab in stdout buffer.
    write(outfile,"call\t fputc")

    # add 2 to index
    write(outfile,"addl\t $2, -4(%rbp)")
    write(outfile,"jmp\t cooloutstr_loop_start")



def emit_cooloutstr_print(outfile):
    write(outfile,"cooloutstr_print:",not_tabbed=True)
    write(outfile,"movq\t stdout(%rip), %rdx")
    write(outfile,"movl\t -4(%rbp), %eax")
    write(outfile,"cltq")
    write(outfile,"addq\t -24(%rbp), %rax")
    write(outfile,"movzbl\t (%rax), %eax")
    write(outfile,"movsbl\t %al, %eax")
    write(outfile,"movq\t %rdx, %rsi")
    write(outfile,"movl\t %eax, %edi")

    # put char (from array[index]) in stdout buffer
    write(outfile,"call\t fputc")
    
    #increment index
    write(outfile,"addl\t $1, -4(%rbp)")

    write(outfile,"jmp\t\t cooloutstr_loop_start")


def emit_coolstrlen_start(outfile): 
    # write(outfile,".globl coolstrlen",not_tabbed=True)
    write(outfile,"coolstrlen:",not_tabbed=True)
    write(outfile,"coolstrlen_start:",not_tabbed=True)
    write(outfile,"pushq\t %rbp")
    write(outfile,"movq\t %rsp, %rbp")
    # address of first char of string
    write(outfile,"movq\t %rdi, -24(%rbp)")

    # counter for length
    write(outfile,"movl\t $0, -4(%rbp)")
    write(outfile,"jmp coolstrlen_test")



# test char
def emit_coolstrlen_test(outfile):
    write(outfile,"coolstrlen_test:",True)
    write(outfile,"movl\t -4(%rbp), %eax")
    #  ?
    write(outfile,"mov\t\t %eax, %eax")

    # load character ( offset determiend by counter)
    write(outfile,"addq\t -24(%rbp), %rax")

    # byte to 32 bit
    write(outfile,"movzbl\t (%rax), %eax")
    
    # test for \0
    write(outfile,"testb\t %al, %al")
    write(outfile,"jne\t\t coolstrlen_increment")

    # it is terminator
    # move counter to eax
    write(outfile,"movl\t -4(%rbp), %eax")
    write(outfile,"leave")
    write(outfile,"ret")



def emit_coolstrlen_increment(outfile):
    write(outfile,"coolstrlen_increment:",True)
    write(outfile,"movl\t -4(%rbp), %eax")
    write(outfile,"addl\t $1, %eax")
    write(outfile,"movl\t %eax, -4(%rbp)")
    write(outfile,"jmp\t\t coolstrlen_test")



def emit_cat_placeholders(outfile):
    write(outfile,"cat_placeholders:",True)
    write(outfile,".string \"%s%s\"")
    write(outfile,".text")

def emit_coolstrcat_start(outfile):
    # write(outfile,".globl coolstrcat",True)
    write(outfile,"coolstrcat:",True)
    write(outfile,"coolstrcat_start:",True)
    write(outfile,"pushq\t %rbp")
    write(outfile,"movq\t %rsp, %rbp")
    write(outfile,"pushq\t %rbx")
    write(outfile,"subq\t $40, %rsp")

    # the strings
    write(outfile,"movq\t %rdi, -40(%rbp)")
    write(outfile,"movq\t %rsi, -48(%rbp)") 
    write(outfile,"cmpq\t $0, -40(%rbp)")
    write(outfile,"jne\t coolstrcat_check_second")

    #  first  is null,  just  return second  string
    write(outfile,"movq\t -48(%rbp), %rax")
    write(outfile,"jmp coolstrcat_return")

def emit_coolstrcat_check_second(outfile):
    write(outfile,"coolstrcat_check_second:",True)
    write(outfile,"cmpq\t $0, -48(%rbp)")
    write(outfile,"jne\t coolstrcat_concat")
    write(outfile,"movq\t -40(%rbp), %rax")
    write(outfile,"jne\t coolstrcat_return")

def emit_coolstrcat_concat(outfile):
    write(outfile,"coolstrcat_concat:",True)
    write(outfile,"movq\t -40(%rbp), %rax")
    write(outfile,"movq\t %rax, %rdi")
    write(outfile,"call\t coolstrlen")
    write(outfile,"movl\t %eax, %ebx")

    write(outfile,"movq\t -48(%rbp), %rax")
    write(outfile,"movq\t %rax, %rdi")
    write(outfile,"call\t coolstrlen")
    write(outfile,"leal\t (%rbx,%rax), %eax")
    #  for null character
    write(outfile,"addl\t $1, %eax")
    write(outfile,"movl\t %eax, -20(%rbp)")
    write(outfile,"movl\t -20(%rbp), %eax")
    write(outfile,"cltq")
    # size of each elements
    write(outfile,"movl\t $1, %esi")
    # number of elements (combined string lengths)
    write(outfile,"movq\t %rax, %rdi")
    write(outfile,"call\t calloc")

    # store resulting string 
    write(outfile,"movq\t %rax, -32(%rbp)")
    write(outfile,"movl\t $cat_placeholders, %edx")
    write(outfile,"movl\t -20(%rbp), %eax")
    write(outfile,"movslq\t %eax, %rbx")
    write(outfile,"movq\t -48(%rbp), %rsi")
    write(outfile,"movq\t -40(%rbp), %rcx")
    write(outfile,"movq\t -32(%rbp), %rax")

    write(outfile,"movq\t %rsi, %r8")
    write(outfile,"movq\t %rbx, %rsi")
    write(outfile,"movq\t %rax, %rdi")

    write(outfile,"movl\t $0, %eax")
    write(outfile,"call\t snprintf")
    write(outfile,"movq\t -32(%rbp), %rax")

def emit_coolstrcat_return(outfile):
    write(outfile,"coolstrcat_return:",True)
    write(outfile,"addq\t $40, %rsp")
    write(outfile,"popq\t %rbx")
    write(outfile,"leave")
    write(outfile,"ret")

def emit_coolsubstr_start(outfile):
    # write(outfile,".globl coolsubstr",True)
    write(outfile,"coolsubstr:",True)
    write(outfile,"coolsubstr_start:",True)
    write(outfile,"pushq\t %rbp")
    write(outfile,"movq\t %rsp, %rbp")
    write(outfile,"subq\t $48, %rsp")

    # the string
    write(outfile,"movq\t %rdi, -24(%rbp)")
    # starting index
    write(outfile,"movq\t %rsi, -32(%rbp)")
    # ending index
    write(outfile,"movq\t %rdx, -40(%rbp)")

    write(outfile,"movq\t -24(%rbp), %rax")
    write(outfile,"movq\t %rax, %rdi")
    write(outfile,"call\t coolstrlen")
    write(outfile,"movl\t %eax, -4(%rbp)")
    write(outfile,"cmpq\t $0, -32(%rbp)")
    write(outfile,"js\t coolsubstr_null")
    write(outfile,"cmpq\t $0, -40(%rbp)")
    write(outfile,"js\t coolsubstr_null")

    write(outfile,"movq\t -40(%rbp), %rax")
    write(outfile,"movq\t -32(%rbp), %rdx")
    # add ending index to starting index
    write(outfile,"addq\t %rax, %rdx")
    write(outfile,"movl\t -4(%rbp), %eax")
    write(outfile,"cltq")
    # compare length of string with addition of starting and ending index
    write(outfile,"cmpq\t %rax, %rdx")
    write(outfile,"jle coolsubstr_substr")

def emit_coolsubstr_null(outfile):
    write(outfile,"coolsubstr_null:",True)
    write(outfile,"movl\t $0, %eax")
    write(outfile,"jmp\t coolsubstr_end")

def emit_coolsubstr_substr(outfile):
    write(outfile,"coolsubstr_substr:",True)
    write(outfile,"movq\t -40(%rbp), %rdx")
    write(outfile,"movq\t -32(%rbp), %rax")
    # skip chars based on the  first number.
    # each char is 1 byte.
    write(outfile,"addq\t -24(%rbp), %rax")
    write(outfile,"movq\t %rdx, %rsi")
    write(outfile,"movq\t %rax, %rdi")
    write(outfile,"call\t strndup")
    

def emit_coolsubstr_end(outfile):
    write(outfile,"coolsubstr_end:",True)
    write(outfile,"leave")
    write(outfile,"ret")


def emit_empty_string(outfile):
    write(outfile,"empty_string:",True)
    write(outfile,".string \"\"")
    write(outfile,".text")

def emit_coolgetstr_start(outfile):
    write(outfile,"coolgetstr:",True)
    write(outfile,"coolgetstr_start:",True)
    write(outfile,"pushq\t %rbp")
    write(outfile,"movq\t %rsp, %rbp")
    write(outfile,"subq\t $32, %rsp")
    write(outfile,"movl\t $1, %esi")
    write(outfile,"movl\t $40960, %edi")

    # memory allocation for the string
    write(outfile,"call\t calloc")
    # store allocated string in -16(%rbp)
    write(outfile,"movq\t %rax, -16(%rbp)")
    # null char flag
    write(outfile,"movl\t $0, -4(%rbp)")

# L20
def emit_coolgetstr_loop_start(outfile):
    write(outfile,"coolgetstr_loop_start:",True)
    # read stdin stream one character at a time
    write(outfile,"movq\t stdin(%rip), %rax")
    write(outfile,"movq\t %rax, %rdi")
    # fgetc advances the stream.
    write(outfile,"call\t fgetc")
    # store read character in -20(%rbp)
    write(outfile,"movl\t %eax, -20(%rbp)")

    # check for EOF 
    write(outfile,"cmpl\t $-1, -20(%rbp)")
    write(outfile,"je\t coolgetstr_end_condition")

    # check for newline
    write(outfile,"cmpl\t $10, -20(%rbp)")
    write(outfile,"jne\t coolgetstr_check_null_char")

# L14
# \n or EOF
def emit_coolgetstr_end_condition(outfile):
    write(outfile,"coolgetstr_end_condition:",True)
    write(outfile,"cmpl\t $0, -4(%rbp)")
    write(outfile,"je\t coolgetstr_return_buffer")
    write(outfile,"movl\t $empty_string, %eax")
    write(outfile,"jmp\t coolgetstr_return")

# L16
# if input is null
def emit_coolgetstr_return_buffer(outfile):
    write(outfile,"coolgetstr_return_buffer:",True)
    write(outfile,"movq\t -16(%rbp), %rax")
    write(outfile,"jmp coolgetstr_return")

# L15
def emit_coolgetstr_check_null_char(outfile):
    write(outfile,"coolgetstr_check_null_char:",True)
    # check for null character
    write(outfile,"cmpl\t $0, -20(%rbp)")
    write(outfile,"jne\t coolgetstr_store_char")
    write(outfile,"movl\t $1, -4(%rbp)")
    write(outfile,"jmp\t coolgetstr_loop_start")

# L18
def emit_coolgetstr_store_char(outfile):
    write(outfile,"coolgetstr_store_char:",True)
    # base address of buffer
    write(outfile,"movq\t -16(%rbp), %rax")
    write(outfile,"movq\t %rax, %rdi")
    # current string length
    write(outfile,"call\t coolstrlen")
    write(outfile,"mov\t %eax, %eax")

    # next write location
    write(outfile,"addq\t -16(%rbp), %rax")
    # input character 
    write(outfile,"movl\t -20(%rbp), %edx")
    # store character 
    write(outfile,"movb\t %dl, (%rax)")
    write(outfile,"jmp\t coolgetstr_loop_start")
    

# L17
# final raw string should be in rax
def emit_coolgetstr_return(outfile):
    write(outfile,"coolgetstr_return:",True)
    write(outfile,"leave")
    write(outfile,"ret")





    

    











