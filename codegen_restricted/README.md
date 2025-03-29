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

## The plan
**Annotated-AST -> TAC -> Cool-ASM -> x86 ASM**


## Notes
TAC to CoolASM should hopefully generally be a direct translation.

COOL asm is a stack-based execution model

(push,pop,add,sub,etc)

### comparison:
- eq
- lt
- le
- (these push true / false on the stack)

### branching:
- bt (branch if top of stack is true)
- bf (branch if false)
- jmp (unconditional jump)



### examples:
1. push 1       ; push constant
2. push 2       ; push another constant
3. lt           ; push (1 < 2), which is true
4. bt label     ; branch to label if true 
