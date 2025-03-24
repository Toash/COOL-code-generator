#!/usr/bin/env python3
"""
PA3 Checkpoint 2
Generate TAC for cool programs 
Basically a more generalized version of assembly
It supposedly will help us with code generation.
"""

import sys
from collections import namedtuple

# AST nodes using namedtuple similar to semantic analyzer
# Cool program structures
CoolClass = namedtuple("CoolClass", "Name Inherits Features")
Attribute = namedtuple("Attribute", "Name Type Initializer")
Method = namedtuple("Method", "Name Formals ReturnType Body")
Formal = namedtuple("Formal", "Name Type")
ID = namedtuple("ID", "loc str")

# Expression AST nodes
AST_Assign = namedtuple("AST_Assign", "Id Exp")
AST_Self_Dispatch = namedtuple("AST_Self_Dispatch", "Method Args")
AST_Dynamic_Dispatch = namedtuple("AST_Dynamic_Dispatch", "Method Args")
AST_If = namedtuple("AST_If", "Cond Then Else")
AST_While = namedtuple("AST_While", "Guard Body")
AST_Block = namedtuple("AST_Block", "Exps")
AST_New = namedtuple("AST_New", "Type")
AST_Isvoid = namedtuple("AST_Isvoid", "Exp")
AST_Plus = namedtuple("AST_Plus", "Left Right")
AST_Minus = namedtuple("AST_Minus", "Left Right")
AST_Times = namedtuple("AST_Times", "Left Right")
AST_Divide = namedtuple("AST_Divide", "Left Right")
AST_LessThan = namedtuple("AST_LessThan", "Left Right")
AST_LessThanEqual = namedtuple("AST_LessThanEqual", "Left Right")
AST_Equal = namedtuple("AST_Equal", "Left Right")
AST_Not = namedtuple("AST_Not", "Exp")
AST_Negate = namedtuple("AST_Negate", "Exp")
AST_Int = namedtuple("AST_Int", "Value")
AST_String = namedtuple("AST_String", "Value")
AST_Variable = namedtuple("AST_Variable", "Name")
AST_Default = namedtuple("AST_Default", "Type")
AST_Bool = namedtuple("AST_Bool", "Value")
AST_Let = namedtuple("AST_Let", "Bindings Body")

# Binding structure
Binding = namedtuple("Binding", "Name Type Init")

# TAC Instructions namedtuples
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
TAC_Label = namedtuple("TAC_Label", "Label")
TAC_Variable = namedtuple("TAC_Variable", "Name")
TAC_Return = namedtuple("TAC_Return", "Var")

# Global variables
counter = 0
label_counter = 0
var_map = {}  # Symbol table
lines = []

def main():
    global lines, counter, label_counter, var_map
    
    fname = sys.argv[1]
    with open(fname) as file:
        # store lines in lines :)
        lines = [line.rstrip("\r\n") for line in file]
    
    # create output file name
    out = fname.rsplit('.', 1)[0] + ".cl-tac"
    fout = open(out, 'w')
    
    # generate temporary
    def fresh_var():
        global counter
        v = counter
        counter += 1
        return f"t${v}"
    
    # generate label
    def fresh_label():
        global label_counter
        l = label_counter
        label_counter += 1
        return f"confusingly_named_label_{l}"
    
    def read():
        global lines
        this_line = lines[0]
        lines = lines[1:]
        return this_line
    
    def read_list(worker):
        k = int(read())
        return [worker() for _ in range(k)]
    
    def read_list2(worker):
        k = int(read())
        return [worker() for _ in range(k * 2)]
    
    def read_id():
        loc = read()
        name = read()
        return (loc, name)
    
    # Read AST nodes from input
    def read_aast():
        try:
            line = read()
            while line:
                if line == "parent_map":
                    # Skip parent map
                    read_list2(read)
                    # Read classes
                    return read_list(read_cool_class)
                line = read()
        except Exception as e:
            print(f"Error: {str(e)}")
            sys.exit(1)
        return []
    
    def read_cool_class():
        cname = read_id()
        inherits_type = read()
        
        if inherits_type == "no_inherits":
            inherits = None
        elif inherits_type == "inherits":
            inherits = read_id()
        else:
            raise Exception(f"Error reading class: {inherits_type}")
        
        features = read_list(read_feature)
        return CoolClass(cname, inherits, features)
    
    def read_feature():
        feature_type = read()
        
        if feature_type == "attribute_no_init":
            fname = read_id()
            ftype = read_id()
            return Attribute(fname, ftype, None)
        
        elif feature_type == "attribute_init":
            fname = read_id()
            ftype = read_id()
            finit = read_exp()
            return Attribute(fname, ftype, finit)
        
        elif feature_type == "method":
            mname = read_id()
            formals = read_list(read_formal)
            mtype = read_id()
            mbody = read_exp()
            return Method(mname, formals, mtype, mbody)
        
        else:
            raise Exception(f"Error reading feature: {feature_type}")
    
    def read_formal():
        fname = read_id()
        ftype = read_id()
        return Formal(fname, ftype)
    
    def read_binding():
        binding_type = read()
        
        if binding_type == "let_binding_no_init":
            bname = read_id()
            btype = read_id()
            return Binding(bname, btype, None)
        
        elif binding_type == "let_binding_init":
            bname = read_id()
            btype = read_id()
            bval = read_exp()
            return Binding(bname, btype, bval)
        
        else:
            raise Exception(f"Error reading binding: {binding_type}")
    
    def read_exp():
        loc = read()
        annotated_type = read()
        exp_type = read()
        
        if exp_type == "assign":
            id_name = read_id()
            exp = read_exp()
            return AST_Assign(id_name, exp)
        
        elif exp_type == "self_dispatch":
            method = read_id()
            exps = read_list(read_exp)
            return AST_Self_Dispatch(method, exps)
        
        elif exp_type == "dynamic_dispatch":
            exp = read_exp()  # In the OCaml code this is ignored
            method = read_id()
            exps = read_list(read_exp)
            return AST_Dynamic_Dispatch(method, exps)
        
        elif exp_type == "if":
            cond = read_exp()
            then_branch = read_exp()
            else_branch = read_exp()
            return AST_If(cond, then_branch, else_branch)
        
        elif exp_type == "while":
            guard = read_exp()
            body = read_exp()
            return AST_While(guard, body)
        
        elif exp_type == "block":
            exps = read_list(read_exp)
            return AST_Block(exps)
        
        elif exp_type == "new":
            typ = read_id()
            return AST_New(typ[1])
        
        elif exp_type == "isvoid":
            exp = read_exp()
            return AST_Isvoid(exp)
        
        elif exp_type == "plus":
            exp1 = read_exp()
            exp2 = read_exp()
            return AST_Plus(exp1, exp2)
        
        elif exp_type == "minus":
            exp1 = read_exp()
            exp2 = read_exp()
            return AST_Minus(exp1, exp2)
        
        elif exp_type == "times":
            exp1 = read_exp()
            exp2 = read_exp()
            return AST_Times(exp1, exp2)
        
        elif exp_type == "divide":
            exp1 = read_exp()
            exp2 = read_exp()
            return AST_Divide(exp1, exp2)
        
        elif exp_type == "lt":
            exp1 = read_exp()
            exp2 = read_exp()
            return AST_LessThan(exp1, exp2)
        
        elif exp_type == "le":
            exp1 = read_exp()
            exp2 = read_exp()
            return AST_LessThanEqual(exp1, exp2)
        
        elif exp_type == "eq":
            exp1 = read_exp()
            exp2 = read_exp()
            return AST_Equal(exp1, exp2)
        
        elif exp_type == "not":
            exp = read_exp()
            return AST_Not(exp)
        
        elif exp_type == "negate":
            exp = read_exp()
            return AST_Negate(exp)
        
        elif exp_type == "integer":
            ival = read()
            return AST_Int(ival)
        
        elif exp_type == "string":
            sval = read()
            return AST_String(sval)
        
        elif exp_type == "identifier":
            id_name = read_id()
            return AST_Variable(id_name[1])
        
        elif exp_type == "true":
            return AST_Bool("true")
        
        elif exp_type == "false":
            return AST_Bool("false")
        
        elif exp_type == "let":
            bindings = read_list(read_binding)
            body = read_exp()
            return AST_Let(bindings, body)
        
        else:
            print(f"Expression kind not handled: {exp_type}")
            sys.exit(1)
    
    # Convert AST to TAC instructions
    def convert(ast):
        global var_map
        
        if isinstance(ast, AST_Variable):
            # Get the corresponding temp from data structure
            try:
                stored_var = var_map.get(ast.Name, ast.Name)
                return [], TAC_Variable(stored_var)
            except:
                return [], TAC_Variable(ast.Name)
        
        elif isinstance(ast, AST_Default):
            new_var = fresh_var()
            return [TAC_Assign_Default(TAC_Variable(new_var), ast.Type)], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Assign):
            instr, ret = convert(ast.Exp)
            
            try:
                found_var = var_map[ast.Id[1]]
            except:
                print("Variable not found in symbol table")
                sys.exit(1)
            
            to_output = TAC_Assign(TAC_Variable(found_var), ret)
            return instr + [to_output], TAC_Variable(found_var)
        
        elif isinstance(ast, (AST_Self_Dispatch, AST_Dynamic_Dispatch)):
            mname = ast.Method[1]
            exps = ast.Args
            
            instr = []
            return_exp = []
            
            for exp in exps:
                inst, expr = convert(exp)
                instr.extend(inst)
                return_exp.append(expr)
            
            new_var = fresh_var()
            last_return_exp = return_exp[-1] if return_exp else None
            
            to_output = TAC_Assign_Call(
                new_var, 
                mname, 
                last_return_exp if last_return_exp else TAC_Variable("")
            )
            
            return instr + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_If):
            cond_instr, cond_var = convert(ast.Cond)
            then_instr, then_var = convert(ast.Then)
            else_instr, else_var = convert(ast.Else)
            
            then_label = fresh_label()
            else_label = fresh_label()
            join_label = fresh_label()
            
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
            
            return result, then_var
        
        elif isinstance(ast, AST_While):
            cond_instr, cond_var = convert(ast.Guard)
            body_instr, body_var = convert(ast.Body)
            
            while_label = fresh_label()
            body_label = fresh_label()
            join_label = fresh_label()
            
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
        
        elif isinstance(ast, AST_Block):
            if not ast.Exps:
                raise Exception("Empty block")
            
            # For each expression in the block
            if len(ast.Exps) == 1:
                return convert(ast.Exps[0])
            
            instructions = []
            for i, exp in enumerate(ast.Exps[:-1]):
                instr, _ = convert(exp)
                instructions.extend(instr)
            
            last_instr, last_var = convert(ast.Exps[-1])
            instructions.extend(last_instr)
            
            return instructions, last_var
        
        elif isinstance(ast, AST_New):
            new_var = fresh_var()
            return [TAC_Assign_New(new_var, ast.Type)], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Isvoid):
            new_var = fresh_var()
            i1, ta1 = convert(ast.Exp)
            to_output = TAC_Assign_IsVoid(new_var, ta1)
            return i1 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Plus):
            i1, ta1 = convert(ast.Left)
            i2, ta2 = convert(ast.Right)
            new_var = fresh_var()
            to_output = TAC_Assign_Plus(new_var, ta1, ta2)
            return i1 + i2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Minus):
            i1, ta1 = convert(ast.Left)
            i2, ta2 = convert(ast.Right)
            new_var = fresh_var()
            to_output = TAC_Assign_Minus(new_var, ta1, ta2)
            return i1 + i2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Times):
            i1, ta1 = convert(ast.Left)
            i2, ta2 = convert(ast.Right)
            new_var = fresh_var()
            to_output = TAC_Assign_Times(new_var, ta1, ta2)
            return i1 + i2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Divide):
            i1, ta1 = convert(ast.Left)
            i2, ta2 = convert(ast.Right)
            new_var = fresh_var()
            to_output = TAC_Assign_Divide(new_var, ta1, ta2)
            return i1 + i2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_LessThan):
            i1, ta1 = convert(ast.Left)
            i2, ta2 = convert(ast.Right)
            new_var = fresh_var()
            to_output = TAC_Assign_LessThan(new_var, ta1, ta2)
            return i1 + i2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_LessThanEqual):
            i1, ta1 = convert(ast.Left)
            i2, ta2 = convert(ast.Right)
            new_var = fresh_var()
            to_output = TAC_Assign_LessThanEqual(new_var, ta1, ta2)
            return i1 + i2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Equal):
            i1, ta1 = convert(ast.Left)
            i2, ta2 = convert(ast.Right)
            new_var = fresh_var()
            to_output = TAC_Assign_Equal(new_var, ta1, ta2)
            return i1 + i2 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Int):
            new_var = fresh_var()
            return [TAC_Assign_Int(new_var, ast.Value)], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Bool):
            new_var = fresh_var()
            return [TAC_Assign_Bool(new_var, ast.Value)], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_String):
            new_var = fresh_var()
            return [TAC_Assign_String(new_var, ast.Value)], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Not):
            new_var = fresh_var()
            i1, ta1 = convert(ast.Exp)
            to_output = TAC_Assign_Not(new_var, ta1)
            return i1 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Negate):
            new_var = fresh_var()
            i1, ta1 = convert(ast.Exp)
            to_output = TAC_Assign_Negate(new_var, ta1)
            return i1 + [to_output], TAC_Variable(new_var)
        
        elif isinstance(ast, AST_Let):
            # Convert bindings to expressions
            bindings = ast.Bindings
            binding_instr = []
            binding_rets = []
            
            # Process each binding
            for binding in bindings:
                if binding.Init:
                    instr, ret = convert(binding.Init)
                else:
                    instr, ret = convert(AST_Default(binding.Type[1]))
                
                binding_instr.extend(instr)
                binding_rets.append(ret)
            
            # Map variables with their corresponding temporary variables
            for i, binding in enumerate(bindings):
                var_map[binding.Name[1]] = binding_rets[i].Name
            
            # Convert body
            body_instr, body_ret = convert(ast.Body)
            
            # Clean up bindings from var_map
            for binding in bindings:
                if binding.Name[1] in var_map:
                    del var_map[binding.Name[1]]
            
            return binding_instr + body_instr, body_ret
        
        else:
            print(f"Expression not handled: {type(ast)}")
            sys.exit(1)
    
    # Print TAC to output file
    def print_tac(instructions, expression):
        for instr in instructions:
            if isinstance(instr, TAC_Assign):
                fout.write(f"{instr.Dest.Name} <- {instr.Src.Name}\n")
            
            elif isinstance(instr, TAC_Assign_Default):
                fout.write(f"{instr.Var.Name} <- default {instr.Type}\n")
            
            elif isinstance(instr, TAC_Assign_Call):
                fout.write(f"{instr.Dest} <- call {instr.Method} {instr.Arg.Name}\n")
            
            elif isinstance(instr, TAC_Assign_New):
                fout.write(f"{instr.Dest} <- new {instr.Type}\n")
            
            elif isinstance(instr, TAC_Assign_IsVoid):
                fout.write(f"{instr.Dest} <- isvoid {instr.Src.Name}\n")
            
            elif isinstance(instr, TAC_Assign_Plus):
                fout.write(f"{instr.Dest} <- + {instr.Left.Name} {instr.Right.Name}\n")
            
            elif isinstance(instr, TAC_Assign_Minus):
                fout.write(f"{instr.Dest} <- - {instr.Left.Name} {instr.Right.Name}\n")
            
            elif isinstance(instr, TAC_Assign_Times):
                fout.write(f"{instr.Dest} <- * {instr.Left.Name} {instr.Right.Name}\n")
            
            elif isinstance(instr, TAC_Assign_Divide):
                fout.write(f"{instr.Dest} <- / {instr.Left.Name} {instr.Right.Name}\n")
            
            elif isinstance(instr, TAC_Assign_LessThan):
                fout.write(f"{instr.Dest} <- < {instr.Left.Name} {instr.Right.Name}\n")
            
            elif isinstance(instr, TAC_Assign_LessThanEqual):
                fout.write(f"{instr.Dest} <- <= {instr.Left.Name} {instr.Right.Name}\n")
            
            elif isinstance(instr, TAC_Assign_Equal):
                fout.write(f"{instr.Dest} <- = {instr.Left.Name} {instr.Right.Name}\n")
            
            elif isinstance(instr, TAC_Assign_Int):
                fout.write(f"{instr.Dest} <- int {instr.Value}\n")
            
            elif isinstance(instr, TAC_Assign_Bool):
                fout.write(f"{instr.Dest} <- bool {instr.Value}\n")
            
            elif isinstance(instr, TAC_Assign_String):
                fout.write(f"{instr.Dest} <- string\n{instr.Value}\n")
            
            elif isinstance(instr, TAC_Assign_Not):
                fout.write(f"{instr.Dest} <- not {instr.Src.Name}\n")
            
            elif isinstance(instr, TAC_Assign_Negate):
                fout.write(f"{instr.Dest} <- ~ {instr.Src.Name}\n")
            
            elif isinstance(instr, TAC_Bt):
                fout.write(f"bt {instr.Cond.Name} {instr.Label}\n")
            
            elif isinstance(instr, TAC_Jmp):
                fout.write(f"jmp {instr.Label}\n")
            
            elif isinstance(instr, TAC_Label):
                fout.write(f"label {instr.Label}\n")
        
        # Print return expression
        fout.write(f"return {expression.Name}\n")
    
    # Main program execution
    ast = read_aast()
    
    # Process each class
    for c in ast:
        for feature in c.Features:
            if isinstance(feature, Method):
                # Reset counter for each method
                counter = 0
                
                # Convert method body to TAC
                instructions, expression = convert(feature.Body)
                
                # Add a label at the beginning
                instructions = [TAC_Label(fresh_label())] + instructions
                
                # Print TAC instructions for this method
                print_tac(instructions, expression)
    
    # Close output file
    fout.close()

if __name__ == "__main__":
    main() 