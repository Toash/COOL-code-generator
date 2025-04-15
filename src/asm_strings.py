from asm_instructions import *
from asm_registers import *
from asm_constants import *



def emit_string_constants(asm_instructions: list, x86:bool, string_label:dict)->None:
    asm_instructions.append(ASM_Label("the.empty.string"))
    asm_instructions.append(ASM_Constant_raw_string(""))

    asm_instructions.append(ASM_Label("cool_abort"))
    asm_instructions.append(ASM_Constant_raw_string("abort\\n"))

    asm_instructions.append(ASM_Label("substr_bad"))
    asm_instructions.append(ASM_Constant_raw_string("ERROR: 0: Exception: String.substr out of range\\n"))

    for string,label in string_label.items():
        asm_instructions.append(ASM_Label(label))
        asm_instructions.append(ASM_Constant_raw_string(string))


# could have been in string constants but whatever
def emit_dispatch_on_void(asm_instructions: list,line_number:int)->None:
    asm_instructions.append(ASM_Label(f"dispatch_void_{line_number}"))
    asm_instructions.append(ASM_Constant_raw_string(f"ERROR: {line_number}: Exception: dispatch on void\\n"))

def emit_case_on_void(asm_instructions: list,line_number:int)->None:
    asm_instructions.append(ASM_Label(f"case_void_{line_number}"))
    asm_instructions.append(ASM_Constant_raw_string(f"ERROR: {line_number}: Exception: case on void\\n"))

def emit_case_without_branch(asm_instructions: list,line_number:int)->None:
    asm_instructions.append(ASM_Label(f"case_without_branch_{line_number}"))
    asm_instructions.append(ASM_Constant_raw_string(f"ERROR: {line_number}: Exception: case without matching branch\\n"))

def emit_divide_by_zero(asm_instructions: list,line_number:int)->None:
    asm_instructions.append(ASM_Label(f"divide_by_zero_{line_number}"))
    asm_instructions.append(ASM_Constant_raw_string(f"ERROR: {line_number}: Exception: division by zero\\n"))
