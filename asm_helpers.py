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
    
    # ?
    asm_instructions.append(ASM_Ld(acc_reg,"fp",3))
    asm_instructions.append(ASM_Ld(temp_reg,"fp",2))

    if x86:
        asm_instructions.append(ASM_Pop("fp"))

