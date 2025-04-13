from asm_instructions import *
from asm_registers import *
from asm_constants import *



def emit_string_constants(asm_instructions: list, x86:bool, string_label:dict)->None:
    asm_instructions.append(ASM_Label("the.empty.string"))
    asm_instructions.append(ASM_Constant_raw_string(""))

    for string,label in string_label.items():
        asm_instructions.append(ASM_Label(label))
        asm_instructions.append(ASM_Constant_raw_string(string))


def emit_dispatch_on_void(asm_instructions: list,line_number:int)->None:
    asm_instructions.append(ASM_Label(f"dispatch_void_{line_number}"))
    asm_instructions.append(ASM_Constant_raw_string(f"ERROR: {line_number}: Exception: dispatch on void\\n"))

def emit_substr_out_of_range(asm_instructions: list)->None:
    asm_instructions.append(ASM_Label("substr_bad"))
    asm_instructions.append(ASM_Constant_raw_string("ERROR: 0: Exception: String.substr out of range\\n"))