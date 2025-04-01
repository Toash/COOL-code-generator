from collections import namedtuple

CoolClass = namedtuple("CoolClass", "Name Inherits Features")
Attribute = namedtuple("Attribute", "Name Type Initializer") 
Method = namedtuple("Method", "Name Formals ReturnType Body")


ID = namedtuple("ID", "loc str") 
Formal = namedtuple("Formal", "Name Type")


# Kinds of Expressions
Assign = namedtuple("Assign", "Var Exp StaticType")

# dreaded dispatch
Dynamic_Dispatch = namedtuple("Dynamic_Dispatch", "Exp Method Args StaticType")
Static_Dispatch = namedtuple("Static_Dispatch", "Exp Type Method Args StaticType")
Self_Dispatch = namedtuple("Self_Dispatch", "Method Args StaticType")

If = namedtuple("If", "Predicate Then Else StaticType")
While = namedtuple("While", "Predicate Body StaticType") 

Block = namedtuple("Block", "Body StaticType")
New = namedtuple("New", "Type StaticType")
IsVoid = namedtuple("IsVoid", "Exp StaticType")

Plus = namedtuple("Plus", "Left Right StaticType") 
Minus = namedtuple("Minus", "Left Right StaticType")
Times = namedtuple("Times", "Left Right StaticType")
Divide = namedtuple("Divide", "Left Right StaticType")

Lt = namedtuple("Lt", "Left Right StaticType")
Le = namedtuple("Le", "Left Right StaticType")
Eq = namedtuple("Eq", "Left Right StaticType")

Not = namedtuple("Not", "Exp StaticType")
Negate = namedtuple("Negate", "Exp StaticType")

Integer = namedtuple("Integer", "Integer StaticType") 
String = namedtuple("String", "String StaticType")
Identifier = namedtuple("Identifier", "Var StaticType")
true = namedtuple("true", "Value StaticType")
false = namedtuple("false", "Value StaticType")

Let = namedtuple("Let", "Bindings Body StaticType")
Let_No_Init = namedtuple("Let_No_Init", "Var Type")
Let_Init = namedtuple("Let_Init", "Var Type Exp")
Case = namedtuple("Case", "Exp Elements StaticType")
Case_element = namedtuple("Case_element", "Var Type Body StaticType")

Internal = namedtuple("Internal", "Body StaticType")