from asm_instructions import *
from asm_registers import *

def emit_eq_handler(asm_instructions : list, x86:bool) -> None:
    if x86:
        asm_instructions.append(ASM_Push("fp"))

    asm_instructions.append(ASM_Label("eq_handler"))
    asm_instructions.append(ASM_Comment("helper function for ="))
    asm_instructions.append(ASM_Mov("fp","sp"))
    
    # get self
    asm_instructions.append(ASM_Ld(self_reg,"sp",1))

    if not x86:
        asm_instructions.append(ASM_Push("ra")) 

    # we are probably comparing raw values.
    # first argument 
    asm_instructions.append(ASM_Ld(acc_reg,"fp",3))
    # second argument
    asm_instructions.append(ASM_Ld(temp_reg,"fp",2))

    # if they are equal, true!
    asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_true"))

    # ? 
    asm_instructions.append(ASM_Li(temp2_reg,ASM_Word(0)))
    asm_instructions.append(ASM_Beq(acc_reg,temp2_reg,"eq_false"))
    asm_instructions.append(ASM_Beq(temp2_reg,temp2_reg,"eq_false"))
    
    #asm_instructions.append(ASM_Ld(acc_reg,acc_reg,



    if x86:
        asm_instructions.append(ASM_Pop("fp"))

    

