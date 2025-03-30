from collections import namedtuple
from annotated_ast_reader import AnnotatedAstReader
from ast_nodes import *
import sys

self_reg = "r0"
acc_reg = "r1"  # result of expressions are always in accumulator
temp_reg = "r2"
temp1_reg = temp_reg
temp2_reg = "r3"

# https://kelloggm.github.io/martinjkellogg.com/teaching/cs485-sp25/crm/modern/Cool%20Assembly%20Language.html
ASM_Comment = namedtuple("ASM_Comment", "comment")
ASM_Label = namedtuple("ASM_Label", "label")

ASM_Li = namedtuple("ASM_Li", "reg imm") # li r1 <- 123
ASM_Mov = namedtuple("ASM_Mov", "dest src") # mov r1 <- r2

ASM_Add = namedtuple("ASM_Add", "dst left right")
ASM_Sub = namedtuple("ASM_Sub", "dst left right")
ASM_Mul = namedtuple("ASM_Mul", "dst left right")
ASM_Div = namedtuple("ASM_Div", "dst left right")

ASM_Jmp = namedtuple("ASM_Jmp", "label")
ASM_Bz = namedtuple("ASM_Bz", "reg label")
ASM_Bnz = namedtuple("ASM_Bnz", "reg label")
ASM_Beq = namedtuple("ASM_Beq", "left right label")
ASM_Blt = namedtuple("ASM_Blt", "left right label")
ASM_Ble = namedtuple("ASM_Ble", "left right label")

ASM_Call_Label = namedtuple("ASM_Call_Label", "label")
ASM_Call_Reg = namedtuple("ASM_Call_Reg", "reg")#jump to address stored in register
ASM_Return = namedtuple("ASM_Return", "") # go to address in ra register (we handle popping ourself)

ASM_Push = namedtuple("ASM_Push", "reg")
ASM_Pop = namedtuple("ASM_Pop", "reg")

# Memory instructions
ASM_Ld = namedtuple("ASM_Ld", "dest src offset") # dest <- src[offset]
ASM_St = namedtuple("ASM_St", "dest src offset") # dest[offset] <- src

ASM_La = namedtuple("ASM_La", "reg label") # load address in register

# alloc r1 r2 allocates memory by amount in r2 and stores pointer in r1.
ASM_Alloc = namedtuple("ASM_Alloc", "dest src")
ASM_Constant_integer = namedtuple("ASM_Constant_integer", "int")
ASM_Constant_raw_string = namedtuple("ASM_Constant_raw_string", "string")
ASM_Constant_label = namedtuple("ASM_Constant_label", "label")

ASM_Syscall = namedtuple("ASM_Syscall", "name")

Register = namedtuple("Register","reg")
Offset = namedtuple("Offset","reg offset")

"""
STACK MACHINE CONVENTION:
Cool-ASM has:
8 General registers
3 special ones
    stack pointer (sp)
    frame pointer (fp)
    return address

Address of next instruction is stored in ra
on x86, it will be stored on the stack by the call instruction.

On function call, push parameters on stack
caller set next instruction in ra. 

when in callee, set stack pointer to frame pointer
push ra (the next instruction from caller) onto stack.
"""
class CoolAsmGen:
    def __init__(self,file):
        try:
            self.file = file
            self.asm_instructions = []

            # variable could live in register
            # or offset ( fp[4] )
            self.symbol_table = {}

            # store index with <type, mname>
            # to lookup when emitting code for dispatch
            self.vtable_method_indexes = {}


            self.env = {}
            self.next_stack_offset = 1

            # asm_file = self.file.replace(".cl-type",".cl-asm")
            asm_file = "!MY_COOL_ASM.cl-asm"
            self.outfile = open(asm_file,"w")

            # tac_gen = TacGen.TacGen(file)
            parser = AnnotatedAstReader(file)
            self.class_map, self.imp_map, self.parent_map,self.direct_methods = parser.parse()


            # attributes
            self.class_map["Int"].append(Attribute("val","Unboxed_Int",("0",Integer("0","Int"))))

            #intiialize x for outint and stuff?
            # FIXME: This is probably wrong.
            self.symbol_table["x"] = Register("r4")

            from pprint import pprint
            print("CLASS MAP:")
            pprint( self.class_map)
            # print("IMPLEMENTATION MAP:")
            # pprint( self.imp_map)
            # print("PARENT MAP:")
            # pprint( self.parent_map)
            print("DIRECT METHODS:")
            pprint(self.direct_methods)

            self.emit_vtables()
            self.emit_constructors()
            self.emit_methods()


            # pprint(self.vtable_method_indexes)

            # Starting point?
            # self.comment("START")
            # for instr in self.tac_instructions:
            #     # print(instr)
            #     self.emit(instr)

            self.flush_asm()

        finally:
            self.outfile.close()

    def reset_env(self):
        self.env = {}
        self.next_stack_offset = 1

    def add_asm(self,instr):
        self.asm_instructions.append(instr)

    # write to file
    def flush_asm(self):
        for instr in self.asm_instructions:
            self.outfile.write(self.format_asm(instr) + "\n")

    def format_asm(self,instr):
        if type(instr).__name__ != "ASM_Label" and type(instr).__name__ != "ASM_Comment":
            self.outfile.write("\t\t\t\t")

        match instr:
            case ASM_Comment(comment):
                import re

                result = re.sub(r"^(\s*)", r"\1;;\t", comment)
                return result
                # return ";;" + comment
            case ASM_Label(label):
                return label + ":"
            case ASM_Li(reg, imm):
                return f"li {reg} <- {imm}"
            case ASM_Mov(dest, src):
                return f"mov {dest} <- {src}"
            case ASM_Add(dst, left, right):
                return f"add {dst} <- {left} {right}"

            case ASM_Call_Label(label):
                return f"call {label}"
            case ASM_Call_Reg(reg):
                return f"call {reg}"

            case ASM_Return():
                return "return"

            case ASM_Push(reg):
                return f"push {reg}"
            case ASM_Pop(reg):
                return f"pop {reg}"


            case ASM_Ld(dest,src,offset):
                return f"ld {dest} <- {src}[{offset}]"
            case ASM_St(dest,src,offset):
                return f"st {dest}[{offset}] <- {src}"

            case ASM_La(reg, label):
                return f"la {reg} <- {label}"
            case ASM_Alloc(dest,src):
                return f"alloc {dest} {src}"
            case ASM_Constant_label(label):
                return f"constant {label}"

            case ASM_Syscall(name):
                return f"syscall {name}"

            case _:
                print("Unhandled ASM instruction: ", instr)
                sys.exit(1)

    # Loop through classes in imp map for their methods
    def emit_vtables(self):
        self.comment("VIRTUAL TABLES")
        self.comment("constants will represent .quad in x86")
        self.comment("they will represent 8 byte delineations in memory.")
        self.comment("key insight for dynamic dispatch to work correctly: method ordering should be the same")
        for cls in self.class_map:
            index = 0
            # self.outfile.write( # label
            self.add_asm(ASM_Label(label = f"{cls}..vtable"))

            constant_constructor = f"{cls}..new"
            self.add_asm(ASM_Constant_label(label= constant_constructor))
            self.vtable_method_indexes[(cls, constant_constructor)] = index
            index += 1
            # self.write(f"constant {cls}..new") # constructor

            #inhertied methods
            for (class_name,method_name), imp in self.imp_map.items():

                exp = imp[-1][1] # skip over formals and line number
                # TODO: This is probably not handling inheritance for non internals.
                if type(exp).__name__ == "Internal":
                    if cls == class_name:
                        # body contaisn a string for the actual class and method called.
                        self.add_asm(ASM_Constant_label(label=f"{exp.Body}"))
                        self.vtable_method_indexes[(class_name, exp.Body)] = index
                        index += 1
                else:
                    if cls == class_name:
                        self.add_asm(ASM_Constant_label(label=f"{class_name}.{method_name}"))
                        self.vtable_method_indexes[(class_name, method_name)] = index
                        index+=1


    def emit_constructors(self):
        self.comment("CONSTRUCTORS")
        for cls,attrs in self.class_map.items():
            self.add_asm(ASM_Label(label=f"{cls}..new"))
            """
            1. allocate new space for new object
            2. set up the fields in the new object
                2a. set up the vtable pointer
                2b. set each field / attribute to hold a default value
                2c. execute all initializers (in this new context)
            3. return the new object
            """
            """
            size of an object:
            tag (not currently used)
            object size variables (used for clones?) 
            vtable pointer
            fields
            ....
            
            """


            # adding 1 for v table ptr.
            size = len(attrs) + 1
            # load immediate to alloc object layout.
            # emit first real cool asswmbly istrucionts.
            self.comment(f"\t\t\t\talloc {size} words of memory for object layout.")
            self.add_asm(ASM_Li(reg = self_reg, imm = size))
            self.add_asm(ASM_Alloc(dest = self_reg, src = self_reg))

            # store vtable pointer

            self.comment("\t\t\t\tVTable")
            self.add_asm(ASM_La(temp_reg, f"{cls}..vtable"))
            self.add_asm(ASM_St(self_reg, temp_reg, 0))

            # attributes
            if attrs:
                self.comment("\t\t\t\tAttributes")
            for i,attr in enumerate(attrs, start=1):
                # FIXME: calling convention stuff
                self.comment("\t\t\t\tFIXME: calling convention stuff")

                # we are in Int Class.
                if attr.Type == "Unboxed_Int":
                    self.comment(f"\t\t\t\tStore int {0} in object layout for Int.")
                    self.add_asm(ASM_Li(acc_reg,0))
                else:
                    # call constrsuctor for attribute type.
                    self.add_asm(ASM_La(temp_reg, f"{attr.Type}..new"))
                    self.add_asm(ASM_Call_Reg(temp_reg))

                self.add_asm(ASM_St(dest = self_reg,src = acc_reg,offset = i))

            #initializers
            if attrs:
                self.comment("\t\t\t\tInitializers")
            for i,attr in enumerate(attrs, start=1):
                if attr.Type == "Unboxed_Int":
                    continue
                exp = attr.Initializer[1]
                # self.comment(f"\t\t\t\tdo cgen (TAC?) here for {exp}" )
                self.cgen(exp)
                # store the result of cgen in an attribute slot.
                self.add_asm(ASM_St(self_reg,acc_reg,i))
                # print(attr.Initializer)

            self.comment("\t\t\t\tFIXME: calling convention stuff")

            self.comment("\t\t\t\treturn the new object")
            self.add_asm(ASM_Mov(acc_reg,self_reg))
            self.add_asm(ASM_Return())


    def emit_methods(self):
        self.comment("METHODS")

        for (cname,mname), imp in self.direct_methods.items():
            exp = imp[-1][1]
            self.add_asm(ASM_Label(f"{cname}.{mname}"))
            self.comment("\t\t\t\tFIXME: calling convention stuff")
            self.cgen(exp)
            self.comment("\t\t\t\tFIXME: calling convention stuff")
            self.add_asm(ASM_Return())


        self.comment("\n\n-=-=-=-=-=-=-=-=-  PROGRAM STARTS HERE  -=-=-=-=-=-=-=-=-")
        self.add_asm(ASM_Label("start"))
        self.comment("\t\t\t\tFIXME: calling convention stuff")
        exp = Dynamic_Dispatch(Exp=New(Type="Main",StaticType="Main"), Method = ID(loc=0,str="main"), Args=[],StaticType="Main")
        self.cgen(exp)
        self.comment("\t\t\t\tFIXME: calling convention stuff")
        self.add_asm(ASM_Return())

    # convert TAC to ASM
    # generate code for e, put on accumulator register.
    # leave stack the way we found it (good behaviour)
    # how exactly do we take advantage of TAC?
    def cgen(self, exp):
        # we need to change this when adding tags and size in the object layout.
        vtable_index = 0
        attr_start_index = 1

        # print(type(instr).__name__)
        self.comment(f"\t\t\t\tdoing cgen for {exp}")
        match exp:
            # when we encounter an ordinary variable in TAC.
            case Identifier(Var):

                match self.symbol_table[Var]:
                    case Register(reg):
                        # print(f"Found variable in register {reg}")
                        self.add_asm(ASM_Mov(dest = acc_reg, src = reg))
                    case Offset(reg,offset):
                        # print(f"Found variable in register {reg} at offset {offset}")
                        self.add_asm(ASM_Ld(dest=acc_reg,src=reg,offset=offset))

            case Integer(Integer=val, StaticType=st):
                print("codegen: ", exp)
                # ?
                # make new int , fill with actual value.
                self.cgen(New(Type="Int",StaticType="Int"))
                # access secrete fields :)
                self.comment("\t\t\t\t we just generated a new int, now we putting the actual value in attribute. :)")
                self.add_asm(ASM_St(acc_reg,val,attr_start_index))

            case Plus(Left,Right):
                """
                cgen left
                push acc
                cgen right; now in acc
                pop temp

                UNBOXED VALUES
                acc <- ld acc[1]
                temp <- ld temp[1]
                add temp <- temp acc

                push temp
                new Int
                pop temp
                
                UNBOXED
                store acc[1] <- temp
                """
                # result in accumulator
                self.cgen(Left)
                # push result onto stack
                self.add_asm(ASM_Push(acc_reg))
                self.cgen(Right)
                # result in acc, get the left expression from stack.
                self.add_asm(ASM_Pop(temp_reg))

                # load unboxed integers (raw values).
                # loads value in src[offset] into dest.
                self.add_asm(ASM_Ld(
                    dest = acc_reg,
                    src = acc_reg,
                    offset = attr_start_index))
                self.add_asm(ASM_Ld(temp_reg,temp_reg,attr_start_index))

                self.add_asm(ASM_Add(temp_reg,acc_reg,temp_reg))

                #save result
                self.add_asm(ASM_Push(temp_reg))
                # now in acc.
                self.cgen(New(Type="Int", StaticType="Int"))
                self.add_asm(ASM_Pop(temp_reg))
                # store unboxed int in the new int
                # stores value in src to dest[offset]
                self.add_asm(ASM_St(
                    dest = acc_reg,
                    src = temp_reg,
                    offset = attr_start_index))
            case New(Type):
                self.comment("\t\t\t\tFIXME: calling convention stuff")
                # going to put result in ra register.
                self.add_asm(ASM_Call_Label(f"{Type}..new"))

            # Dispatch
            case Dynamic_Dispatch(Exp,Method,Args):
                for arg in Args:
                    self.cgen(arg)

                    self.comment("\t\t\t\tFIXME: calling convention stuff")
                    self.add_asm(ASM_Push(acc_reg))
                #receiver object (new?)
                self.cgen(Exp)
                self.add_asm(ASM_Push(acc_reg))

                """
                1. load RO (acc) vtable into (temp)
                2. load the vtable index into (temp2)
                3. temp <- temp[temp2] -- get method pointer
                4. call temp
                """
                # receiever object in acc.
                # e.g: someone wants to invoke "out_int" or "main"
                # emit code to lookup in vtable.
                self.add_asm(ASM_Ld(dest=temp_reg,src=acc_reg,offset=vtable_index))

                class_name = Exp.Type
                method_name = Method.str
                method_vtable_index = self.vtable_method_indexes[(class_name,method_name)]
                # self.add_asm(ASM_Li(temp2_reg,method_vtable_index))
                self.add_asm(ASM_Ld(temp_reg,temp_reg,method_vtable_index))
                self.add_asm(ASM_Call_Reg(temp_reg))
                self.comment("\t\t\t\tFIXME: calling convention stuff")

            case Internal(Body):
                self.cgen(Identifier(Var="x",StaticType="idk"))
                # load unboxed int
                self.add_asm(ASM_Ld(acc_reg,acc_reg,attr_start_index))
                self.add_asm(ASM_Syscall("IO.out_int"))
                # FIXME

                pass
            case _:
                # print("Unknown expression in cgen: ", exp)
                pass


    def comment(self,comment):
        self.asm_instructions.append(ASM_Comment(comment=comment))

if __name__ == "__main__":
    coolAsmGen = CoolAsmGen(sys.argv[1])
