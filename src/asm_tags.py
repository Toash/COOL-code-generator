class Tags:

    def __init__(self):
        self.counter = 13

    def get(self):
        ret = self.counter
        self.counter+=1
        return ret