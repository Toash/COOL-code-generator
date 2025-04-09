from asm_instructions import *
from asm_registers import *
from asm_constants import *

   
def write(outfile,string,not_tabbed = False):
    if not_tabbed:
        outfile.write(string)
    else:
        outfile.write("\t\t" + string)

# used when passing into printf.
def c_placeholders(outfile):
    # integer
    write(outfile,"percent.d:\n",not_tabbed=True)
    write(outfile,".byte 37 \t# '%'\n")
    write(outfile,".byte 108 \t# 'l'\n")
    write(outfile,".byte 100 \t# 'd'\n")
    write(outfile,".byte 0\n")

    # long integer
    write(outfile,"percent.ld:\n", not_tabbed = True)
    write(outfile,".byte 32 \t# ' '\n")
    write(outfile,".byte 37 \t# '%'\n")
    write(outfile,".byte 108 \t# 'l'\n")
    write(outfile,".byte 100 \t# 'd'\n")
    write(outfile,".byte 0\n")
    
 
# .LFB0
# loads string pointer into offset from rbp,
#   string pointer should be at rdi. 

# initializes loop index and jumps to loop start.
def emit_cooloutstr_start(outfile):
    write(outfile,".globl cooloutstr\n", not_tabbed  = True)
    # metadata for assembler
    write(outfile,".type\tcooloutstr, @function\n")
    write(outfile,"cooloutstr:\n", not_tabbed  = True)
    write(outfile,"cooloutstr_start:\n",not_tabbed=True)

    write(outfile,"pushq\t%rbp\n")
    write(outfile,"movq\t%rsp, %rbp\n")

    # we allocate this much for padding.
    write(outfile,"subq\t$32, %rsp\n")

    # rdi should be string pointer
    write(outfile,"movq\t%rdi, -24(%rbp) ## rdi should be the string pointer (label to the string).\n")

    # initialize loop index 
    # -4(%rbp) expects 4 bytes! cannot use movq.
    write(outfile,"movl\t$0, -4(%rbp)\n")
    # ^ has gap for alignment.

    write(outfile,"jmp\tcooloutstr_loop_start\n")

# .L2
def emit_cooloutstr_loop_start(outfile):
    write(outfile,"cooloutstr_loop_start:\n", not_tabbed  = True)
    write(outfile,"movl\t-4(%rbp), %eax\n")

    # eax -> rax
    write(outfile,"cltq\n")
    # add string pointer to index to get arrry[index]
    write(outfile,"addq\t -24(%rbp), %rax\n")

    # make upper 32 bits of rax 0s.
    # avoid undefined behaviour
    write(outfile,"movzbl\t (%rax), %eax\n")

    # check for null character (\0)
    write(outfile,"testb\t %al, %al\n")
    write(outfile,"jne\t print_check_newline\n")

    write(outfile,"movq\t stdout(%rip),%rax\n")
    write(outfile,"movq\t %rax, %rdi\n")
    # write data from buffer (stdout) to disk 
    write(outfile,"call\t fflush\n")

    write(outfile,"## leave is short for:\n")
    write(outfile,"## mov  %rbp, %rsp\n")
    write(outfile,"## pop %rbp\n")
    write(outfile,"## It cleans up the temporary stack that was allocated previously.\n")

    write(outfile,"leave\n")
    write(outfile,"ret\n")


# .L5
# checks  if the  next two chars are for newline (\n)
# if not, check if they are for tab (\t)
def emit_print_check_newline(outfile):
    write(outfile,"print_check_newline:\n",not_tabbed=True)
    # load loop index
    write(outfile,"movl\t -4(%rbp), %eax\n")
    # convert eax to 64 bit (rax)
    write(outfile,"cltq\n")
    # add string pointer to get input[i]
    write(outfile,"addq\t -24(%rbp), %rax\n")
    # load byte at input[i]
    write(outfile,"movzbl\t (%rax), %eax\n")

    # check for backslash
    write(outfile,"cmpb\t $92, %al ## backslash \n")
    # no backslash, check if its tab 
    write(outfile,"jne\t print_check_tab\n")

    # load loop index
    write(outfile,"movl\t -4(%rbp), %eax\n")
    write(outfile,"cltq\n")
    # load next charcter (1 char = 1 byte)
    write(outfile,"addq\t $1, %rax\n")
    # add string pointer to get input[i+1]
    write(outfile,"addq\t -24(%rbp), %rax\n")
    # load byte at input[i+1] into eax.
    write(outfile,"movzbl\t (%rax), %eax\n")

    # check for n (newline) 
    # is input[i+1] == n?
    write(outfile,"cmpb\t $110, %al ## n for newline\n")
    #no n, check if its tab.
    write(outfile,"jne\t print_check_tab\n")
    # -------- print newline --------
    # set up second argument  (stdout  for a call to putc.)
    # load address of stdout into rax
    # RIP relative addressing
    write(outfile,"movq\t stdout(%rip), %rax\n")
    write(outfile,"movq\t %rax, %rsi\n")
    # newline
    write(outfile,"movl\t $10, %edi ## line feed aka newline\n")

    # put newline to stdout buffer.
    write(outfile,"call\t fputc\n")

    # add 2 to index
    write(outfile,"addl\t $2, -4(%rbp)\n")
    write(outfile,"jmp\t cooloutstr_loop_start\n")


# .L3
# checks  if the  next two chars are for tab (\t)
# if not, print normally. 
def emit_print_check_tab(outfile):
    write(outfile,"print_check_tab:\n",not_tabbed=True)
    # load index
    write(outfile,"movl\t -4(%rbp), %eax\n")
    write(outfile,"cltq\n")
    # add address of string.
    write(outfile,"addq\t -24(%rbp), %rax\n")
    write(outfile,"movzbl\t (%rax), %eax\n")
    
    # check for backslash
    write(outfile,"cmpb\t $92, %al ## backslash\n")
    # we dont have a backslash, so just print normally at this point.
    write(outfile,"jne\t print\n")


    write(outfile,"movl\t -4(%rbp), %eax\n")
    write(outfile,"cltq\n")
    # lookahead
    write(outfile,"addq\t $1, %rax\n")
    write(outfile,"addq\t -24(%rbp), %rax\n")
    write(outfile,"movzbl\t (%rax), %eax\n")
    # t ( tab,  \t)
    write(outfile,"cmpb\t $116, %al ## t for tab\n")
    write(outfile,"jne\t print\n")

    # print tab
    write(outfile,"movq\t stdout(%rip), %rax\n")
    write(outfile,"movq\t %rax, %rsi\n")
    write(outfile,"movl\t $9, %edi ## horizontal tab\n")

    # put horizontal tab in stdout buffer.
    write(outfile,"call\t fputc\n")

    # add 2 to index
    write(outfile,"addl\t $2, -4(%rbp)\n")
    write(outfile,"jmp\t cooloutstr_loop_start\n")



# .L4
def emit_print(outfile):
    write(outfile,"print:\n",not_tabbed=True)
    write(outfile,"movq\t stdout(%rip), %rdx\n")
    write(outfile,"movl\t -4(%rbp), %eax\n")
    write(outfile,"cltq\n")
    write(outfile,"addq\t -24(%rbp), %rax\n")
    write(outfile,"movzbl\t (%rax), %eax\n")
    write(outfile,"movsbl\t %al, %eax\n")
    write(outfile,"movq\t %rdx, %rsi\n")
    write(outfile,"movl\t %eax, %edi\n")

    # put char (from array[index]) in stdout buffer
    write(outfile,"call\t fputc\n")
    
    #increment index
    write(outfile,"addl\t $1, -4(%rbp)\n")

    write(outfile,"jmp\t cooloutstr_loop_start\n")


    






