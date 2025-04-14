class StringToLabel:
    def __init__(self,class_map):
        self.string_to_label = {}
        self.string_to_label_counter = 0

    def get_dict_sorted(self):
        return dict(sorted(self.string_to_label.items()))

    def get(self,val):
        return self.string_to_label[val]

    def insert(self,string):
        if string in self.string_to_label:
            return
        else:
            self.string_to_label_counter += 1
            self.string_to_label[string] = f"string{self.string_to_label_counter}"

