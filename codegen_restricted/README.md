generate assembly instructions for certain simple cool programs
basis for full compiler

The input program will introduce only one class, Main, with only one method, main. The following AST or language elements will not appear:

attribute_*
self_dispatch — except IO (e.g., in_out, out_int)
static_dispatch
dynamic_dispatch
internal functions
while
isvoid
case
new
let_binding_init
any novel class/method — except “Main.main”
run-time errors (e.g., division by zero)
strings — programs will largely involve integers and booleans
This results in single-class, single-method Cool programs focusing on integer and boolean manipulation.

