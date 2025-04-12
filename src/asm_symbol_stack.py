from asm_locations import *

class SymbolStack:
    def __init__(self):
        self.symbol_stack = [{}]

    # call when entering new expression
    def push_scope(self):
        self.symbol_stack.append({})

    def pop_scope(self):
        self.symbol_stack.pop()

    def insert_symbol(self, symbol:str, loc:Register | Offset):
        self.symbol_stack[-1][symbol] = loc

    def lookup_symbol(self, symbol:str):
        for scope in reversed(self.symbol_stack):
            if symbol in scope:
                return scope[symbol]
        return None