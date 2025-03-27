from collections import namedtuple

import TacGen
import sys

# COOL represents cool assembly (stack machine instructions)
COOL_Label = namedtuple("COOL_Label","Label")

"""
STACK MACHINE CONVENTION:

"""
class CoolAsmGen:
    def __init__(self,file):
        self.file = file

        tac_file = self.file.replace(".cl-type",".cl-tac")
        self.outfile = open(tac_file,"w")

        tacGen = TacGen.TacGen(file)
        self.tac_instructions = tacGen.get_instructions()

        for instr in self.tac_instructions:
            print(instr)
            self.emit(instr)

    def comment(self,comment):
        self.outfile.write(";; "+comment)

    def emit(self,instr):
        # print(type(instr).__name__)
        match type(instr).__name__:
            case "TAC_Comment":
                self.outfile.write(";;"+instr.Comment)
            case "TAC_Label":
                self.outfile.write(instr.Label)
            case "TAC_Assign_Int":
                self.comment("new Int")
                # emit stack instructions for new int.
            case _:
                print("UNHANDLED")
                sys.exit(1)



if __name__ == "__main__":
    coolAsmGen = CoolAsmGen(sys.argv[1])