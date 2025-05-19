from asm_instructions import *
from asm_registers import *
from asm_constants import *

def emit_comparison_handlers(asm_instructions,x86):
    emit_comparison_handler("eq", asm_instructions,x86)
    emit_comparison_false("eq", asm_instructions,x86)
    emit_comparison_true("eq", asm_instructions,x86)
    emit_comparison_bool("eq", asm_instructions,x86)
    emit_comparison_int("eq", asm_instructions,x86)
    emit_comparison_string("eq", asm_instructions,x86)
    emit_comparison_end("eq", asm_instructions,x86)

    emit_comparison_handler("le", asm_instructions,x86)
    emit_comparison_false("le", asm_instructions,x86)
    emit_comparison_true("le", asm_instructions,x86)
    emit_comparison_bool("le", asm_instructions,x86)
    emit_comparison_int("le", asm_instructions,x86)
    emit_comparison_string("le", asm_instructions,x86)
    emit_comparison_end("le", asm_instructions,x86)

    emit_comparison_handler("lt", asm_instructions,x86)
    emit_comparison_false("lt", asm_instructions,x86)
    emit_comparison_true("lt", asm_instructions,x86)
    emit_comparison_bool("lt", asm_instructions,x86)
    emit_comparison_int("lt", asm_instructions,x86)
    emit_comparison_string("lt", asm_instructions,x86)
    emit_comparison_end("lt", asm_instructions,x86)


"""
type can be 
eq, lt ,le
"""
def emit_comparison_handler(type:str,asm_instructions : list, x86:bool) -> None:

    if type == "eq":
        asm_instructions.append(ASM_Label("eq_handler"))
        asm_instructions.append(ASM_Comment("helper function for ="))
    elif type == "lt":
        asm_instructions.append(ASM_Label("lt_handler"))
        asm_instructions.append(ASM_Comment("helper function for <"))
    elif type == "le":
        asm_instructions.append(ASM_Label("le_handler"))
        asm_instructions.append(ASM_Comment("helper function for <="))
    
    if x86:
        asm_instructions.append(ASM_Push("fp"))
    asm_instructions.append(ASM_Mov("fp","sp"))
    
    # get self
    asm_instructions.append(ASM_Ld(self_reg,"sp",1))

    if not x86:
        asm_instructions.append(ASM_Push("ra")) 

    # arguments
    if not x86:
        asm_instructions.append(ASM_Ld(acc_reg,"fp",3))
        asm_instructions.append(ASM_Ld(temp_reg,"fp",2))
    else:
        # one more for the frame pointer pushed on the stack.
        asm_instructions.append(ASM_Ld(acc_reg,"fp",4))
        asm_instructions.append(ASM_Ld(temp_reg,"fp",3))

    if type == "eq":
        # if they are equal, true!
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_true"))
    elif type == "le":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"le_true"))


    # check if either operand is null. 
    asm_instructions.append(ASM_Li(temp2_reg,ASM_Value(0)))
    if type == "eq":
        asm_instructions.append(ASM_Beq(acc_reg,temp2_reg,"eq_false"))
        asm_instructions.append(ASM_Beq(temp_reg,temp2_reg,"eq_false"))
    elif type == "lt":
        asm_instructions.append(ASM_Beq(acc_reg,temp2_reg,"lt_false"))
        asm_instructions.append(ASM_Beq(temp_reg,temp2_reg,"lt_false"))
    elif type == "le":
        asm_instructions.append(ASM_Beq(acc_reg,temp2_reg,"le_false"))
        asm_instructions.append(ASM_Beq(temp_reg,temp2_reg,"le_false"))
    
    # do some shenanigans with type tags to check for types of operands.
    asm_instructions.append(ASM_Ld(acc_reg,acc_reg,type_tag_index))
    asm_instructions.append(ASM_Ld(temp_reg,temp_reg,type_tag_index))

    # add type tags to then check for operand types. 
    asm_instructions.append(ASM_Add(temp_reg,acc_reg))

    # check for bool and bool
    asm_instructions.append(ASM_Comment("Both operands are Bools"))
    asm_instructions.append(ASM_Li(temp_reg,ASM_Value(Bool_tag + Bool_tag))) 
    if type == "eq":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_bool"))
    elif type == "lt":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"lt_bool"))
    elif type == "le":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"le_bool"))

    # check for int and int
    asm_instructions.append(ASM_Comment("Both operands are Ints"))
    asm_instructions.append(ASM_Li(temp_reg,ASM_Value(Int_tag+Int_tag))) 
    if type == "eq":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_int"))
    elif type == "lt":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"lt_int"))
    elif type == "le":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"le_int"))

    # check for string and string 
    asm_instructions.append(ASM_Comment("Both operands are Strings"))
    asm_instructions.append(ASM_Li(temp_reg,ASM_Value(String_tag+String_tag))) 
    if type == "eq":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_string"))
    elif type == "lt":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"lt_string"))
    elif type == "le":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"le_string"))

    if type == "eq":
        asm_instructions.append(ASM_Comment("otherwise, use pointer comparison"))
        if not x86:
            asm_instructions.append(ASM_Ld(acc_reg,"fp",3))
            asm_instructions.append(ASM_Ld(temp_reg,"fp",2))
        else:
            asm_instructions.append(ASM_Ld(acc_reg,"fp",4))
            asm_instructions.append(ASM_Ld(temp_reg,"fp",3))
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg, "eq_true"))
    elif type == "lt":
        asm_instructions.append(ASM_Comment("for non-primitives, < is always false."))
        asm_instructions.append(ASM_Comment("so just fall through to false label"))
    elif type == "le":
        asm_instructions.append(ASM_Comment("just like eq, use pointer comparison"))
        if not x86:
            asm_instructions.append(ASM_Ld(acc_reg,"fp",3))
            asm_instructions.append(ASM_Ld(temp_reg,"fp",2))
        else:
            asm_instructions.append(ASM_Ld(acc_reg,"fp",4))
            asm_instructions.append(ASM_Ld(temp_reg,"fp",3))
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg, "le_true"))

# IMPORTANT- this should be emitted under eq handler for correct fall through.
def emit_comparison_false(type:str,asm_instructions : list, x86:bool) -> None:
    if type == "eq":
        asm_instructions.append(ASM_Label("eq_false"))
        asm_instructions.append(ASM_Comment("not equal"))
    elif type == "lt":
        asm_instructions.append(ASM_Label("lt_false"))
        asm_instructions.append(ASM_Comment("not less than"))
    elif type == "le":
        asm_instructions.append(ASM_Label("le_false"))
        asm_instructions.append(ASM_Comment("not less than or equal"))
    asm_instructions.append(ASM_Comment("Just create a bool with defualt initialization (0)"))
    asm_instructions.append(ASM_Push("fp"))
    asm_instructions.append(ASM_Push(self_reg))
    asm_instructions.append(ASM_Call_Label("Bool..new"))
    asm_instructions.append(ASM_Pop(self_reg))
    asm_instructions.append(ASM_Pop("fp"))

    if type=="eq":
        asm_instructions.append(ASM_Jmp("eq_end"))
    elif type=="lt":
        asm_instructions.append(ASM_Jmp("lt_end"))
    elif type=="le":
        asm_instructions.append(ASM_Jmp("le_end"))


def emit_comparison_true(type:str,asm_instructions : list, x86:bool) -> None:
    if type == "eq":
        asm_instructions.append(ASM_Label("eq_true"))
        asm_instructions.append(ASM_Comment("equal"))
    elif type == "lt":
        asm_instructions.append(ASM_Label("lt_true"))
        asm_instructions.append(ASM_Comment("less than"))
    elif type == "le":
        asm_instructions.append(ASM_Label("le_true"))
        asm_instructions.append(ASM_Comment("less than or equal"))
    asm_instructions.append(ASM_Push("fp"))
    asm_instructions.append(ASM_Push(self_reg))
    asm_instructions.append(ASM_Call_Label("Bool..new"))
    asm_instructions.append(ASM_Pop(self_reg))
    asm_instructions.append(ASM_Pop("fp"))

    # store 1 in the attribute, because its true.
    asm_instructions.append(ASM_Comment("store 1 in attribute, because its true!"))
    asm_instructions.append(ASM_Li(temp_reg,ASM_Value(1)))
    asm_instructions.append(ASM_St(acc_reg,temp_reg,attributes_start_index))
    if type == "eq":
        asm_instructions.append(ASM_Jmp("eq_end"))
    elif type == "lt":
        asm_instructions.append(ASM_Jmp("lt_end"))
    elif type == "le":
        asm_instructions.append(ASM_Jmp("le_end"))


# IMPORTANT - this should fall through to eq_int.
def emit_comparison_bool(type:str,asm_instructions : list, x86:bool) -> None:
    if type == "eq":
        asm_instructions.append(ASM_Label("eq_bool"))
    elif type == "lt":
        asm_instructions.append(ASM_Label("lt_bool"))
    elif type == "le":
        asm_instructions.append(ASM_Label("le_bool"))
    asm_instructions.append(ASM_Comment("two bools"))

def emit_comparison_int(type:str,asm_instructions : list, x86:bool) -> None:
    if type == "eq":
        asm_instructions.append(ASM_Label("eq_int"))
    elif type == "lt":
        asm_instructions.append(ASM_Label("lt_int"))
    elif type == "le":
        asm_instructions.append(ASM_Label("le_int"))
    asm_instructions.append(ASM_Comment("two ints"))
    asm_instructions.append(ASM_Comment("both ints and bools just compare their raw underlying integer values."))

    # args
    if not x86:
        asm_instructions.append(ASM_Ld(acc_reg,"fp",3))
        asm_instructions.append(ASM_Ld(temp_reg,"fp",2))
    else:
        asm_instructions.append(ASM_Ld(acc_reg,"fp",4))
        asm_instructions.append(ASM_Ld(temp_reg,"fp",3))

    asm_instructions.append(ASM_Comment("Extract raw values."))
    asm_instructions.append(ASM_Ld(acc_reg,acc_reg,attributes_start_index))
    asm_instructions.append(ASM_Ld(temp_reg,temp_reg,attributes_start_index))

    if type == "eq":
        asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_true"))
        asm_instructions.append(ASM_Jmp("eq_false"))
    elif type == "lt":
        asm_instructions.append(ASM_Blt(acc_reg,temp_reg,"lt_true"))
        asm_instructions.append(ASM_Jmp("lt_false"))
    elif type == "le":
        asm_instructions.append(ASM_Ble(acc_reg,temp_reg,"le_true"))
        asm_instructions.append(ASM_Jmp("le_false"))

def emit_comparison_string(type:str,asm_instructions : list, x86:bool) -> None:
    if type == "eq":
        asm_instructions.append(ASM_Label("eq_string"))
    elif type == "lt":
        asm_instructions.append(ASM_Label("lt_string"))
    elif type == "le":
        asm_instructions.append(ASM_Label("le_string"))
    asm_instructions.append(ASM_Comment("two strings"))
    if not x86:
        asm_instructions.append(ASM_Ld(acc_reg,"fp",3))
        asm_instructions.append(ASM_Ld(temp_reg,"fp",2))
    else:
        asm_instructions.append(ASM_Ld(acc_reg,"fp",4))
        asm_instructions.append(ASM_Ld(temp_reg,"fp",3))

    asm_instructions.append(ASM_Comment("Extract raw values."))
    asm_instructions.append(ASM_Ld(acc_reg,acc_reg,attributes_start_index))
    asm_instructions.append(ASM_Ld(temp_reg,temp_reg,attributes_start_index))
    
    # load first char. 
    if not x86:
        asm_instructions.append(ASM_Ld(acc_reg,acc_reg,0))
        asm_instructions.append(ASM_Ld(temp_reg,temp_reg,0))
        if type == "eq":
            asm_instructions.append(ASM_Beq(acc_reg,temp_reg,"eq_true"))
            asm_instructions.append(ASM_Jmp("eq_false"))
        elif type == "lt":
            asm_instructions.append(ASM_Blt(acc_reg,temp_reg,"lt_true"))
            asm_instructions.append(ASM_Jmp("lt_false"))
        elif type == "le":
            asm_instructions.append(ASM_Ble(acc_reg,temp_reg,"le_true"))
            asm_instructions.append(ASM_Jmp("le_false"))
    else:
        if type == "eq":
            asm_instructions.append(ASM_Syscall("string_compare_eq"))
        elif type == "lt":
            asm_instructions.append(ASM_Syscall("string_compare_le"))
        elif type == "le":
            asm_instructions.append(ASM_Syscall("string_compare_lt"))






# IMPORTANT - tihs must be emitted
def emit_comparison_end(type:str,asm_instructions : list, x86:bool) -> None:

    if type == "eq":
        asm_instructions.append(ASM_Label("eq_end"))
    elif type == "lt":
        asm_instructions.append(ASM_Label("lt_end"))
    elif type == "le":
        asm_instructions.append(ASM_Label("le_end"))

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
        asm_instructions.append(ASM_Mov("sp","fp"))
        asm_instructions.append(ASM_Pop("fp")) # get back old base pointer
    asm_instructions.append(ASM_Return())
    

