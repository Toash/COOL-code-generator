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
    asm_instructions.append(ASM_Label(f"dispatch_void_string_{line_number}"))
    asm_instructions.append(ASM_Constant_raw_string(f"ERROR: {line_number}: Exception: dispatch on void\\n"))

def emit_case_on_void(asm_instructions: list,line_number:int)->None:
    asm_instructions.append(ASM_Label(f"case_void_string_{line_number}"))
    asm_instructions.append(ASM_Constant_raw_string(f"ERROR: {line_number}: Exception: case on void\\n"))

def emit_case_without_branch(asm_instructions: list,line_number:int,exp:namedtuple)->None:
    # print(exp)
    exp_type = exp.StaticType
    asm_instructions.append(ASM_Label(f"case_without_branch_string_{line_number}_{exp_type}"))


    match(exp_type):
        case "Int":
            exp_string = f"{exp_type}({exp.Integer})" 
        case "Bool":
            # manually compute boolean

            def get_result(exp_type):
                match exp_type:
                    case "Lt":
                        left = int(exp.Left[1].Integer)
                        right = int(exp.Right[1].Integer)
                        return  left<right
                    case "Lte":
                        left = int(exp.Left[1].Integer)
                        right = int(exp.Right[1].Integer)
                        return  left<=right
                    case "Eq":
                        left = int(exp.Left[1].Integer)
                        right = int(exp.Right[1].Integer)
                        return left==right
                    case "Not":
                        return get_result(exp.Exp[1])
                    case "true":
                        return True 
                    case "false":
                        return False

            result = get_result(type(exp).__name__)
            
            if result:
                exp_string = f"Bool(true)" 
            else:
                exp_string = f"Bool(false)" 

        case "String":
            exp_string = f"{exp_type}({exp.String})" 
        case _:
            # user defined objects
            exp_string = f"{exp_type}(...)" 
    asm_instructions.append(ASM_Constant_raw_string(f"ERROR: {line_number}: Exception: case without matching branch: {exp_string}\\n"))

def emit_divide_by_zero(asm_instructions: list,line_number:int)->None:
    asm_instructions.append(ASM_Label(f"divide_by_zero_string_{line_number}"))
    asm_instructions.append(ASM_Constant_raw_string(f"ERROR: {line_number}: Exception: division by zero\\n"))
