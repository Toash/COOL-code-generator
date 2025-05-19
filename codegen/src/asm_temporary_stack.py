class TemporaryStack:
    def __init__(self):
        # each element contains index for temporary.
        self.stack = [] 

    def push_scope(self):
        self.stack.append(0)

    def pop_scope(self):
        # print(self.stack)
        self.stack.pop()

    # use up a slot in the temporaries
    def allocate_temp(self) -> int:
        retval = self.stack[-1]
        self.stack[-1] -= 1
        return retval 

    def free_temp(self):
        self.stack[-1] += 1

