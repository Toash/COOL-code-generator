# Restricted x86 generation
generate assembly instructions for certain simple cool programs
basis for full compiler

## The plan:
**Annotated-AST -> TAC -> Cool-ASM -> x86 ASM**


Directions:
<br>
The input program will introduce only one class, Main, with only one method, main. The following AST or language elements will not appear:

attribute_*
<br>
self_dispatch — except IO (e.g., in_out, out_int)
<br>
static_dispatch
<br>
dynamic_dispatch
<br>
internal functions
<br>
while
<br>
isvoid
<br>
case
<br>
new
<br>
let_binding_init
<br>
any novel class/method — except “Main.main”
<br>
run-time errors (e.g., division by zero)
<br>
strings — programs will largely involve integers and booleans
<br>
This results in single-class, single-method Cool programs focusing on integer and boolean manipulation.
<br>



**~~Rewriting TAC  (need to consider more stuff i guess? right now its just doing it for main)~~**

~~<br> nevermind, i will just translate directly to x86, the deadline is in 2 days and i literally dont have 
time left to do that. my compiler will probably be slow but it is what it is at this point~~ 

nevermind again, i may be able to do it (the output for this module only considers a subset of cool)