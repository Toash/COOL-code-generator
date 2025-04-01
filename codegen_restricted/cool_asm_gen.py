from collections import namedtuple
from annotated_ast_reader import AnnotatedAstReader
from ast_nodes import *
import sys
from pprint import pprint

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


# where variables can live
Register = namedtuple("Register","reg")
Offset = namedtuple("Offset","reg offset")

"""
COOL ASM STACK MACHINE CONVENTION:
Note: in cool-asm, stack pointers to unused memory sp[1] is the top of the stack.
Stack should be the same before and after a method call.

Next address stored in ra
- pop when calling function
- after function ends (stack has to be the same), 

On function call, 
- push parameters on stack
- push receiver object. 

Note: return jumps to ra.
so after function ends (and stack is the same before call, pop ra then return.)
"""
class CoolAsmGen:
    def __init__(self,file):
        try:
            self.file = file
            self.asm_instructions = []

            # maps variable to member locations.
            # variable could live in register
            # or offset ( fp[4] )
            self.symbol_stack = [{}]
            # store index with <type, mname>
            # to lookup when emitting code for dispatch
            self.vtable_method_indexes = {}

            # keep track of current_class for self_dispatch.
            self.current_class = None

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



            # from pprint import pprint
            # print("CLASS MAP:")
            # pprint( self.class_map)
            # print("IMPLEMENTATION MAP:")
            # pprint( self.imp_map)
            # print("PARENT MAP:")
            # pprint( self.parent_map)
            # print("DIRECT METHODS:")
            # pprint(self.direct_methods)

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
            # self.vtable_method_indexes[(cls, constant_constructor)] = index
            self.vtable_method_indexes[(cls, "new")] = index
            index += 1
            # self.write(f"constant {cls}..new") # constructor

            # inherited methods
            for (class_name,method_name), imp in self.imp_map.items():

                exp = imp[-1][1] # skip over formals and line number
                # TODO: This is probably not handling inheritance for non internals.
                if type(exp).__name__ == "Internal":
                    if cls == class_name:
                        # body contaisn a string for the actual class and method called.
                        self.add_asm(ASM_Constant_label(label=f"{exp.Body}"))
                        # self.vtable_method_indexes[(class_name, exp.Body)] = index
                        self.vtable_method_indexes[(class_name, (exp.Body).split(".")[1] )] = index
                        index += 1
                else:
                    if cls == class_name:
                        self.add_asm(ASM_Constant_label(label=f"{class_name}.{method_name}"))
                        # self.vtable_method_indexes[(class_name, method_name)] = index
                        self.vtable_method_indexes[(class_name, method_name)] = index
                        index+=1


    def emit_constructors(self):
        self.comment("CONSTRUCTORS")
        self.comment("These will allocate memory (based on object layout gone over in class),")
        self.comment("and will return the object.")
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
            Object layout:
            tag                     (not currently used)
            object size variable    (not currently used)
            vtable pointer
            attributes
            ....
            """
            # set up frame pointer (will use to refer to variables later.)
            self.add_asm(ASM_Mov("fp","sp"))
            # save return address
            self.add_asm(ASM_Push("ra"))

            # adding 1 for v table ptr.
            size = len(attrs) + 1
            # load immediate to alloc object layout.
            # emit first real cool asswmbly istrucionts.
            self.comment(f"\t\t\t\tallocating {size} words of memory for object layout for class {cls}.")
            self.add_asm(ASM_Li(reg = self_reg, imm = size))
            self.add_asm(ASM_Alloc(dest = self_reg, src = self_reg))

            # store vtable pointer
            self.comment("\t\t\t\tVTable")
            vtable_index = 0

            self.comment(f"\t\t\t\tStore vtable pointer at index {vtable_index}")
            self.add_asm(ASM_La(temp_reg, f"{cls}..vtable"))

            # store address of vtable in this slot
            self.add_asm(ASM_St(self_reg, temp_reg, 0))

            # attributes - default initializer
            if attrs:
                self.comment("\t\t\t\tAttributes - default allocation")
            for attr_index,attr in enumerate(attrs, start=1):
                # FIXME: calling convention stuff
                self.comment("\t\t\t\tFIXME: calling convention stuff")

                # we are in Int Class.
                # we need to store the raw int value in an attribute.
                if attr.Type == "Unboxed_Int":
                    self.comment(f"\t\t\t\tStore raw int {0} for attribute in Int.")
                    self.add_asm(ASM_Li(acc_reg,0))
                else:
                    # call constructor for attribute type.
                    self.add_asm(ASM_La(temp_reg, f"{attr.Type}..new"))
                    self.add_asm(ASM_Call_Reg(temp_reg))

                # store attribute in allocated self object.
                self.add_asm(ASM_St(dest = self_reg,src = acc_reg,offset = attr_index))

            #initializers - explicit user defined.
            if attrs:
                self.comment("\t\t\t\tInitializers- overwriting attributes if defined.")
            for attr_index,attr in enumerate(attrs, start=1):
                if attr.Type == "Unboxed_Int":
                    continue # already initialized this to 0.

                exp = attr.Initializer[1]
                # generate code for the initializer and put it in r1 (accumulator)
                self.cgen(exp)
                # store the result of cgen in an attribute slot.
                self.comment(f"\t\t\t\t Initialized {attr}")
                self.add_asm(ASM_St(dest = self_reg,src = acc_reg,offset = attr_index))

            self.comment("\t\t\t\tFIXME: calling convention stuff")

            self.comment("\t\t\t\treturn the new object")
            self.add_asm(ASM_Mov(acc_reg,self_reg))

            self.comment("\t\t\t\tJump to address in ra.")

            # pop the return address.
            self.add_asm(ASM_Pop("ra"))
            # may need to adjust the stack pointer more.
            # add sp <- sp z?
            #   z is the "stack room for temporaries"
            self.add_asm(ASM_Return())


    def emit_methods(self):
        self.comment("METHODS")

        for (cname,mname), imp in self.direct_methods.items():
            self.current_class = cname
            num_args = len(imp)-1
            exp = imp[-1][1]
            self.add_asm(ASM_Label(f"{cname}.{mname}"))

            # set up base pointer address.
            self.add_asm(ASM_Mov("fp","sp"))

            # caller has pushed: arg1, arg2, arg3 receiver_object
            # receiver object is top of stack!!
            # so we want to set "self" <- receiver object
            self.comment("\t\t\t\tPresumably, caller has pushed arguments,then receiver object on stack.")
            self.comment("\t\t\t\tLoad receiver object into r0 (receiver object is on top of stack).")
            self.add_asm(ASM_Ld(self_reg,"sp",1))
            self.comment("\t\t\t\tPush return address (call instruction automatically stores it in ra.)")
            self.add_asm(ASM_Push("ra"))

            # when we call Point.setX(newX : Integer)
            # there are a few variables in scope
            # first, all of Point's fields (x,y,Color)
            #   -- live at offsets from receiver object
            # second, and overriding all of setX's formals
            #   -- live at offsets from the frame pointer

            self.push_scope()

            # step 1 - fields / attr in scope
            # print(f"Class map for {cname}:",self.class_map[cname])
            for index,attr in enumerate(self.class_map[cname],start=1):
                if index==1:
                    self.comment("\t\t\t\tSetting up addresses for attributes (based off offsets from self reg)")
                # self.symbol_stack[attr.Name] = Offset(self_reg, index)
                self.comment(f"\t\t\t\tSetting up attribute, it lives in {self_reg}[{z}]")
                self.insert_symbol(attr.Name , Offset(self_reg, index))

            # step 2 - formals in scope
            for index,arg in enumerate(imp[:-1],start=1):
                if index == 1:
                    self.comment("\t\t\t\tSetting up addresses for arguments (based off frame pointer reg)")
                # + 1 because of self object
                # get offset from frame pointer for arguments.
                z=num_args+1-index + 1
                # these formals live at at offset of the frame pointer.
                # self.symbol_stack[arg] = Offset("fp", z)
                print(f"{arg} lives in fp[{z}]")
                self.comment(f"\t\t\t\tSetting up argument {arg}, it lives in fp[{z}]")
                self.insert_symbol(arg, Offset("fp", z))

            # call method body.
            self.cgen(exp)

            # ra gets top of stack
            self.add_asm(ASM_Ld("ra","sp",1))
            # arg1 .. n
            # receiver_object
            # return address
            z=num_args+2
            self.add_asm(ASM_Li(temp_reg,z))

            # add sp <- sp z
            self.comment("\t\t\t\tdeallocating stack frame.")

            self.add_asm(ASM_Add("sp","sp",temp_reg))

            self.pop_scope()



            self.add_asm(ASM_Return())


        # the special start method.
        self.comment("\n\n-=-=-=-=-=-=-=-=-  PROGRAM STARTS HERE  -=-=-=-=-=-=-=-=-")
        self.add_asm(ASM_Label("start"))
        exp = Dynamic_Dispatch(Exp=New(Type="Main",StaticType="Main"), Method = ID(loc=0,str="main"), Args=[],StaticType="Main")

        # self.add_asm(ASM_Push("ra"))
        self.cgen(exp)
        self.add_asm(ASM_Ld("ra", "sp", 1))

        self.add_asm(ASM_Syscall("exit"))

    # generate code for e, put on accumulator register.
    # leave stack the way we found it (good behaviour)
    def cgen(self, exp):
        # we need to change this when adding tags and size in the object layout.
        attr_start_index = 1

        self.comment(f"\t\t\t\tcgen+: {type(exp).__name__}")

        locs = []
        for var, loc in self.symbol_stack[-1].items():
            match loc:
                case Register(reg):
                    locs.append(f"{var}={reg}")
                case Offset(reg,loc):
                    locs.append(f"{var}={reg}[{loc}]")

        self.comment(f"\t\t\tsymbol_table in current scope: {locs}")

        match exp:
            # look up in symbol table, if found, store in accumulator.
            case Identifier(Var):

                match self.lookup_symbol(Var):
                    case Register(reg):
                        # print(f"Found variable in register {reg}")
                        self.add_asm(ASM_Mov(dest = acc_reg, src = reg))
                    case Offset(reg,offset):
                        # print(f"Found variable in register {reg} at offset {offset}")
                        self.add_asm(ASM_Ld(dest=acc_reg,src=reg,offset=offset))
                    case _:
                        print(f"Could not find identifier {Var}")
                        self.add_asm(ASM_Mov(dest=acc_reg, src="NOT_FOUND" ))

            case Integer(Integer=val, StaticType=st):
                # make new int , (default initialized with 0)
                self.comment("\t\t\t\tWe are making an int, so we need an Int object.")
                self.cgen(New(Type="Int",StaticType="Int"))
                # access secrete fields :)
                # right now, this depends on the fact that the location of the raw int is the first attribute index.
                self.comment(f"\t\t\t\t put {val} in the first attribute for a Cool Int Object :)")
                self.add_asm(ASM_Li(temp_reg,val))
                self.add_asm(ASM_St(acc_reg,temp_reg,attr_start_index))

                # an integer object  with the value in the first attribute is not on the stack.

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
                # Code gen full-fledged cool integer objects.
                self.cgen(Left[1])
                self.add_asm(ASM_Push(acc_reg))
                self.cgen(Right[1])
                self.add_asm(ASM_Pop(temp_reg))

                # load unboxed integers (raw values).
                self.comment("\t\t\t\tLoad unboxed integers.")
                self.add_asm(ASM_Ld(
                    dest = acc_reg,
                    src = acc_reg,
                    offset = attr_start_index))
                self.add_asm(ASM_Ld(temp_reg,temp_reg,attr_start_index))

                # add the raw values.
                self.comment("\t\t\t\tAdd unboxed integers.")
                self.add_asm(ASM_Add(temp_reg,acc_reg,temp_reg))

                # save result
                self.comment("\t\t\t\tPush result of adding on the stack.")
                self.add_asm(ASM_Push(temp_reg))
                # now in acc.
                self.comment("\t\t\t\tCreate new Int Object.")
                self.cgen(New(Type="Int", StaticType="Int"))
                self.comment("\t\t\t\tPop previously saved addition result off of stack.")
                self.add_asm(ASM_Pop(temp_reg))

                # store unboxed int in the new int
                # stores value in src to dest[offset]
                self.comment("\t\t\t\tStore unboxed int int new Int Object.")
                self.add_asm(ASM_St(
                    dest = acc_reg,
                    src = temp_reg,
                    offset = attr_start_index))


            case New(Type):
                self.add_asm(ASM_Push("fp"))
                # going to put result in ra register.
                # constructor has no arguments and no self object.
                self.add_asm(ASM_Call_Label(f"{Type}..new"))
                self.add_asm(ASM_Pop("fp"))

            # Dispatch
            case Dynamic_Dispatch(Exp,Method,Args):
                self.gen_dispatch_helper(Exp=Exp, Method=Method, Args=Args)
            case Self_Dispatch(Method,Args):
                self.gen_dispatch_helper(Exp=None, Method=Method, Args=Args)
            case Internal(Body):

                if Body == "IO.out_int":
                    # in the case of out_int, x should be an integer.
                    self.cgen(Identifier(Var="x", StaticType=None))
                    # load unboxed int
                    self.add_asm(ASM_Ld(acc_reg, acc_reg, attr_start_index))
                    self.add_asm(ASM_Comment("out_int writes the raw integer in r1 to standard output."))
                    self.add_asm(ASM_Syscall(Body))
                else:
                    # print("Unhandled Internal: ",Body)
                    pass
            case _:
                # print("Unknown expression in cgen: ", exp)
                pass

        self.comment(f"\t\t\t\tcgen-: {type(exp).__name__}")


    def gen_dispatch_helper(self, Exp, Method, Args):
        vtable_index = 0
        self.add_asm(ASM_Push("fp"))
        # args has line numbers and we need to skip them.

        """
        Here how the stack frame look like:
        arg 1,
        arg 2,
        arg n....
        receiver object
        """
        self.comment("\t\t\t\tPush arguments on the stack.")
        for arg in Args:
            self.cgen(arg[1]) # skip line number
            self.add_asm(ASM_Push(acc_reg))

        self.comment("\t\t\t\tPush receiver on the stack.")
        if Exp:
            self.cgen(Exp)
            self.add_asm(ASM_Push(acc_reg))
        else:
            # object on which current method is invoked.
            self.add_asm(ASM_Push(self_reg))

        """
        1. load RO (acc) vtable into (temp)
        2. load the vtable index into (temp2)
        3. temp <- temp[temp2] -- get method pointer
        4. call temp
        """
        # receiver object in acc.
        # e.g: someone wants to invoke "out_int" or "main"
        # emit code to lookup in vtable.
        self.comment("\t\t\t\tLoading v table.")
        self.add_asm(ASM_Ld(dest=temp_reg, src=acc_reg, offset=vtable_index))

        class_name = Exp.Type if Exp else self.current_class
        method_name = Method.str
        # This should always access - unless we have a problem.
        method_vtable_index = self.vtable_method_indexes[(class_name, method_name)]
        # self.add_asm(ASM_Li(temp2_reg,method_vtable_index))
        self.comment(f"\t\t\t\t{class_name}.{method_name} lives at vindex {method_vtable_index}, loading the address.")
        self.add_asm(ASM_Ld(temp_reg, temp_reg, method_vtable_index))
        self.comment(f"\t\t\t\tIndirectly call the method.")
        self.add_asm(ASM_Call_Reg(temp_reg))

        # get back old frame pointer
        self.add_asm(ASM_Pop("fp"))

    def comment(self,comment):
        self.asm_instructions.append(ASM_Comment(comment=comment))

    # call when entering new expression
    def push_scope(self):
        self.symbol_stack.append({})
    def pop_scope(self):
        self.symbol_stack.pop()

    def insert_symbol(self, symbol, loc):
        self.symbol_stack[-1][symbol] = loc

    def lookup_symbol(self, symbol):
        for scope in reversed(self.symbol_stack):
            if symbol in scope:
                return scope[symbol]
        return None
        # print (f"Could not find symbol {symbol} in scope!")
        # sys.exit(1)

if __name__ == "__main__":
    coolAsmGen = CoolAsmGen(sys.argv[1])
