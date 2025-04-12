"""
Gives indicies more methods in the vtable for each class :)
"""
class MethodIndex:
    def __init__(self):
        # store index with <type, mname>
        # to lookup when emitting code for dispatch
        self.vtable_method_indexes : dict[(str,str):int] = {}
        self.index = 0

    def insert(self,class_name, method_name):
        self.vtable_method_indexes[(class_name,method_name)] = self.index 
        self.index += 1;
        pass

    def lookup(self,class_name,method_name):
        return self.vtable_method_indexes[(class_name,method_name)]

    def reset_index(self):
        self.index = 0;