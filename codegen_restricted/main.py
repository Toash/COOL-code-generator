import sys
import copy # deep copy when we extend environments.
from collections import namedtuple
from parser import Parser
from ast_nodes import *

# stack instructions
Instruction = namedtuple("Instruction", "opcode args")

instructions = []

# * is the splat operator
# we want to take the elements in args and construct a list for the args
def emit(opcode, *args):
    instructions.append(Instruction(opcode,list(args)))

def emit_label(label):
    instructions.append(f"{label}")


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


    #TODO: need to print constructors of internal methods

    fname = sys.argv[1] 
    parser = Parser(fname)
    class_map,imp_map,parent_map = parser.parse()

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
    with open("output.cl-tac", "w") as file:
        for inst in instructions:
            if(isinstance(inst,str)):
                file.write(inst)
                file.write("\n")
            else:
                file.write("\t")
                file.write(f"{inst.opcode} {' '.join(inst.args)}")
                file.write("\n")

main()

