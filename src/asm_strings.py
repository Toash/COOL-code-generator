from asm_instructions import *
from asm_registers import *
from asm_constants import *



def emit_string_constants(asm_instructions: list, x86:bool, string_label:dict)->None:
    asm_instructions.append(ASM_Label("the.empty.string"))
    asm_instructions.append(ASM_Constant_raw_string(""))

    for string,label in string_label.items():
        asm_instructions.append(ASM_Label(label))
        asm_instructions.append(ASM_Constant_raw_string(string))