import sys
import copy # deep copy when we extend environments.
from collections import namedtuple

# named tuple has the type specified by the first argument
# second argument contaisn the fields, that can be delineated by whitespace and in a single string
#   these fields can be accessed using dot operator
#   can also refer to the fields by position when initializing a namedtuple.
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

# PA3
Internal = namedtuple("Internal", "Body StaticType")


# stack instructions
Instruction = namedtuple("Instruction", "opcode args")

instructions = []

# * is the splat operator
# we want to take the elements in args and construct a list for the args
def emit(opcode, *args):
    instructions.append(Instruction(opcode,list(args)))

def emit_label(label):
    instructions.append(f"{label}")

lines = [] 
act_recs = 0 # keep track of activation records

# environment - map variables to locations
# TODO: store offsets from rbp
class Environment:
    def __init__(self):
        self.env = {}
        self.next_loc = 0

    def update(self, id, loc):
        self.env[id] = loc
    
    def extend(self):
        return copy.deepcopy(self)

    def lookup(self, id):
        if id in self.env: 
            return self.env[id]
        else:
            print(f"Variable {id} not in environment")
            exit(1)

    def __str__(self) -> str:
        return str(self.env)


def main(): 
    sys.setrecursionlimit(20000)
    global lines
    fname = sys.argv[1] 
    with open(fname) as file:
        lines = [line.rstrip("\r\n") for line in file] 

    def read(): 
        global lines
        this_line = lines[0] 
        lines = lines[1:]
        return this_line 

    def read_list(worker):
        k = int(read()) 
        return [ worker () for _ in range(k) ] 

    def read_id():
        loc = read () 
        name = read ()
        return ID(loc, name) 

    def read_bindings ():
        ekind = read_ekind(1)
        return ekind

    def read_case_elements():
        var = read_id()
        type = read_id()
        body = read_exp()
        return Case_element(var, type, body, None)

    def read_exp ():
        eloc = read () 
        ekind = read_ekind(0)
        return (eloc, ekind)

    # optionally read in a static type
    def read_ekind (binding):
        if not binding: 
            static_type = read ()
        ekind = read () 
        if ekind == "integer":
            val = read ()
            return Integer(val, static_type)
        elif ekind == "identifier":
            id = read_id()
            return Identifier(id, static_type)
        elif ekind == "string":
            val = read ()
            return String(val, static_type)
        elif ekind == "plus": 
            left = read_exp ()
            right = read_exp ()
            return Plus(left, right, static_type) 
        elif ekind == "minus": 
            left = read_exp ()
            right = read_exp ()
            return Minus(left, right, static_type) 
        elif ekind == "times": 
            left = read_exp ()
            right = read_exp ()
            return Times(left, right, static_type) 
        elif ekind == "divide": 
            left = read_exp ()
            right = read_exp ()
            return Divide(left, right, static_type) 
        elif ekind == "lt": 
            left = read_exp ()
            right = read_exp ()
            return Lt(left, right, static_type) 
        elif ekind == "le": 
            left = read_exp ()
            right = read_exp ()
            return Le(left, right, static_type) 
        elif ekind == "eq": 
            left = read_exp ()
            right = read_exp ()
            return Eq(left, right, static_type) 
        elif ekind == "not": 
            exp = read_exp ()
            return Not(exp, static_type)
        elif ekind == "negate": 
            exp = read_exp ()
            return Negate(exp, static_type)
        elif ekind == "isvoid": 
            exp = read_exp ()
            return IsVoid(exp, static_type)
        elif ekind == "new": 
            type = read_id ()
            return New(type, static_type)
        elif ekind == "true": 
            return true(True, static_type)
        elif ekind == "false": 
            return false(False, static_type)
        elif ekind == "block":
            body = read_list(read_exp)
            return Block(body, static_type)
        elif ekind == "while":
            predicate = read_exp ()
            body = read_exp ()
            return While(predicate, body, static_type) 
        elif ekind == "if":
            predicate = read_exp ()
            then_branch = read_exp ()
            else_branch = read_exp ()
            return If(predicate, then_branch, else_branch, static_type)
        elif ekind == "dynamic_dispatch":
            exp = read_exp()
            method = read_id()
            args = read_list(read_exp)
            return Dynamic_Dispatch(exp, method, args, static_type)
        elif ekind == "static_dispatch":
            exp = read_exp()
            type = read_id()
            method = read_id()
            args = read_list(read_exp)
            return Static_Dispatch(exp, type, method, args, static_type)
        elif ekind == "self_dispatch":
            method = read_id()
            args = read_list(read_exp)
            return Self_Dispatch(method, args, static_type)
        elif ekind == "assign":
            var = read_id()
            exp = read_exp()
            return Assign(var, exp, static_type)
        elif ekind == "let":
            bindings = read_list(read_bindings)
            body = read_exp()
            return Let(bindings, body, static_type)
        elif ekind == "let_binding_no_init":
            var = read_id()
            type = read_id()
            return Let_No_Init(var, type)
        elif ekind == "let_binding_init":
            var = read_id()
            type = read_id()
            exp = read_exp()
            return Let_Init(var, type, exp)
        elif ekind == "case":
            exp = read_exp()
            elements = read_list(read_case_elements)
            return Case(exp, elements, static_type)
        elif ekind == 'internal':
            body = read()
            return Internal(body, static_type)
        else: 
            raise (Exception(f"read_ekind: {ekind} unhandled"))

    # Read in the class map and store it in class_map dictionary
    def read_class_map():
        read ()
        num_classes = read ()
        for i in range(int(num_classes)):
            read_class_map_class()

    def read_class_map_class():
        class_name = read ()
        class_map[class_name] = []
        num_attrs = read()
        for i in range(int(num_attrs)):
            read_class_map_attr(class_name)

    def read_class_map_attr(class_name):
        init = read()
        attr_name = read()
        type_name = read()
        if init == "initializer": 
            init_exp = read_exp()
        else: 
            init_exp = None
        class_map[class_name].append(Attribute(attr_name, type_name, init_exp))

    # Read in the implementation map and store it in imp_map dictionary
    def read_imp_map():
        read() #ask weim about these
        num_classes = read()
        for i in range (int(num_classes)):
            read_imp_map_class()

    def read_imp_map_class():
        class_name = read()
        num_methods = read()
        for i in range (int(num_methods)):
            read_imp_map_method(class_name)

    def read_imp_map_method(class_name):
        method_name = read()
        num_formals = read()
        imp_map[(class_name, method_name)] = []
        for i in range(int(num_formals)):
            imp_map[(class_name, method_name)].append(read())
        read()
        body = read_exp()
        imp_map[(class_name, method_name)].append(body)

    # Read in the parent map and store it in parent_map dictionary
    def read_parent_map():
        read()
        num_relations = read()
        for i in range(int(num_relations)):
            child = read()
            parent = read()
            parent_map[child] = parent

    # Assign default values to Cool values 
    def get_default_val(c):
        match c:
            case "Int": val = Cool_Int("Int", 0)
            case "String": val = Cool_String("String", 0, "")
            case "Bool": val = Cool_Bool("Bool", False)
            case default: val = None
        return val
    
    def map_attrs(attributes):
        new_e = Environment()
        for attr_name in attributes:
            new_e.update(attr_name, attributes[attr_name])
        return new_e
    
    def closest_ancestor(x, case_elems):
        while (x != "Object"):
            for elem in case_elems:
                if x == elem.Type.str: return elem
            x = parent_map[x]
        for elem in case_elems:
            if elem.Type.str == "Object": return elem
        return None
            
    # emit stack instructions
    """
    IMPORTANT REGISTERS:
    %rbp - base pointer
    %r12 - ?
    """
    def cgen(expr):
        # comparing against the namedtuples we defined earlier.
        if isinstance(expr, Integer):
            emit(";; new Int")

            emit("pushq", "%rbp") # save base pointer
            emit("pushq", "r12") # what is r12 for?

            # $Int..new is the location for the int constuctor
            emit("movq","$Int..new","%r14") 
            # jump to location
            emit("call", "*%r14")

            emit("popq","%r12")
            emit("popq","%rbp")
            #?
            emit("movq","$1,%r14")
            emit("movq","%r14,24(%r13)")



        # elif isinstance(expr, Dynamic_Dispatch):
        #     cgen(expr.Args[0][1]) # receiver
        #     emit("push", "r1")
        #     emit("push", "r0") # push self

        #     emit("ld", "r2", "r0[2]") # load vtable

        #     #hardcode offset of out_int (7 for IO)
        #     emit("ld","r2","r2[7]")
        #     emit("call","r2")

        #TODO: handle operational semantics for self dispatch
        # for this checkpoint, we only need to consider it for in_out
        
        else:
            emit(f"TODO: Unhandled expression type: {type(expr).__name__}")

    # explicitly defined classes and their attributes
    class_map = {}
    # Defines classes and their methods
    # takes into account overriding
    imp_map = {}
    # inheritance hierarchy
    # parent child relationship
    parent_map = {} 

    # parse / deserialize the .cl-type file from the semantic analyzer, populate these
    read_class_map()
    read_imp_map()
    read_parent_map()

    # need to print constructors of internal methods


    # from pprint import pprint
    # print(class_map)
    # pprint(imp_map)
    # print(parent_map)
    cls= "Main"
    method="main"
    formals = imp_map[(cls,method)][:-1]
    body = imp_map[(cls,method)][-1]

    # TODO: generalizei methods
    emit_label("Main.main")
    emit(";; method definition")
    emit("pushq","%rbp") # save old base pointer
    emit("movq","%rsp","%rbp") # new stack frame for main
    emit("movq","16(%rbp)","%r12") # ?


    emit(";; stack room for temporaries: 1")
    emit("movq","$8","%r14") # move offset into register? why?
    emit("subq","%r14","%rsp") # allocate stack frame

    # # CALL TO EXPRESSION GENERATOR
    cgen(body[1])  # body is (loc, ekind), so use ekind

    # TODO: generalize ending of methods
    emit_label("Main.main.end")
    # why are these needed?
    emit("movq","%rbp","%rsp") 
    emit("popq","%rbp") 
    emit("ret")

    # start generating stack instructions 
    print("hello!")
    with open("output.s","w") as file:
        for inst in instructions:
            if(isinstance(inst,str)):
                file.write(inst)
                file.write("\n")
            else:
                file.write("\t")
                file.write(f"{inst.opcode} {' '.join(inst.args)}")
                file.write("\n")

main()

