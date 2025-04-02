from collections import namedtuple



# https://kelloggm.github.io/martinjkellogg.com/teaching/cs485-sp25/crm/modern/Cool%20Assembly%20Language.html
ASM_Comment = namedtuple("ASM_Comment", "comment not_tabbed",defaults=[False])
ASM_Label = namedtuple("ASM_Label", "label")

ASM_Li = namedtuple("ASM_Li", "reg imm") # li r1 <- 123
ASM_Mov = namedtuple("ASM_Mov", "dest src") # mov r1 <- r2

ASM_Add = namedtuple("ASM_Add", "dst left right")
ASM_Sub = namedtuple("ASM_Sub", "dst left right")
ASM_Mul = namedtuple("ASM_Mul", "dst left right")
ASM_Div = namedtuple("ASM_Div", "dst left right")

ASM_Jmp = namedtuple("ASM_Jmp", "label")
ASM_Bz = namedtuple("ASM_Bz", "reg label")
ASM_Bnz = namedtuple("ASM_Bnz", "reg label")
ASM_Beq = namedtuple("ASM_Beq", "left right label")
ASM_Blt = namedtuple("ASM_Blt", "left right label")
ASM_Ble = namedtuple("ASM_Ble", "left right label")

ASM_Call_Label = namedtuple("ASM_Call_Label", "label")
ASM_Call_Reg = namedtuple("ASM_Call_Reg", "reg")#jump to address stored in register
ASM_Return = namedtuple("ASM_Return", "") # go to address in ra register (we handle popping ourself)

ASM_Push = namedtuple("ASM_Push", "reg")
ASM_Pop = namedtuple("ASM_Pop", "reg")

# Memory instructions
ASM_Ld = namedtuple("ASM_Ld", "dest src offset") # dest <- src[offset]
ASM_St = namedtuple("ASM_St", "dest src offset") # dest[offset] <- src

ASM_La = namedtuple("ASM_La", "reg label") # load address in register

# alloc r1 r2 allocates memory by amount in r2 and stores pointer in r1.
ASM_Alloc = namedtuple("ASM_Alloc", "dest src")
ASM_Constant_integer = namedtuple("ASM_Constant_integer", "int")
ASM_Constant_raw_string = namedtuple("ASM_Constant_raw_string", "string")
ASM_Constant_label = namedtuple("ASM_Constant_label", "label")

ASM_Syscall = namedtuple("ASM_Syscall", "name")
