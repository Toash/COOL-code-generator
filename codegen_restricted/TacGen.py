#!/usr/bin/env python3
"""
Generate TAC
"""
import sys
from collections import namedtuple
from ast_nodes import *
from parser import Parser

# TAC Instructions
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

class TacGen:

    def __init__(self,file):
        self.file = file

        self.var_counter=0
        self.label_counter=0
        self.symbol_table={}

        self.class_map = {}
        self.imp_map = {}
        self.parent_map = {}

        self.tac_instructions = []
        self.final_return_variable= ""

        self._parse(file)
        self._gen_tac() # update object state for instrs and retval

    def get_instructions(self):
        return self.tac_instructions
    def get_final_return_variable(self):
        return self.final_return_variable

    def _gen_tac(self):
        self.tac_instructions.append(TAC_Comment(Comment="start"))
        starting_point = self.imp_map[("Main","main")][0] # wait why is this a list?
        self.tac_instructions.append(TAC_Label(Label="Main_main"))

        # print(starting_point)
        new_instructions, self.final_return_variable = self.convert(starting_point)
        self.tac_instructions.extend(new_instructions)

    # Print TAC to output file
    def output_tac(self):
        instructions = self.tac_instructions
        return_var = self.final_return_variable

        file_tac = self.file.replace(".cl-type",".cl-tac")
        with open(file_tac, "w") as file:
            # print("outputting tac...")
            for instr in instructions:
                if isinstance(instr, TAC_Assign):
                    file.write(f"{instr.Dest.Name} <- {instr.Src.Name}\n")

                elif isinstance(instr, TAC_Assign_Default):
                    file.write(f"{instr.Var.str} <- default {instr.Type}\n")

                elif isinstance(instr, TAC_Assign_Call):
                    file.write(f"{instr.Dest} <- call {instr.Method} {instr.Arg.Name}\n")

                elif isinstance(instr, TAC_Assign_New):
                    file.write(f"{instr.Dest} <- new {instr.Type}\n")

                elif isinstance(instr, TAC_Assign_IsVoid):
                    file.write(f"{instr.Dest} <- isvoid {instr.Src.Name}\n")

                elif isinstance(instr, TAC_Assign_Plus):
                    file.write(f"{instr.Dest} <- + {instr.Left.Name} {instr.Right.Name}\n")

                elif isinstance(instr, TAC_Assign_Minus):
                    file.write(f"{instr.Dest} <- - {instr.Left.Name} {instr.Right.Name}\n")

                elif isinstance(instr, TAC_Assign_Times):
                    file.write(f"{instr.Dest} <- * {instr.Left.Name} {instr.Right.Name}\n")

                elif isinstance(instr, TAC_Assign_Divide):
                    file.write(f"{instr.Dest} <- / {instr.Left.Name} {instr.Right.Name}\n")

                elif isinstance(instr, TAC_Assign_LessThan):
                    file.write(f"{instr.Dest} <- < {instr.Left.Name} {instr.Right.Name}\n")

                elif isinstance(instr, TAC_Assign_LessThanEqual):
                    file.write(f"{instr.Dest} <- <= {instr.Left.Name} {instr.Right.Name}\n")

                elif isinstance(instr, TAC_Assign_Equal):
                    file.write(f"{instr.Dest} <- = {instr.Left.Name} {instr.Right.Name}\n")

                elif isinstance(instr, TAC_Assign_Int):
                    file.write(f"{instr.Dest} <- int {instr.Value}\n")

                elif isinstance(instr, TAC_Assign_Bool):
                    file.write(f"{instr.Dest} <- bool {instr.Value}\n")

                elif isinstance(instr, TAC_Assign_String):
                    file.write(f"{instr.Dest} <- string\n{instr.Value}\n")

                elif isinstance(instr, TAC_Assign_Not):
                    file.write(f"{instr.Dest} <- not {instr.Src.Name}\n")

                elif isinstance(instr, TAC_Assign_Negate):
                    file.write(f"{instr.Dest} <- ~ {instr.Src.Name}\n")

                elif isinstance(instr, TAC_Bt):
                    file.write(f"bt {instr.Cond.Name} {instr.Label}\n")

                elif isinstance(instr, TAC_Jmp):
                    file.write(f"jmp {instr.Label}\n")

                elif isinstance(instr, TAC_Label):
                    file.write(f"label {instr.Label}\n")

                elif isinstance(instr, TAC_Comment):
                    file.write(f"comment {instr.Comment}\n")

            # Print return expression
            file.write(f"return {return_var.Name}\n")

    def _parse(self, file):
        parser=Parser(file)
        self.class_map, self.imp_map, self.parent_map = parser.parse()


    def fresh_var(self):
        self.var_counter+=1
        return f"t${self.var_counter}"

    def fresh_label(self):
        self.label_counter+=1
        #should probably generate a better label name
        return f"label_{self.label_counter}"

    """
    Convert AST to TAC instructions
    we return the last tac variable, because thats where the result of the expression is stored.
    
    Basically the common theme is that we return the list of instructions , afterwards a return address for those instructions.
        We do this recursively (ofc), like all asts
    """
    def convert(self, ast):
        line_number = ast[0]
        exp = ast[1]
        # print("Converting:", exp)

        if isinstance(exp, Identifier):
            # check if we have in symbol table
            if exp.Var.str in self.symbol_table:
                return [], TAC_Variable(self.symbol_table[exp.Var.str])
            else:
                return [], TAC_Variable(exp.Var.str)
        
        # set var to expression
        elif isinstance(exp, Assign):
            instr, ret = self.convert(exp.Exp)
            
            try:
                found_var = self.symbol_table[exp.Var.str]
            except:
                print("excuse me, but you are trying to assign to a variable that does not exist!")
                sys.exit(1)
            
            to_output = TAC_Assign(TAC_Variable(found_var), ret)
            return instr + [to_output], TAC_Variable(found_var)
        
        elif isinstance(exp, Self_Dispatch):
            method_name = exp.Method[1]
            arg_exps = exp.Args
            
            instr = []
            return_exp = []
            
            for exp in arg_exps:
                inst, expr = self.convert(exp)
                instr.extend(inst)
                return_exp.append(expr)
            
            new_var = self.fresh_var()
            last_return_exp = return_exp[-1] if return_exp else None
            
            to_output = TAC_Assign_Call(
                new_var, 
                method_name,
                last_return_exp if last_return_exp else TAC_Variable("")
            )
            
            return instr + [to_output], TAC_Variable(new_var)
        
        elif isinstance(exp, If):
            cond_instr, cond_var = self.convert(exp.Predicate)
            then_instr, then_var = self.convert(exp.Then)
            else_instr, else_var = self.convert(exp.Else)
            
            then_label = self.fresh_label()
            else_label = self.fresh_label()
            join_label = self.fresh_label()
            
            bt_instr = TAC_Bt(cond_var, then_label)
            jmp_else = TAC_Jmp(else_label)
            jmp_join = TAC_Jmp(join_label)
            
            result = (
                cond_instr + 
                [bt_instr, jmp_else, TAC_Label(then_label)] + 
                then_instr + 
                [jmp_join, TAC_Label(else_label)] + 
                else_instr + 
                [TAC_Label(join_label)]
            )

           # why is it then_var?
            return result, then_var
        
        elif isinstance(exp, While):
            cond_instr, cond_var = self.convert(exp.Predicate)
            body_instr, body_var = self.convert(exp.Body)
            
            while_label = self.fresh_label()
            body_label = self.fresh_label()
            join_label = self.fresh_label()
            
            bt_instr = TAC_Bt(cond_var, body_label)
            jmp_while = TAC_Jmp(while_label)
            jmp_join = TAC_Jmp(join_label)
            
            result = (
                [TAC_Label(while_label)] + 
                cond_instr + 
                [bt_instr, jmp_join, TAC_Label(body_label)] + 
                body_instr + 
                [jmp_while, TAC_Label(join_label)]
            )
            
            return result, body_var
        
        elif isinstance(exp, Block):
            if not exp.Body:
                raise Exception("Empty block")
            
            # For each expression in the block
            if len(exp.Body) == 1:
                # just return that, no need consider last.
                return self.convert(exp.Body[0])
            
            instructions = []
            for exp1 in exp.Body[:-1]:
                instr, _ = self.convert(exp1)
                instructions.extend(instr)

            last_instr, last_var = self.convert(exp.Body[-1])
            instructions.extend(last_instr)
            
            return instructions, last_var
        
        elif isinstance(exp, New):
            new_var = self.fresh_var()
            return [TAC_Assign_New(new_var, exp.Type)], TAC_Variable(new_var)
        
        elif isinstance(exp, IsVoid):
            new_var = self.fresh_var()
            inst, var= self.convert(exp.Exp)
            to_output = TAC_Assign_IsVoid(new_var, var)
            return inst+ [to_output], TAC_Variable(new_var)
        
        elif isinstance(exp, Plus):
            instr1, var1 = self.convert(exp.Left)
            instr2, var2 = self.convert(exp.Right)

            # creating a fresh var so that we store the result.
            new_var = self.fresh_var()
            to_output = TAC_Assign_Plus(new_var, var1, var2)
            return instr1 + instr2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(exp, Minus):
            instr1, var1 = self.convert(exp.Left)
            instr2, var2 = self.convert(exp.Right)
            new_var = self.fresh_var()
            to_output = TAC_Assign_Minus(new_var, var1, var2)
            return instr1 + instr2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(exp, Times):
            instr1, var1 = self.convert(exp.Left)
            instr2, var2 = self.convert(exp.Right)
            new_var = self.fresh_var()
            to_output = TAC_Assign_Times(new_var, var1, var2)
            return instr1 + instr2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(exp, Divide):
            instr1, var1 = self.convert(exp.Left)
            instr2, var2 = self.convert(exp.Right)
            new_var = self.fresh_var()
            to_output = TAC_Assign_Divide(new_var, var1, var2)
            return instr1 + instr2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(exp, Lt):
            instr1, var1 = self.convert(exp.Left)
            instr2, var2 = self.convert(exp.Right)
            new_var = self.fresh_var()
            to_output = TAC_Assign_LessThan(new_var, var1, var2)
            return instr1 + instr2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(exp, Le):
            instr1, var1 = self.convert(exp.Left)
            instr2, var2 = self.convert(exp.Right)
            new_var = self.fresh_var()
            to_output = TAC_Assign_LessThanEqual(new_var, var1, var2)
            return instr1 + instr2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(exp, Eq):
            instr1, var1 = self.convert(exp.Left)
            instr2, var2 = self.convert(exp.Right)
            new_var = self.fresh_var()
            to_output = TAC_Assign_Equal(new_var, var1, var2)
            return instr1 + instr2 + [to_output], TAC_Variable(new_var)

        elif isinstance(exp, Not):
            new_var = self.fresh_var()
            instr1, var1 = self.convert(exp.Exp)
            to_output = TAC_Assign_Not(new_var, var1)
            return instr1 + [to_output], TAC_Variable(new_var)

        elif isinstance(exp, Negate):
            new_var = self.fresh_var()
            instr1, var1 = self.convert(exp.Exp)
            to_output = TAC_Assign_Negate(new_var, var1)
            return instr1 + [to_output], TAC_Variable(new_var)

        elif isinstance(exp, Integer):
            new_var = self.fresh_var()
            return [TAC_Assign_Int(new_var, exp.Integer)], TAC_Variable(new_var)

        elif isinstance(exp, String):
            new_var = self.fresh_var()
            return [TAC_Assign_String(new_var, exp.String)], TAC_Variable(new_var)

        elif isinstance(exp, true):
            new_var = self.fresh_var()
            return [TAC_Assign_Bool(Dest=new_var,Value="true")], TAC_Variable(new_var)

        elif isinstance(exp, false):
            new_var = self.fresh_var()
            return [TAC_Assign_Bool(Dest=new_var,Value="false")], TAC_Variable(new_var)

        elif isinstance(exp, Let):
            bindings = exp.Bindings # can either be Let_No_init or Let_Init
            binding_instr = []
            binding_rets = []
            
            # Process each binding
            for binding in bindings:
                if isinstance(binding,Let_Init):
                    instr, ret = self.convert(binding.Exp)
                elif isinstance(binding,Let_No_Init):
                    binding_type = binding.Type.str
                    print("Binding type: ", binding_type)

                    # we need a var to assign the default value to.
                    var = self.fresh_var()
                    # to keep it consistent
                    var_id = ID(loc=0,str=var)
                    instr = [TAC_Assign_Default(Var=var_id, Type=binding_type)]
                    ret = TAC_Variable(Name=var)
                else:
                    print("Invalid binding, what?")
                    sys.exit(1)

                binding_instr.extend(instr)
                binding_rets.append(ret)
            
            # Map variables with their corresponding temporary variables
            for i, binding in enumerate(bindings):
                # print("binding:", binding)
                self.symbol_table[binding.Var.str] = binding_rets[i].Name
            
            # Convert body
            # we have the variable for the bindings with their corresponding temporary register name!
            body_instr, body_ret = self.convert(exp.Body)

            # Clean up bindings from var_map
            for binding in bindings:
                if binding.Var.str in self.symbol_table:
                    del self.symbol_table[binding.Var.str]

            return binding_instr + body_instr, body_ret

        else:
            print(f"Expression not handled: {type(exp)}")
            sys.exit(1)



if __name__ == '__main__':
    tac_gen = TacGen(sys.argv[1])
    tac_gen.output_tac()
    # print(tac_gen.get_tac())