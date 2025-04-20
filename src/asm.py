import sys
from collections import namedtuple
from annotated_ast_reader import AnnotatedAstReader
from ast_nodes import *
from asm_instructions import *
from asm_registers import *
from asm_constants import *
from asm_comparisons import *
from asm_strings import * 
from asm_symbol_stack import *
from asm_locations import *
from asm_method_index import *
from asm_string_to_label import *
from asm_tags import *
from pprint import pprint

class CoolAsmGen:
    def __init__(self, file, x86=False):
        parser = AnnotatedAstReader(file)
        self.class_map, self.imp_map, self.parent_map = parser.parse()

        self.x86=x86
        self.asm_instructions = [] # cool assembly emitted here.

        self.symbol_stack = SymbolStack()
        self.method_index = MethodIndex()
        self.string_to_label = StringToLabel(self.class_map)
        self.class_to_tag = Tags()

        internal_classes = ["Bool","Int","String","IO","Main","Object"]
        for cls in self.class_map:
            if cls not in internal_classes:
                self.class_to_tag.insert(cls)

        self.temporaries_needed= 0
        self.temporary_index = 0

        self.current_class = None

        self.branch_counter = 0 # unique labels

        # Used to generate dispatch on void labels
        self.dispatch_lines = []

        # expression and line number for case statement
        self.case_lines_and_exps=[]
        # used to keep track of the lines that we emitted case statements for
        #  TODO: delete this when i only emit  the necessary methods
        self.traversed_case_lines=[]
        self.div_zero_lines=[]

        # Internal attributes
        # we done specify initializer as we handle them ourselves.
        self.class_map["Int"].append(Attribute(Name="val",Type="Unboxed_Int", Initializer=None))
        # bool also holds a raw int like the Int object.
        self.class_map["Bool"].append(Attribute(Name="val",Type="Unboxed_Int", Initializer=None))
        self.class_map["String"].append(Attribute(Name="val",Type="Unboxed_String", Initializer=None))

        self.emit_vtables()
        self.emit_constructors()
        self.emit_methods()

        
        for line in set(self.dispatch_lines):
            emit_dispatch_on_void(self.asm_instructions,line)
        for line,exp in set(self.case_lines_and_exps):
            emit_case_on_void(self.asm_instructions,line)
            emit_case_without_branch(self.asm_instructions,line,exp)
        for line in set(self.div_zero_lines):
            emit_divide_by_zero(self.asm_instructions,line)

        emit_string_constants(self.asm_instructions,x86,self.string_to_label.get_dict_sorted())
        if not self.x86:

            emit_comparison_handler("eq", self.asm_instructions,x86)
            emit_comparison_false("eq", self.asm_instructions,x86)
            emit_comparison_true("eq", self.asm_instructions,x86)
            emit_comparison_bool("eq", self.asm_instructions,x86)
            emit_comparison_int("eq", self.asm_instructions,x86)
            emit_comparison_string("eq", self.asm_instructions,x86)
            emit_comparison_end("eq", self.asm_instructions,x86)

            emit_comparison_handler("le", self.asm_instructions,x86)
            emit_comparison_false("le", self.asm_instructions,x86)
            emit_comparison_true("le", self.asm_instructions,x86)
            emit_comparison_bool("le", self.asm_instructions,x86)
            emit_comparison_int("le", self.asm_instructions,x86)
            emit_comparison_string("le", self.asm_instructions,x86)
            emit_comparison_end("le", self.asm_instructions,x86)

            emit_comparison_handler("lt", self.asm_instructions,x86)
            emit_comparison_false("lt", self.asm_instructions,x86)
            emit_comparison_true("lt", self.asm_instructions,x86)
            emit_comparison_bool("lt", self.asm_instructions,x86)
            emit_comparison_int("lt", self.asm_instructions,x86)
            emit_comparison_string("lt", self.asm_instructions,x86)
            emit_comparison_end("lt", self.asm_instructions,x86)
        
            self.emit_start()


    def emit_vtables(self) -> None:
        for cls in self.class_map:
            self.append_asm(ASM_Label(label = f"{cls}..vtable"))

            self.string_to_label.insert(cls)
            self.append_asm(ASM_Constant_label(label= self.string_to_label.get(cls)))

            constant_constructor = f"{cls}..new"
            self.append_asm(ASM_Constant_label(label= constant_constructor))
            self.method_index.insert(cls,"new")

            # inherited methods
            for (class_name,method_name), imp in self.imp_map.items():

                exp = imp[-1][1] # skip over formals and line number
                if type(exp).__name__ == "Internal":
                    if cls == class_name:
                        # body contaisn a string for the actual class and method called.
                        self.append_asm(ASM_Constant_label(label=f"{exp.Body}"))
                        self.method_index.insert(class_name,(exp.Body).split(".")[1])
                else:
                    if cls == class_name:

                        self.append_asm(ASM_Constant_label(label=f"{class_name}.{method_name}"))
                        # self.vtable_method_indexes[(class_name, method_name)] = index
                        self.method_index.insert(class_name,method_name)
            
            self.method_index.reset_index()

    def emit_constructors(self) -> None:
        self.comment("resulting object will be in accumulator.",not_tabbed=True)
        for cls,attrs in self.class_map.items():
            self.current_class = cls 
            self.symbol_stack.push_scope()


            self.append_asm(ASM_Label(label=f"{cls}..new"))
            if self.x86:
                self.append_asm(ASM_Push("fp")) # we will set stack pointer to this later
            self.append_asm(ASM_Mov("fp","sp"))

            if not self.x86:
                self.append_asm(ASM_Push("ra"))


            # FIXME: is this actually needed?
            if self.x86:
                self.comment("stack offset for 16 byte alignment")
                self.append_asm(ASM_Li(temp_reg,ASM_Word(1)))
                self.append_asm(ASM_Sub(temp_reg,"sp"))

            # adding 1 for type tag.
            # adding 1 for size.
            # adding 1 for v table ptr.
            # indexes are in asm_constants.py
            size = len(attrs) + 3

            self.append_asm(ASM_Li(reg = self_reg, imm = ASM_Value(size)))
            self.append_asm(ASM_Alloc(dest = self_reg, src = self_reg))

            match(cls):
                case "Bool":
                    tag=Bool_tag
                case "Int":
                    tag=Int_tag
                case "String":
                    tag=String_tag
                case "IO":
                    tag=IO_tag
                case "Main":
                    tag=Main_tag
                case "Object":
                    tag=Object_tag
                case _:
                    # non built in class
                    tag = self.class_to_tag.get(cls)

            self.comment(f"Store type tag ({tag} for {cls}) at index {type_tag_index}")
            self.append_asm(ASM_Li(temp_reg,ASM_Value(tag)))
            self.append_asm(ASM_St(self_reg, temp_reg, type_tag_index))

            self.comment(f"Store object size at index {object_size_index}")
            self.append_asm(ASM_Li(temp_reg,ASM_Value(3 + len(attrs))))
            self.append_asm(ASM_St(self_reg, temp_reg, object_size_index))

            self.comment(f"Store vtable pointer at index {vtable_index}")
            self.append_asm(ASM_La(temp_reg, f"{cls}..vtable"))
            self.append_asm(ASM_St(self_reg, temp_reg, vtable_index))


            # Attributes
            for actual_attr_index,attr in enumerate(attrs, start=attributes_start_index):
                # print(f"({actual_attr_index}) {cls}: {attr}")
                if attr.Type == "Unboxed_Int":
                    self.comment(f"Store raw int {0} for attribute in {cls}.")
                    self.append_asm(ASM_Li(acc_reg,ASM_Value(0)))
                elif attr.Type == "Unboxed_String":
                    self.comment(f"Store raw string for attribute in String.")
                    self.append_asm(ASM_La(acc_reg,"the.empty.string"))
                else:
                    if attr.Type == "Int" or attr.Type == "String" or attr.Type == "Bool":
                        self.cgen(New(Type=attr.Type, StaticType=attr.Type))
                    else:
                        # "void"
                        self.append_asm(ASM_Li(acc_reg,ASM_Value(0)))

                self.append_asm(ASM_St(dest = self_reg,src = acc_reg,offset = actual_attr_index))
                self.symbol_stack.insert_symbol(attr.Name,Offset(self_reg,actual_attr_index))

            # initialize attributes
            for actual_attr_index,attr in enumerate(attrs, start=attributes_start_index):
                if attr.Initializer:   

                    exp = attr.Initializer[1]
                    self.cgen(exp)
                    self.append_asm(ASM_St(dest = self_reg,src = acc_reg,offset = actual_attr_index))
                    self.symbol_stack.insert_symbol(attr.Name,Offset(self_reg,actual_attr_index))

                # Attribute in acc

            self.append_asm(ASM_Mov(acc_reg,self_reg))


            if self.x86:
                self.append_asm(ASM_Mov("sp","fp"))
                self.append_asm(ASM_Pop("fp"))
            if not self.x86:
                self.append_asm(ASM_Pop("ra"))
            self.append_asm(ASM_Return())
            
            self.symbol_stack.pop_scope()


    def emit_methods(self)->None:

        # for (cname,mname), imp in self.direct_methods.items():
        for (cname,mname), imp in self.imp_map.items():
            self.current_class = cname
            num_args = len(imp)-1
            exp = imp[-1][1]
            self.append_asm(ASM_Label(f"{cname}.{mname}"))

            self.emit_function_prologue(exp)


            # add fields and attributes in scope to symbol table.

            # step 1 - fields / attr in scope
            for index,attr in enumerate(self.class_map[cname],start=attributes_start_index):
                self.comment(f"SYMBOL TABLE: setup attr {attr.Name}, lives in {self_reg}[{index}]")
                self.symbol_stack.insert_symbol(attr.Name , Offset(self_reg, index))

            # step 2 - formals in scope
            for index,arg in enumerate(imp[:-1],start=1):
                if self.x86:
                    # + 1 because of return address
                    # + 1 because of self object
                    # + 1 to get the actual index
                    # leftmost arguments are closer to the frame pointer.
                    # the self object is right next to the frame pointer.
                    fp_offset=num_args-index + 1 + 1 + 1
                else:

                    # +1 because of self object
                    # + 1 to get the actual index
                    fp_offset=num_args-index + 1 + 1

                self.comment(f"SYMBOL TABLE: setup formal {arg}, it lives in fp[{fp_offset}]")
                self.symbol_stack.insert_symbol(arg, Offset("fp", fp_offset))


            self.cgen(exp)

            # args  (this only matters for cool)
            stack_cleanup_size=num_args
            self.emit_function_epilogue(stack_cleanup_size)

    def emit_function_prologue(self,exp) -> None:
        self.symbol_stack.push_scope()
        # the cool way
        if not self.x86:
            self.append_asm(ASM_Mov("fp","sp"))
            self.append_asm(ASM_Pop(self_reg))

            # --=-=-=-=-=-=- temporaries -==-==-=-=-=--=-=-
            # we use positive indicies to refer to variables pushed by the caller
            #   (functoin args, self object)

            # we use negative indices to refer to temporaries in the current procedures.
            #   ( let bindings , etc.)
            self.temporaries_needed= self.compute_max_stack_depth(exp)
            self.append_asm(ASM_Comment(f"Stack room for {self.temporaries_needed} temporaries"))
            # we need to do +1 beacuse we popped r0, the reference compiler is confusing... 
            self.append_asm(ASM_Comment(f"+1 because we popped r0"))
            self.append_asm(ASM_Li(temp_reg,ASM_Word(self.temporaries_needed+1)))
            self.append_asm(ASM_Sub(temp_reg,"sp"))

            self.append_asm(ASM_Push("ra"))

        else:
            # the x86 way
            self.append_asm(ASM_Push("fp"))
            self.append_asm(ASM_Mov(dest="fp",src="sp"))
            # +1 for pushed rbp
            # +1 for return address ( exclusive to x86 :) )
            # +1 for the actual self object that we are getting
            self.append_asm(ASM_Ld(self_reg,"sp",2))

            self.temporaries_needed= self.compute_max_stack_depth(exp)
            self.comment(f"need {self.temporaries_needed} temporaries")
            self.append_asm(ASM_Li(temp_reg,ASM_Word(self.temporaries_needed)))
            self.append_asm(ASM_Sub(temp_reg,"sp"))


    def emit_function_epilogue(self,num_args) -> None:
        if not self.x86:
            # stack layout-
            #   arg1 .. n
            self.append_asm(ASM_Pop("ra"))
            self.append_asm(ASM_Li(temp_reg,ASM_Word(num_args+self.temporaries_needed+1)))
            self.append_asm(ASM_Add(temp_reg,"sp"))
            self.append_asm(ASM_Return())
        else:
            # stack layout-
            #   arg1 .. n
            #   self object
            #   return address
            self.append_asm(ASM_Mov(dest="sp", src="fp"))
            self.append_asm(ASM_Pop("fp"))
            self.append_asm(ASM_Return())

        self.symbol_stack.pop_scope()
        self.temporary_index = 0


    def emit_start(self)->None:
        self.comment("\n\n-=-=-=-=-=-=-=-=-  PROGRAM STARTS HERE  -=-=-=-=-=-=-=-=-",not_tabbed=True)
        self.append_asm(ASM_Label("start"))
        self.append_asm(ASM_Call_Label("Main..new"))
        self.append_asm(ASM_Comment("Push receiver (in accumulator, from Main..new) on stack."))
        self.append_asm(ASM_Push(acc_reg))
        self.append_asm(ASM_Call_Label("Main.main"))
        self.append_asm(ASM_Syscall("exit"))

    """
    generate code for e, put on accumulator register.
    (append instuctions to our asm list)
    leave stack the way we found it
    """
    def cgen(self, exp)->None:
        self.comment(f"cgen+: {exp}")

        match exp:

            case Assign(Var,Exp):
                var = Var[1]
                self.cgen(Exp[1])
                location = self.symbol_stack.lookup_symbol(Var[1])
                if location is None:
                    print(f"{var} could not be found in the  symbol stack!")
                    # raise Exception(f"{var} could not be found in the  symbol stack!")

                match location: 
                    case Offset(reg,offset):
                        self.comment(f"SYMBOL TABLE: update {var} in register {reg}")
                        self.append_asm(ASM_St(reg,acc_reg,offset))
                    case Register(reg):
                        self.comment(f"SYMBOL TABLE: update {var} in register {reg}")
                        self.append_asm(ASM_Mov(reg,acc_reg))
                    case _:
                        print(f"Unhandled symbol location: {location}" )
                        # raise Exception(f"Unhandled symbol location: {location}" )

            case Dynamic_Dispatch(Exp,Method,Args):
                self.gen_dispatch_helper(Exp=Exp, Type=None, Method=Method, Args=Args)
            case Static_Dispatch(Exp,Type,Method,Args):
                self.gen_dispatch_helper(Exp=Exp, Type=Type, Method=Method, Args=Args)
            case Self_Dispatch(Method,Args):
                self.gen_dispatch_helper(Exp=None, Type=None, Method=Method, Args=Args)

            case If(Predicate, Then, Else):

                
                if_then_label = "true_" + self.get_branch_label()
                if_else_label = "false_" + self.get_branch_label()
                if_end_label = "end_" + self.get_branch_label()

                # predicate
                self.cgen(Predicate[1])
                self.append_asm(ASM_Ld(acc_reg,acc_reg,attributes_start_index))
                self.append_asm(ASM_Bnz(acc_reg, if_then_label))

                # else
                self.comment("ELSE (False branch)",not_tabbed=True)
                self.append_asm(ASM_Label(if_else_label))
                self.cgen(Else[1])
                self.append_asm(ASM_Jmp(if_end_label))

                # then
                self.comment("THEN (True branch)",not_tabbed=True)
                self.append_asm(ASM_Label(if_then_label))
                self.cgen(Then[1])

                # end
                self.comment("END of if conditional",not_tabbed=True)
                self.append_asm(ASM_Label(if_end_label))


                # Accumulater will contain the result of either the then or else.
            
            case While(Predicate, Body):
                while_cond_label = "while_predicate_"+ self.get_branch_label()
                while_end_label = "end_while_" + self.get_branch_label()

                self.comment("WHILE (conditional)",not_tabbed=True)
                self.append_asm(ASM_Label(while_cond_label))
                self.cgen(Predicate[1])
                self.append_asm(ASM_Ld(acc_reg,acc_reg,attributes_start_index))
                self.append_asm(ASM_Bz(acc_reg,while_end_label))



                self.comment("WHILE (body)",not_tabbed=True)
                
                self.cgen(Body[1])

                # go back to conditional ( the looping part )
                self.append_asm(ASM_Jmp(while_cond_label))

                self.comment("WHILE (end)",not_tabbed=True)
                self.append_asm(ASM_Label(while_end_label))

            case Block(Body):
                for exp in Body:
                    exp = exp[1]
                    self.cgen(exp)
            # acc will contain the last result of the entire block.

            case New(Type):
                if isinstance(Type,ID):
                    Type = Type[1]

                self.append_asm(ASM_Push("fp"))
                self.append_asm(ASM_Push(self_reg))
                # going to put result in ra register.
                # constructor has no arguments and no self object.
                if(Type == "SELF_TYPE"):
                    self.append_asm(ASM_Call_Label(f"{self.current_class}..new"))
                else:
                    self.append_asm(ASM_Call_Label(f"{Type}..new"))
                self.append_asm(ASM_Pop(self_reg))
                self.append_asm(ASM_Pop("fp"))
                # New object now in accumulator.

            case IsVoid(Exp):
                false_branch = "isvoid_false_branch_" + self.get_branch_label()
                true_branch = "isvoid_true_branch_" + self.get_branch_label()
                end_branch = "isvoid_end_branch_" + self.get_branch_label()
                self.cgen(Exp[1])
                self.append_asm(ASM_Bz(acc_reg, true_branch))
                self.append_asm(ASM_Label(false_branch))
                self.cgen(New(Type="Bool",StaticType="Bool"))
                self.append_asm(ASM_Jmp(end_branch))

                self.append_asm(ASM_Label(true_branch))
                self.cgen(New(Type="Bool",StaticType="Bool"))
                self.append_asm(ASM_Li(temp_reg,ASM_Value(1)))
                self.append_asm(ASM_St(acc_reg,temp_reg,attributes_start_index))

                self.append_asm(ASM_Label(end_branch))


            case Plus(Left,Right):
                self.cgen(Left[1])
                self.append_asm(ASM_Push(acc_reg))
                self.cgen(Right[1])
                self.append_asm(ASM_Pop(temp_reg))

                self.append_asm(ASM_Ld(
                    dest = acc_reg,
                    src = acc_reg,
                    offset = attributes_start_index))
                self.append_asm(ASM_Ld(temp_reg,temp_reg,attributes_start_index))

                self.append_asm(ASM_Add(acc_reg,temp_reg))

                self.append_asm(ASM_Push(temp_reg))

                self.cgen(New(Type="Int", StaticType="Int"))
                self.append_asm(ASM_Pop(temp_reg))

                self.append_asm(ASM_St(
                    dest = acc_reg,
                    src = temp_reg,
                    offset = attributes_start_index))

                # Addition result now in accumulator.

            case Minus(Left,Right):
                self.cgen(Left[1])
                self.append_asm(ASM_Push(acc_reg))
                self.cgen(Right[1])
                self.append_asm(ASM_Pop(temp_reg))

                self.append_asm(ASM_Ld(
                    dest = acc_reg,
                    src = acc_reg,
                    offset = attributes_start_index))
                self.append_asm(ASM_Ld(temp_reg,temp_reg,attributes_start_index))

                self.append_asm(ASM_Sub(acc_reg,temp_reg))


                self.append_asm(ASM_Push(temp_reg))

                self.cgen(New(Type="Int", StaticType="Int"))
                self.append_asm(ASM_Pop(temp_reg))

                self.append_asm(ASM_St(
                    dest = acc_reg,
                    src = temp_reg,
                    offset = attributes_start_index))

                # Subtraction result now in accumulator.

            case Times(Left,Right):
                self.cgen(Left[1])
                self.append_asm(ASM_Push(acc_reg))
                self.cgen(Right[1])
                self.append_asm(ASM_Pop(temp_reg))

                self.append_asm(ASM_Ld(
                    dest = acc_reg,
                    src = acc_reg,
                    offset = attributes_start_index))
                self.append_asm(ASM_Ld(temp_reg,temp_reg,attributes_start_index))

                self.append_asm(ASM_Mul(acc_reg,temp_reg))

                self.append_asm(ASM_Push(temp_reg))

                self.cgen(New(Type="Int", StaticType="Int"))
                self.append_asm(ASM_Pop(temp_reg))

                self.append_asm(ASM_St(
                    dest = acc_reg,
                    src = temp_reg,
                    offset = attributes_start_index))
                # Multiplication result now in accumulator.

            case Divide(Left,Right):
                denominator_line_number = Right[0]

                self.cgen(Left[1])
                self.append_asm(ASM_Push(acc_reg))

                const_denom_val = self.eval_constant_expr(Right[1])
                denom_is_zero = const_denom_val == 0
                if denom_is_zero:
                    self.div_zero_lines.append(denominator_line_number)


                self.cgen(Right[1])
                self.append_asm(ASM_Pop(temp_reg))
                self.append_asm(ASM_Ld(acc_reg,acc_reg,attributes_start_index))
                self.append_asm(ASM_Ld(temp_reg,temp_reg,attributes_start_index))

                if denom_is_zero:
                    # check for zero, if not , jump to true branch.
                    div_ok_label = "div_ok_" + self.get_branch_label()
                    self.append_asm(ASM_Bnz(acc_reg,div_ok_label))
                    # denominnator is zero
                    self.append_asm(ASM_La(acc_reg, "divide_by_zero_string_"+denominator_line_number))
                    self.append_asm(ASM_Syscall("IO.out_string"))
                    self.append_asm(ASM_Syscall("exit"))

                    self.append_asm(ASM_Label(div_ok_label))

                self.append_asm(ASM_Div(acc_reg,temp_reg))

                self.append_asm(ASM_Push(temp_reg))

                self.cgen(New(Type="Int", StaticType="Int"))
                self.append_asm(ASM_Pop(temp_reg))

                self.append_asm(ASM_St(
                    dest = acc_reg,
                    src = temp_reg,
                    offset = attributes_start_index))
                # Division result now in accumulator.


            case Lt(Left,Right) | Le(Left,Right) | Eq(Left, Right):
                self.append_asm(ASM_Push(self_reg))
                self.append_asm(ASM_Push("fp"))

                self.cgen(Left[1])
                self.append_asm(ASM_Push(acc_reg))

                self.cgen(Right[1])
                self.append_asm(ASM_Push(acc_reg))

                self.append_asm(ASM_Push(self_reg))
                # stack:
                # left (raw value)
                # right (raw value)
                # self object
                match type(exp).__name__:
                    case "Lt":
                        self.append_asm(ASM_Call_Label("lt_handler"))
                    case "Le":
                        self.append_asm(ASM_Call_Label("le_handler"))
                    case "Eq":
                        self.append_asm(ASM_Call_Label("eq_handler"))
                    case _:
                        print("Unknown conditional expression:", exp)
                        # raise Exception("Unknown conditional expression:", exp)

                if self.x86:
                    self.append_asm(ASM_Li(temp_reg,ASM_Word(3)))
                    self.append_asm(ASM_Add(temp_reg,"sp"))
                # CLEANUP
                self.append_asm(ASM_Pop("fp"))
                self.append_asm(ASM_Pop(self_reg))


            case Not(Exp):
                self.cgen(Exp[1])
                self.append_asm(ASM_Ld(temp_reg,acc_reg,attributes_start_index))
                self.append_asm(ASM_Li(temp2_reg, ASM_Value(1)))
                self.append_asm(ASM_Sub(temp_reg, temp2_reg))
                self.cgen(New(Type="Bool", StaticType="Bool"))
                self.append_asm(ASM_St(acc_reg, temp2_reg, attributes_start_index))


            case Negate(Exp):

                self.cgen(Exp[1])
                self.append_asm(ASM_Ld(acc_reg,acc_reg,attributes_start_index))
                self.append_asm(ASM_Li(temp_reg,ASM_Value(0)))
                self.append_asm(ASM_Sub(acc_reg,temp_reg))
                
                # IMPORTANT:  THIS IS ASSUMING NEW INT  DOES NOT USE r3
                self.append_asm(ASM_Mov(temp2_reg,temp_reg))

                self.cgen(New(Type="Int",StaticType="Int"))
                self.append_asm(ASM_Mov(temp_reg,temp2_reg))
                self.append_asm(ASM_St(acc_reg,temp_reg,attributes_start_index))


            case Integer(Integer=val, StaticType=st):
                self.cgen(New(Type="Int",StaticType="Int"))
                self.append_asm(ASM_Li(temp_reg,ASM_Value(val)))
                self.append_asm(ASM_St(acc_reg,temp_reg,attributes_start_index))
                # Integer object now in accumulator register.

            case String(String=val):
                self.cgen(New(Type="String",StaticType="String"))

                # add to string label map
                # so that we allocate some memory in our assembly program.
                self.string_to_label.insert(val)

                # load that label into the string object we created.
                self.comment(f"\"{val}\" points to label {self.string_to_label.get(val)}")
                self.append_asm(ASM_La(temp_reg,self.string_to_label.get(val)))
                self.append_asm(ASM_St(acc_reg,temp_reg,attributes_start_index))


            # look up in symbol table, if found, store in accumulator.
            case Identifier(Var):
                if isinstance(Var,ID):
                    var = Var.str
                if isinstance(Var,Attribute):
                    var = Var.Name
                if isinstance(Var,str):
                    var=Var
                
                if var=="self":
                    self.append_asm(ASM_Mov(acc_reg,self_reg))
                    return

                match self.symbol_stack.lookup_symbol(var):
                    case Register(reg):
                        self.comment(f"SYMBOL TABLE: found {var} in register {reg}")
                        self.append_asm(ASM_Mov(dest = acc_reg, src = reg))
                    case Offset(reg,offset):
                        self.comment(f"SYMBOL TABLE: found {var} in register {reg} at offset {offset}")
                        if not self.x86:
                            self.append_asm(ASM_Ld(dest=acc_reg,src=reg,offset=offset))
                        else:
                            self.append_asm(ASM_Ld(dest=acc_reg,src=reg,offset=offset))
                    case _:
                        print(f"Could not find identifier {var}!")
                        # raise Exception(f"Could not find identifier {var}!")

                # loaded in acc

            case true(Value):
                self.cgen(New(Type="Bool", StaticType="Bool"))
                self.append_asm(ASM_Li(temp_reg,ASM_Value(1)))
                self.append_asm(ASM_St(acc_reg,temp_reg,attributes_start_index))

            case false(Value):
                # is there even a point in code genning this
                self.cgen(New(Type="Bool", StaticType="Bool"))


            case Let(Bindings,Body):
                # pushing new scope so that we can store the positions for varibles.
                # so that when we encounter a variable that we set in the bindings,
                #   we can correctly refer to it.
                self.symbol_stack.push_scope()


                self.comment("Let bindings")
                for binding in Bindings:
                    self.cgen(binding)

                self.comment("Let body")
                self.cgen(Body[1])

                self.temporary_index = 0
                self.symbol_stack.pop_scope()



            # no init  binding
            case Let_No_Init(Var,Type):
                var = Var[1]
                if Type.str == "Int" or Type.str == "String" or Type.str == "Bool":
                    self.cgen(New(Type=Type.str,StaticType=Type.str))
                else:
                    # Other objects
                    self.append_asm(ASM_Li(acc_reg,ASM_Value(0)))

                self.comment(f"Store let no init binding in fp[{self.temporary_index}]")
                self.append_asm(ASM_St("fp",acc_reg,self.temporary_index))
                self.symbol_stack.insert_symbol(var,Offset("fp",self.temporary_index))
                self.temporary_index -= 1

            # init binding
            case Let_Init(Var,Type,Exp):
                var = Var[1]
                self.cgen(Exp[1])
                self.comment(f"Store let init binding in fp[{self.temporary_index}]")
                self.append_asm(ASM_St("fp",acc_reg,self.temporary_index))
                self.symbol_stack.insert_symbol(var,Offset("fp",self.temporary_index))
                self.temporary_index -= 1

            case Case(Exp, Elements):
                self.symbol_stack.push_scope()
                line_number = Exp[0]
                self.comment("Case expression (what branches will compare to)")
                exp = Exp[1] # expression we are comparingg all of the branches to
                exp_type = exp.StaticType 
                void_branch = "case_void_branch_" + line_number

                # from pprint import pprint
                # pprint(Exp)
                # pprint(Elements)

                # Generate the expression
                self.case_lines_and_exps.append((line_number,exp_type))
                self.cgen(Exp[1])
                self.append_asm(ASM_Bz(acc_reg,void_branch))

                # store expression in frame pointer.
                self.append_asm(ASM_St("fp",acc_reg,0))
                # load type tag into acc for comparison.
                self.append_asm(ASM_Ld(acc_reg,acc_reg,type_tag_index))
                temp_class_name_to_label={}

                for element in Elements:
                    # print(element.Type.str)
                    # print(self.class_to_tag.get(element.Type.str))
                    class_name = element.Type.str
                    type_tag = self.class_to_tag.get(class_name)

                    self.append_asm(ASM_Li(temp_reg,ASM_Value(type_tag)))
                    case_exp_label = f"case_exp_for_{class_name}_" + self.get_branch_label()
                    temp_class_name_to_label[class_name] = case_exp_label 
                    self.append_asm(ASM_Beq(acc_reg,temp_reg,case_exp_label))


                #check for subtypes.                
                # basically types that we havent added yet, but are subtypes of types that we already added.
                # by added i mean, checking and branching if equal.
                for class_name in self.class_map:
                    if class_name not in temp_class_name_to_label:
                        parent_names = self.get_parents(class_name)
                        for parent_name in parent_names:
                            if parent_name in temp_class_name_to_label:
                                # parent is something we already added, but we didnt add the subtype yet. we should add it. 
                                child_type_tag= self.class_to_tag.get(class_name) 
                                self.append_asm(ASM_Li(temp_reg,ASM_Value(child_type_tag)))
                                case_exp_label = temp_class_name_to_label[parent_name]
                                self.append_asm(ASM_Beq(acc_reg,temp_reg,case_exp_label))

                no_branch= f"case_without_branch_{line_number}_{exp_type}" 

                # case without branch (everyhting else)
                for class_name, tag in self.class_to_tag.get_dict().items():
                    if class_name not in temp_class_name_to_label:
                        self.append_asm(ASM_Li(temp_reg,ASM_Value(tag)))
                        self.append_asm(ASM_Beq(acc_reg,temp_reg,no_branch))


                # FIXME include exp in traversed
                if line_number not in self.traversed_case_lines:                
                    self.append_asm(ASM_Label(no_branch))
                    self.append_asm(ASM_La(acc_reg,f"case_without_branch_string_{line_number}_{exp_type}"))
                    self.append_asm(ASM_Syscall("IO.out_string"))
                    self.append_asm(ASM_Syscall("exit"))

                    # void branch
                    self.append_asm(ASM_Label(void_branch))
                    self.append_asm(ASM_La(acc_reg,f"case_void_string_{line_number}"))
                    self.append_asm(ASM_Syscall("IO.out_string"))
                    self.append_asm(ASM_Syscall("exit"))

                self.traversed_case_lines.append(line_number)

                end_branch = "case_exp_end_" + self.get_branch_label()

                # make the actual branches
                for element in Elements:
                    class_name = element.Type.str
                    case_exp_label = temp_class_name_to_label[class_name]
                    self.append_asm(ASM_Label(case_exp_label))

                    # load in the branch variable or whatever its called
                    self.symbol_stack.insert_symbol(symbol=element.Var.str,loc=Offset("fp",0))

                    self.cgen(element.Body[1])
                    self.append_asm(ASM_Jmp(end_branch))
                



                self.append_asm(ASM_Label(end_branch))
                self.symbol_stack.pop_scope()


            case Internal(Body):

                match Body:
                    case "Object.abort":
                        self.append_asm(ASM_La(acc_reg,"cool_abort"))
                        self.append_asm(ASM_Syscall("IO.out_string"))
                        self.append_asm(ASM_Syscall("exit"))
                    case "Object.type_name":
                        self.cgen(New(Type="String",StaticType="String"))
                        self.append_asm(ASM_Ld(temp_reg,self_reg,vtable_index))
                        # load object name
                        self.append_asm(ASM_Ld(temp_reg,temp_reg,0))
                        self.append_asm(ASM_St(acc_reg,temp_reg,attributes_start_index))
                    case "Object.copy":
                        
                        loop_start_label = "object_copy_loop_start" + self.get_branch_label()
                        loop_end_label = "object_copy_loop_end" + self.get_branch_label()

                        self.append_asm(ASM_Ld(temp_reg,self_reg,object_size_index))
                        # allocate object size number of elements
                        self.append_asm(ASM_Alloc(acc_reg,temp_reg))
                        # Push pointer to allocated memory onto stack.
                        self.append_asm(ASM_Push(acc_reg))
                        self.append_asm(ASM_Label(loop_start_label))
                        # temp reg is the amount of iterations we have left
                        self.append_asm(ASM_Bz(temp_reg,loop_end_label))
                        # copy over name
                        self.append_asm(ASM_Ld(temp2_reg, self_reg,0))
                        self.append_asm(ASM_St(acc_reg, temp2_reg,0))

                        # next object field (for both copy and copee)
                        self.append_asm(ASM_Li(temp2_reg,ASM_Word(1)))
                        self.append_asm(ASM_Add(temp2_reg,self_reg))
                        self.append_asm(ASM_Add(temp2_reg,acc_reg))
                        
                        self.append_asm(ASM_Li(temp2_reg,ASM_Value(1))) # i dont think we need this
                        self.append_asm(ASM_Sub(temp2_reg,temp_reg))                        
                        self.append_asm(ASM_Jmp(loop_start_label))                       

                        self.append_asm(ASM_Label(loop_end_label))
                        self.append_asm(ASM_Pop(acc_reg))

                        # acc register is the self object with different memory addresses.

                    case "IO.out_int":
                        # in the case of out_int, x should be an integer.
                        self.cgen(Identifier(Var="x", StaticType=None))

                        self.append_asm(ASM_Ld(acc_reg, acc_reg, attributes_start_index))

                        self.append_asm(ASM_Syscall(Body))

                    # creates an Int, gets input from user, stores that in the Int
                    case "IO.in_int":
                        self.cgen(New(Type="Int",StaticType="Int"))
                        self.append_asm(ASM_Mov(temp_reg,acc_reg))
                        self.append_asm(ASM_Syscall(Body))
                        # int input now in accumulator.
                        # store that val in our new int.
                        self.append_asm(ASM_St(temp_reg,acc_reg,attributes_start_index))
                        self.append_asm(ASM_Mov(acc_reg,temp_reg))

                    case "IO.out_string":
                        self.cgen(Identifier(Var="x", StaticType="String"))

                        self.append_asm(ASM_Ld(acc_reg,acc_reg,attributes_start_index))
                        self.append_asm(ASM_Syscall(Body))

                        self.comment("IO.out_string stores output into self register.")
                        self.append_asm(ASM_Mov(acc_reg,self_reg))

                    case "IO.in_string":
                        self.cgen(New(Type="String",StaticType="String"))
                        self.append_asm(ASM_Mov(temp_reg,acc_reg))
                        self.append_asm(ASM_Syscall("IO.in_string"))

                        # Store raw string in String object
                        # probasbly have to move rax to acc_reg in x86
                        self.append_asm(ASM_St(temp_reg,acc_reg,attributes_start_index))
                        self.append_asm(ASM_Mov(acc_reg,temp_reg))


                    case "String.length":
                        self.cgen(New(Type="Int",StaticType="Int"))
                        # move Int object to temp
                        self.append_asm(ASM_Mov(temp_reg,acc_reg))
                        # move string literal
                        self.append_asm(ASM_Ld(acc_reg,self_reg,attributes_start_index))
                        self.append_asm(ASM_Syscall(Body))
                        # for cool-asm: length in acc_reg
                        # for x86: length in rax


                        # store length in the Int object
                        self.append_asm(ASM_St(temp_reg, acc_reg, attributes_start_index))
                        self.append_asm(ASM_Mov(acc_reg, temp_reg))

                    case "String.concat":
                        # the final string
                        self.cgen(New(Type="String",StaticType="String"))
                        self.append_asm(ASM_Mov(temp2_reg,acc_reg))

                        self.cgen(Identifier(Var="s",StaticType="String"))
                        self.append_asm(ASM_Mov(temp_reg,acc_reg))
                        self.append_asm(ASM_Ld(temp_reg,acc_reg,attributes_start_index))
                        self.append_asm(ASM_Ld(acc_reg,self_reg,attributes_start_index))

                        self.append_asm(ASM_Syscall(Body))
                        # cool-asm: acc contains combined string
                        # x86: rax contains combined string
                        self.append_asm(ASM_St(temp2_reg,acc_reg,attributes_start_index))
                        self.append_asm(ASM_Mov(acc_reg,temp2_reg))
                    case "String.substr":
                        self.cgen(New(Type="String",StaticType="String"))
                        self.append_asm(ASM_Mov(temp2_reg,acc_reg))

                        # starting int
                        self.cgen(Identifier(Var="l",StaticType="String"))
                        self.append_asm(ASM_Mov(temp_reg,acc_reg))
                        self.append_asm(ASM_Ld(temp_reg,temp_reg,attributes_start_index))

                        # ending int 
                        self.cgen(Identifier(Var="i",StaticType="String"))
                        self.append_asm(ASM_Ld(acc_reg,acc_reg,attributes_start_index))

                        self.append_asm(ASM_Ld(self_reg,self_reg,attributes_start_index))

                        self.append_asm(ASM_Syscall(Body))

                        valid_substr_label = "substr_valid_" + self.get_branch_label()
                        self.append_asm(ASM_Bnz(acc_reg,valid_substr_label))


                        # bad
                        self.append_asm(ASM_La(acc_reg,"substr_bad"))
                        self.append_asm(ASM_Syscall("IO.out_string"))
                        self.append_asm(ASM_Syscall("exit"))

                        self.append_asm(ASM_Label(valid_substr_label))
                        # in x86 - need to move  rax to acc.
                        self.append_asm(ASM_St(temp2_reg,acc_reg,attributes_start_index))
                        self.append_asm(ASM_Mov(acc_reg,temp2_reg))

                    case _:
                        print("Unhandled internal method: ", Body)
                        # raise Exception("Unhandled internal method: ", Body)
            case _:
                print("Unknown expression in cgen: ", exp)
                pass


        self.comment(f"cgen-: {type(exp).__name__}")

    def eval_constant_expr(self,expr):
        # print(expr)
        """Recursively try to evaluate expr as a constant integer."""
        if isinstance(expr, Integer):
            return int(expr.Integer)
        elif isinstance(expr, Identifier):
            pass
        elif isinstance(expr, Negate):
            val = self.eval_constant_expr(expr.Exp[1])
            return -val if val is not None else None
        elif isinstance(expr, Plus):
            left = self.eval_constant_expr(expr.Left[1])
            right = self.eval_constant_expr(expr.Right[1])
            return left + right if None not in (left, right) else None
        elif isinstance(expr, Minus):
            left = self.eval_constant_expr(expr.Left[1])
            right = self.eval_constant_expr(expr.Right[1])
            return left - right if None not in (left, right) else None
        elif isinstance(expr, Times):
            left = self.eval_constant_expr(expr.Left[1])
            right = self.eval_constant_expr(expr.Right[1])
            return left * right if None not in (left, right) else None
        elif isinstance(expr, Divide):
            left = self.eval_constant_expr(expr.Left[1])
            right = self.eval_constant_expr(expr.Right[1])
            if None not in (left, right) and right != 0:
                return left // right
            else:
                return None
        print("Unknown arithmetic expression: ", expr)
        return None  

    def gen_dispatch_helper(self, Exp, Type, Method, Args):
        if Exp:
            exp_line_number = int(Exp[0])

        self.debug("sp")

        self.append_asm(ASM_Push("fp"))
        self.append_asm(ASM_Push(self_reg))

        """
        Here how the stack frame look like:
        arg 1,
        arg 2,
        arg n....
        receiver object
        """
        # Push arguments on stack
        for arg in Args:
            self.cgen(arg[1]) # skip line number
            self.comment("Push argument on the stack.")
            self.append_asm(ASM_Push(acc_reg))

        # If Exp is tuple then we gotta skip the line number
        if isinstance(Exp,tuple):
            Exp = Exp[1]
        if Exp:
            # dynamic / static dispatch
            self.cgen(Exp)
            # check for void.
            non_void_label = "non_void_"+self.get_branch_label()
            self.append_asm(ASM_Bnz(acc_reg,non_void_label))
            self.dispatch_lines.append(exp_line_number)


        # Calling dispatch on void
        if Exp:
            self.append_asm(ASM_La(acc_reg,f"dispatch_void_string_{exp_line_number}"))
            self.append_asm(ASM_Syscall("IO.out_string"))
            self.append_asm(ASM_Syscall("exit"))

        if Exp:
            self.append_asm(ASM_Label(non_void_label))
        
        self.comment("Push receiver on the stack.")
        if Exp:
            # push code generated receiver
            self.append_asm(ASM_Push(acc_reg))
        else:
            # push self receiver
            self.append_asm(ASM_Push(self_reg))


        """
        1. load RO (acc) vtable into (temp)
        2. load the vtable index into (temp2)
        3. temp <- temp[temp2] -- get method pointer
        4. call temp
        """
        # receiver object in acc.
        # e.g: someone wants to invoke "out_int" or "main"
        # emit code to lookup in vtable.
        if Type:
            self.append_asm(ASM_La(temp_reg, f"{Type[1]}..vtable"))
        elif Exp:
            self.append_asm(ASM_Ld(dest=temp_reg, src=acc_reg, offset=vtable_index))
        else:
            self.append_asm(ASM_Ld(dest=temp_reg, src=self_reg, offset=vtable_index))

        if Exp: 
            # Dynamic dispatch
            if Exp.StaticType== "SELF_TYPE":
                class_name = self.current_class
            else:
                class_name = Exp.StaticType
            
        elif Type:
            # Static Dispatch
            # Vtable indices are monotonic
            #TODO: self type?
            class_name = Type[1]
        else:
            # Self dispatch
            class_name = self.current_class

        # print(class_name)
        # print(Exp)

        method_name = Method.str
        method_vtable_index = self.method_index.lookup(class_name,method_name)

        self.comment(f"{class_name}.{method_name} lives at vindex {method_vtable_index}, loading the address.")
        self.append_asm(ASM_Ld(temp_reg, temp_reg, method_vtable_index))
        self.append_asm(ASM_Call_Reg(temp_reg))


        # in cool_asm we are adding to stack pointer in callee
        # cant do this in x86, the return address is in the way.
        # so we do it in the caller, where the return address has already been popped off by ret.
        if self.x86:
            self.append_asm(ASM_Li(temp_reg,ASM_Word(len(Args)+1)))
            self.append_asm(ASM_Add(temp_reg,"sp"))

        # self.add_asm(ASM_Pop(self_reg))
        # get back old frame pointer
        self.append_asm(ASM_Pop(self_reg))
        self.append_asm(ASM_Pop("fp"))

        # ensure stack integrity
        self.debug("sp")

    def get_asm(self,include_comments = False) -> list[namedtuple]:
        asm_instructions = []

        for instr in self.asm_instructions:
            if not isinstance(instr,ASM_Debug):
                asm_instructions.append(instr)

        asm_instructions_no_comments = []

        # lol
        if not include_comments:
            for asm_instr in asm_instructions:
                if(not isinstance(asm_instr,ASM_Comment)):
                    asm_instructions_no_comments.append(asm_instr)

        if not include_comments:
            return asm_instructions_no_comments
        else:
            return asm_instructions

    def flush_asm(self,outfile,include_comments = False ,debug = False) -> None:
        for instr in self.asm_instructions:
            if isinstance(instr,ASM_Comment) and not include_comments: continue
            if isinstance(instr,ASM_Debug) and not debug: continue
            outfile.write(self.format_asm(instr,outfile) + "\n")

    def append_asm(self,instr: namedtuple) -> None:
        self.asm_instructions.append(instr)

    def format_asm(self,instr:namedtuple,outfile) -> str:
        tabs="\t\t\t\t"


        if type(instr).__name__ != "ASM_Label" and type(instr).__name__ != "ASM_Comment":
            outfile.write(tabs)

        match instr:

            case ASM_Debug(reg):
                return f"debug {reg}"
            case ASM_Comment(comment,not_tabbed):
                import re
                result = re.sub(r"^(\s*)", r"\1;;\t", comment)

                #lol
                if not not_tabbed:
                    return tabs+result
                else:
                    return result

            case ASM_Label(label):
                return label + ":"
            case ASM_Li(reg, imm):
                return f"li {reg} <- {imm.value}"
            case ASM_Mov(dest, src):
                return f"mov {dest} <- {src}"

            case ASM_Add(left, right):
                return f"add {right} <- {right} {left}"
            case ASM_Sub(left, right):
                return f"sub {right} <- {right} {left}"
            case ASM_Mul(left, right):
                return f"mul {right} <- {right} {left}"
            case ASM_Div(left, right):
                return f"div {right} <- {right} {left}"

            case ASM_Jmp(label):
                return f"jmp {label}"
            case ASM_Bz(reg,label):
                return f"bz {reg} {label}"
            case ASM_Bnz(reg,label):
                return f"bnz {reg} {label}"
            case ASM_Beq(left,right,label):
                return f"beq {left} {right} {label}"
            # https://en.wikipedia.org/wiki/BLT
            case ASM_Blt(left,right,label):
                return f"blt {left} {right} {label}"
            case ASM_Ble(left,right,label):
                return f"ble {left} {right} {label}"

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
            case ASM_Constant_raw_string(string):
                return f"constant \"{string}\""
            case ASM_Constant_label(label):
                return f"constant {label}"

            case ASM_Syscall(name):
                return f"syscall {name}"

            case _:
                print("Unhandled ASM instruction: ", instr)
                sys.exit(1)


    # recursively traverses expression and computes the temporaries
    #   needed to cgen the exp.
    # for example, each let binding needs room on the stack.
    # dont need to reserve room for function args, as they are pushed on the stack prior.
    def compute_max_stack_depth(self, exp) -> int:
        # return 101;
        final_depth = 0
        match exp:

            case Block(Body):
                final_depth += max(self.compute_max_stack_depth(e[1]) for e in Body)

            case Let(Bindings, Body):
                binding_depth = len(Bindings)
                # recursively calculate depth of body while adding binding_depth
                total_depth = binding_depth+ self.compute_max_stack_depth(Body[1])
                final_depth += total_depth        

            case Case(Exp,Elements):
                # we dont actually need this
                # depth = 1 # for exp
                # total_depth = depth + len(Elements)
                # final_depth += total_depth 
                final_depth += 1

            case If(Predicate, Then, Else):
                then_depth = self.compute_max_stack_depth(Then[1])
                else_depth = self.compute_max_stack_depth(Else[1])
                final_depth += max(then_depth, else_depth)

            case While(Predicate,Body):
                body_depth = self.compute_max_stack_depth(Body[1])
                final_depth += body_depth

            # case Dynamic_Dispatch(Body) | Static_Dispatch(Body) | Self_Dispatch(Body):
            case Self_Dispatch(Method,Args):
                final_depth += self.compute_max_stack_depth(Method[1]) 
            case Dynamic_Dispatch(Exp,Method,Args):
                final_depth += self.compute_max_stack_depth(Method[1]) 
            case Static_Dispatch(Exp,Type,Method,Args):
                final_depth += self.compute_max_stack_depth(Method[1]) 
            case _:
                # print("Unhandled in stack analysis:", exp)
                pass

        # we dont need this, we are already handling alignment in the built_in with andq
        # 16 byte alignment
        # if final_depth%2==0:
        #     final_depth+=1 

        return final_depth
                
    def debug(self,reg):
        self.asm_instructions.append(ASM_Debug(reg))
    def comment(self,comment,not_tabbed=False):
        self.asm_instructions.append(ASM_Comment(comment=comment,not_tabbed=not_tabbed))

    def get_branch_label(self):
        self.branch_counter+=1
        return f"branch_{self.branch_counter}"
        # return (str(uuid.uuid4()).replace("-",""))

    def get_parents(self,child):
        parents = []
        
        while child != "Object":
            parent = self.parent_map[child]
            parents.append(parent)
            child = parent

        return parents

if __name__ == "__main__":
    file = sys.argv[1]

    # open .cl-asm file to write.
    asm_file = file.replace(".cl-type",".cl-asm")
    with open(asm_file,"w") as outfile:
        coolAsmGen = CoolAsmGen(file=file)
        comments = False
        debug = False
        for arg in sys.argv[2:]:
            if arg == "c":
                print("comments enabled.")
                comments = True
            if arg == "d":
                print("debug enabled.")
                debug = True
        coolAsmGen.flush_asm(outfile,include_comments=comments,debug=debug)
