# Restricted x86 generation
generate assembly instructions for certain simple cool programs
basis for full compiler

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
