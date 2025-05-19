Optimizations:
Constant folding, computing constant expressions during compilation instead of emitting code that does it.
Right now this is only doing for constants, I could extend it to work with Identifiers. 
This would presumably require keeping track of the values of identifiers in a similar manner
as the symbol stack