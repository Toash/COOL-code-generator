# Restricted x86 generation
generate assembly instructions for certain simple cool programs
basis for full compiler

## data structures:
**class map:** attributes, and types and initializations of a class

**imp map:** methods of a class

- In general, for a class X and a method m,
implementation(X, m) = (x1, x2, . . . , xn, ebody), (formal parameters and expression body)

**parent map:** internally used to represent inheritance relationships

OBJECT LAYOUT:
1. tag
2. size (in bytes, Cool-asm just uses 1-offset)
3. vtable( method pointers)
4. After vtable, list attributes.


We use the imp map, to loop through the methods for a given object, from here we can print the 
label for the method, and define the method body.

