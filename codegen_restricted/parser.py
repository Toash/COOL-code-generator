from ast_nodes import *
import sys
# # explicitly defined classes and their attributes
# class_map = {}
# # Defines classes and their methods
# # takes into account overriding
# imp_map = {}
# # inheritance hierarchy
# # parent child relationship
# parent_map = {} 

class Parser:
    def __init__(self,filename):
        self.filename = filename
        self.lines = []

        self.class_map = {}
        self.imp_map = {}
        self.parent_map = {}
        self.direct_methods = {}

        # self.act_recs = 0 # keep track of activation records
        self.read_lines()

    def parse(self):
        self.read_class_map()
        self.read_imp_map()
        self.read_parent_map()
        self.get_direct_methods()
        return self.class_map, self.imp_map, self.parent_map, self.direct_methods
    
    def read_lines(self):
        sys.setrecursionlimit(20000)
        # fname = sys.argv[1] 
        with open(self.filename) as file:
            self.lines = [line.rstrip("\r\n") for line in file] 

    def read(self): 
        this_line = self.lines[0] 
        self.lines = self.lines[1:]
        return this_line 

    def read_list(self, worker):
        k = int(self.read()) 
        return [ worker() for _ in range(k) ] 

    def read_id(self):
        loc = self.read() 
        name = self.read()
        return ID(loc, name) 

    def read_bindings(self):
        ekind = self.read_ekind(1)
        return ekind

    def read_case_elements(self):
        var = self.read_id()
        type = self.read_id()
        body = self.read_exp()
        return Case_element(var, type, body, None)

    def read_exp(self):
        eloc = self.read() 
        ekind = self.read_ekind(0)
        return (eloc, ekind)

    def read_ekind(self, binding):
        if not binding: 
            static_type = self.read()
        ekind = self.read() 
        if ekind == "integer":
            val = self.read()
            return Integer(val, static_type)
        elif ekind == "identifier":
            id = self.read_id()
            return Identifier(id, static_type)
        elif ekind == "string":
            val = self.read()
            return String(val, static_type)
        elif ekind == "plus": 
            left = self.read_exp()
            right = self.read_exp()
            return Plus(left, right, static_type) 
        elif ekind == "minus": 
            left = self.read_exp()
            right = self.read_exp()
            return Minus(left, right, static_type) 
        elif ekind == "times": 
            left = self.read_exp()
            right = self.read_exp()
            return Times(left, right, static_type) 
        elif ekind == "divide": 
            left = self.read_exp()
            right = self.read_exp()
            return Divide(left, right, static_type) 
        elif ekind == "lt": 
            left = self.read_exp()
            right = self.read_exp()
            return Lt(left, right, static_type) 
        elif ekind == "le": 
            left = self.read_exp()
            right = self.read_exp()
            return Le(left, right, static_type) 
        elif ekind == "eq": 
            left = self.read_exp()
            right = self.read_exp()
            return Eq(left, right, static_type) 
        elif ekind == "not": 
            exp = self.read_exp()
            return Not(exp, static_type)
        elif ekind == "negate": 
            exp = self.read_exp()
            return Negate(exp, static_type)
        elif ekind == "isvoid": 
            exp = self.read_exp()
            return IsVoid(exp, static_type)
        elif ekind == "new": 
            type = self.read_id()
            return New(type, static_type)
        elif ekind == "true": 
            return true(True, static_type)
        elif ekind == "false": 
            return false(False, static_type)
        elif ekind == "block":
            body = self.read_list(self.read_exp)
            return Block(body, static_type)
        elif ekind == "while":
            predicate = self.read_exp()
            body = self.read_exp()
            return While(predicate, body, static_type) 
        elif ekind == "if":
            predicate = self.read_exp()
            then_branch = self.read_exp()
            else_branch = self.read_exp()
            return If(predicate, then_branch, else_branch, static_type)
        elif ekind == "dynamic_dispatch":
            exp = self.read_exp()
            method = self.read_id()
            args = self.read_list(self.read_exp)
            return Dynamic_Dispatch(exp, method, args, static_type)
        elif ekind == "static_dispatch":
            exp = self.read_exp()
            type = self.read_id()
            method = self.read_id()
            args = self.read_list(self.read_exp)
            return Static_Dispatch(exp, type, method, args, static_type)
        elif ekind == "self_dispatch":
            method = self.read_id()
            args = self.read_list(self.read_exp)
            return Self_Dispatch(method, args, static_type)
        elif ekind == "assign":
            var = self.read_id()
            exp = self.read_exp()
            return Assign(var, exp, static_type)
        elif ekind == "let":
            bindings = self.read_list(self.read_bindings)
            body = self.read_exp()
            return Let(bindings, body, static_type)
        elif ekind == "let_binding_no_init":
            var = self.read_id()
            type = self.read_id()
            return Let_No_Init(var, type)
        elif ekind == "let_binding_init":
            var = self.read_id()
            type = self.read_id()
            exp = self.read_exp()
            return Let_Init(var, type, exp)
        elif ekind == "case":
            exp = self.read_exp()
            elements = self.read_list(self.read_case_elements)
            return Case(exp, elements, static_type)
        elif ekind == 'internal':
            body = self.read()
            return Internal(body, static_type)
        else: 
            raise (Exception(f"read_ekind: {ekind} unhandled"))

    def read_class_map(self):
        self.read()
        num_classes = self.read()
        for i in range(int(num_classes)):
            self.read_class_map_class()

    def read_class_map_class(self):
        class_name = self.read()
        self.class_map[class_name] = []
        num_attrs = self.read()
        for i in range(int(num_attrs)):
            self.read_class_map_attr(class_name)

    def read_class_map_attr(self, class_name):
        init = self.read()
        attr_name = self.read()
        type_name = self.read()
        if init == "initializer": 
            init_exp = self.read_exp()
        else: 
            init_exp = None
        self.class_map[class_name].append(Attribute(attr_name, type_name, init_exp))

    def read_imp_map(self):
        self.read()
        num_classes = self.read()
        for i in range(int(num_classes)):
            self.read_imp_map_class()

    def read_imp_map_class(self):
        class_name = self.read()
        num_methods = self.read()
        for i in range(int(num_methods)):
            self.read_imp_map_method(class_name)

    def read_imp_map_method(self, class_name):
        method_name = self.read()
        num_formals = self.read()
        self.imp_map[(class_name, method_name)] = []
        for i in range(int(num_formals)):
            self.imp_map[(class_name, method_name)].append(self.read())
        self.read()
        body = self.read_exp()
        self.imp_map[(class_name, method_name)].append(body)

    def get_direct_methods(self):
        self.direct_methods = {}
        for class_name in self.class_map:
            for (cls, method), imp in self.imp_map.items():
                if cls != class_name:
                    continue

                parent = self.parent_map.get(class_name)
                inherited=False
                while parent:
                    if (parent,method) in self.imp_map:
                        inherited = True
                        break
                    parent = self.parent_map.get(parent)
                if not inherited:
                    self.direct_methods[(cls,method)] = imp



    def read_parent_map(self):
        self.read()
        num_relations = self.read()
        for i in range(int(num_relations)):
            child = self.read()
            parent = self.read()
            self.parent_map[child] = parent

