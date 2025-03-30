# TAC Instructions
from collections import namedtuple

TAC_Assign_Default = namedtuple("TAC_Assign_Default", "Var Type")
TAC_Assign = namedtuple("TAC_Assign", "Dest Src")
TAC_Assign_Call = namedtuple("TAC_Assign_Call", "Dest Method Arg")
TAC_Assign_New = namedtuple("TAC_Assign_New", "Dest Type")
TAC_Assign_IsVoid = namedtuple("TAC_Assign_IsVoid", "Dest Src")
TAC_Assign_Plus = namedtuple("TAC_Assign_Plus", "Dest Left Right")
TAC_Assign_Minus = namedtuple("TAC_Assign_Minus", "Dest Left Right")
TAC_Assign_Times = namedtuple("TAC_Assign_Times", "Dest Left Right")
TAC_Assign_Divide = namedtuple("TAC_Assign_Divide", "Dest Left Right")
TAC_Assign_LessThan = namedtuple("TAC_Assign_LessThan", "Dest Left Right")
TAC_Assign_LessThanEqual = namedtuple("TAC_Assign_LessThanEqual", "Dest Left Right")
TAC_Assign_Equal = namedtuple("TAC_Assign_Equal", "Dest Left Right")
TAC_Assign_Int = namedtuple("TAC_Assign_Int", "Dest Value")
TAC_Assign_Bool = namedtuple("TAC_Assign_Bool", "Dest Value")
TAC_Assign_String = namedtuple("TAC_Assign_String", "Dest Value")
TAC_Assign_Not = namedtuple("TAC_Assign_Not", "Dest Src")
TAC_Assign_Negate = namedtuple("TAC_Assign_Negate", "Dest Src")
TAC_Bt = namedtuple("TAC_Bt", "Cond Label")
TAC_Jmp = namedtuple("TAC_Jmp", "Label")

# represents a temporary to be used in TAC
TAC_Variable = namedtuple("TAC_Variable", "Name")

TAC_Label = namedtuple("TAC_Label", "Label")
TAC_Comment = namedtuple("TAC_Comment", "Comment")

TAC_Internal = namedtuple("TAC_Internal","Body")