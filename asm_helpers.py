from asm_instructions import *
from asm_registers import *
from asm_constants import *

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

    # comparing objects.
    # first argument 
    asm_instructions.append(ASM_Ld(acc_reg,"fp",3))
    # second argument
    asm_instructions.append(ASM_Ld(temp_reg,"fp",2))

    # if they are equal, true!
    asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_true"))

    # check if either operand is null. 
    asm_instructions.append(ASM_Li(temp2_reg,ASM_Word(0)))
    asm_instructions.append(ASM_Beq(acc_reg,temp2_reg,"eq_false"))
    asm_instructions.append(ASM_Beq(temp2_reg,temp2_reg,"eq_false"))
    
    # do some shenanigans with type tags to check for types of operands.
    asm_instructions.append(ASM_Ld(acc_reg,acc_reg,type_tag_index))
    asm_instructions.append(ASM_Ld(temp_reg,temp_reg,type_tag_index))

    # add type tags to then check for operand types. 
    asm_instructions.append(ASM_Add(temp_reg,acc_reg))

    # check for bool and bool
    asm_instructions.append(ASM_Comment("Both operands are Bools"))
    asm_instructions.append(ASM_Li(acc_reg,ASM_Word(Bool_tag + Bool_tag))) 
    asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_bool"))
    # check for int and int
    asm_instructions.append(ASM_Comment("Both operands are Ints"))
    asm_instructions.append(ASM_Li(acc_reg,ASM_Word(Int_tag+Int_tag))) 
    asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_int"))

    # TODO: do same for string

    asm_instructions.append(ASM_Comment("otherwise, use pointer comparison"))
    # first argument 
    asm_instructions.append(ASM_Ld(acc_reg,"fp",3))
    # second argument
    asm_instructions.append(ASM_Ld(temp_reg,"fp",2))
    asm_instructions.append(ASM_Beq(acc_reg,temp_reg, "eq_true"))

# IMPORTANT- this should be emitted under eq handler for correct fall through.
def emit_eq_false(asm_instructions : list, x86:bool) -> None:
    asm_instructions.append(ASM_Label("eq_false"))
    asm_instructions.append(ASM_Comment("not equal"))
    asm_instructions.append(ASM_Push("fp"))
    asm_instructions.append(ASM_Push(self_reg))
    asm_instructions.append(ASM_Call_Label("Bool..new"))
    # Bools store 0 by default.
    asm_instructions.append(ASM_Pop(self_reg))
    asm_instructions.append(ASM_Pop("fp"))
    asm_instructions.append(ASM_Jmp("eq_end"))


def emit_eq_true(asm_instructions : list, x86:bool) -> None:
    asm_instructions.append(ASM_Label("eq_true"))
    asm_instructions.append(ASM_Comment("equal"))
    asm_instructions.append(ASM_Push("fp"))
    asm_instructions.append(ASM_Push(self_reg))
    asm_instructions.append(ASM_Call_Label("Bool..new"))
    asm_instructions.append(ASM_Pop(self_reg))
    asm_instructions.append(ASM_Pop("fp"))

    # store 1 in the attribute, because its true.
    asm_instructions.append(ASM_Comment("store 1 in attribute, because its true!"))
    asm_instructions.append(ASM_Li(temp_reg,ASM_Value(1)))
    asm_instructions.append(ASM_St(acc_reg,temp_reg,attributes_start_index))
    asm_instructions.append(ASM_Jmp("eq_end"))



# IMPORTANT - this should fall through to eq_int.
def emit_eq_bool(asm_instructions : list, x86:bool) -> None:
    asm_instructions.append(ASM_Label("eq_bool"))
    asm_instructions.append(ASM_Comment("two bools"))
def emit_eq_int(asm_instructions : list, x86:bool) -> None:
    asm_instructions.append(ASM_Label("eq_int"))
    asm_instructions.append(ASM_Comment("two ints"))

    # both objects
    asm_instructions.append(ASM_Ld(acc_reg,"fp",3))
    asm_instructions.append(ASM_Ld(temp_reg,"fp",2))

    asm_instructions.append(ASM_Comment("Extract raw values."))
    asm_instructions.append(ASM_Ld(acc_reg,acc_reg,attributes_start_index))
    asm_instructions.append(ASM_Ld(temp_reg,temp_reg,attributes_start_index))

    asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_true"))
    asm_instructions.append(ASM_Jmp("eq_false"))


    

# IMPORTANT - tihs must be emitted
def emit_eq_end(asm_instructions : list, x86:bool) -> None:

    # x86 handles cleanup in caller
    # cool does so in callee.
    if not x86:
        # asm_instructions.append(ASM_Pop("ra"))
        asm_instructions.append(ASM_Ld("ra","sp",1))
        # + 1 for ra
        # + 1 for self object
        # + 1 for second arg
        # + 1 for first arg
        asm_instructions.append(ASM_Li(temp_reg,ASM_Word(4)))
        asm_instructions.append(ASM_Add(temp_reg,"sp"))
    


    if x86:
        asm_instructions.append(ASM_Pop("fp"))
    asm_instructions.append(ASM_Return())
    

