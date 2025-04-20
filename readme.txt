My compiler just uses cl-asm as an ir. I skipped TAC because it wasn't fully working 
and I wanted to start printing 1 to the screen quickly.

Some benefits of using cl-asm were that if the generated assembly was segfaulting, 
I could quickly run the .cl-asm version, and if it worked, most of the time meant that  
there were issues with 16 byte alignment.

Granted, in the end to handle this I just copied the updated reference compiler, where it dropped the 
last 16 bits with andq 

another benefit was that it abstracted away the clib functions (just have to do syscall) 
which really wasn't that benefitial because i could have just copied the reference compiler
built-ins from the start, but it is worth mentioning i guess.

Another benefit is that cl-asm allows you to print out the contents of the registers in the 
cl-asm itself. This meant that I could make a debug mode for my compiler, where it would 
debug the stack pointer on function entry and exit to quickly ensure that it was the same.

To handle stack temporaries, I recursively go through the ast, and the following would increase 
the number of temporaries:
1. let bindings (1 for each binding)
2. case expression  (1 for the expression itself)

For new expressions, it was fairly straightforward where I just callled
the constructor that corresponded to the type. to handle SELF_TYPE, I did the 
same thing from the semantic anaylzer where I had a variable that has the current class
and I updated this variable when emitting assembly for the constructors and methods.

For dispatch, I created a helper, and the only thing that was different between
Dynamic, Static, and Self dispatch was whether or not i passed in 
Exp or Type in the parameters.

If I didnt pass in Exp, it was self so i didnt generate an expression and instead just 
loaded the vtable and pushed r0 (self register) on the stack.

If i passed in Exp, and no Type, I would just generate the receiver ,load the vtable
and push accumulator on the stack

If i passed in Exp and Type, then instead of loading the vtable using the index, 
I just loaded the vtable directly from the Type itself.


test cases:

test1 one just does a lot of arithmetic,
this test case caught a lot of bugs, in particular, i was not updating the Integer
object correctly when negating, and when dividing by zero, I was checking if the denominator
was zero, but was falsy assuming that it was always an Integer

test2 checks for scoping, in particular when we go into a let expression body, the bindings
are defined and shadow over any ones that were declared before it, and when exiting the 
let expression, previous variables should be in scope.
