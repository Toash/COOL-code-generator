class Tags:

    def __init__(self):
        self.class_name_to_tag={}
        self.class_name_to_tag["Bool"] = 0
        self.class_name_to_tag["Int"] = 1 
        self.class_name_to_tag["String"] = 3 
        self.class_name_to_tag["IO"] = 10 
        self.class_name_to_tag["Main"] = 11 
        self.class_name_to_tag["Object"] = 12 

        self.counter = 13

    def get_dict(self):
        return self.class_name_to_tag.copy()
        
    def insert(self,class_name):
        # print(f"inserting {class_name}")
        self.class_name_to_tag[class_name] = self.counter 
        self.counter+=1
        return self.class_name_to_tag[class_name]

    def get(self,class_name):
        return self.class_name_to_tag[class_name]
        