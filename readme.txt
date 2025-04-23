Optimizations:
Constant folding, computing constant expressions during compilation instead of emitting code that does it.
Right now this is only doing for constants, I could extend it to work with Plus, Minus, Times, Divide, Negate
and Identifiers. This would presumable require keeping track of the values of identifiers in a similar manner
as the symbol stack


TODO:
Use stack temporaries instead of pushing temporaries on the stack.
remove suspicious code from pa3
Register allocation
Dead code elimination


PA3:
My compiler just uses cl-asm as an ir. I skipped TAC because it wasn't fully working 
and I just wanted to start printing 1 to the screen quickly.

Some quirks of cl-asm: 
to deallocate passed variables, it adds to rsp inside the function call itself. 
this made it particularly tricky to follow, because as parameters were 
being pushed, you had to be implicitly aware that deallocating these parameters were happening 
elsewhere. Instead in x86, I could not do this since the return address was in the way
so i did it immediately after the call which made it way more readable. 

it also adds to rsp to deallocate the space for temporaries but in x86 we can just set rsp to rbp.

Theres probably more to mention, but to handle all of this I just created a bool in the cl-asm generator,
which would generate x86 equivalents instead.

Some benefits of using cl-asm were that if the generated assembly was segfaulting, 
I could quickly run the .cl-asm version, and if it worked, most of the time meant that  
there were issues with 16 byte alignment, or i didnt implement the built ins correctly

Granted, in the end to handle this I just copied the updated reference compiler, where it dropped the 
last 4 bits with andq. along with the built ins.

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

For new expressions, it was fairly straightforward where I just called
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
was zero, but was falsy assuming that it was always an Integer and not a Plus, Minus, etc...
i ended up just cgenning and branching if non zero to okay branch.

test2 checks for scoping, in particular when we go into a let expression body, the bindings
are defined and shadow over any ones that were declared before it, and when exiting the 
let expression, previous variables should now be in scope again.

test3 checks for subtypes in case expressions. Specifically, if i have class A that inhertis class B that 
inherits Object, If the expression is of type A and all i have is Object in the branches, it should match that 
branch. Successfully running this case meant that if there isnt a direct match in the branch for the expression,
then i had to check all of the expressions' parents to see if there was a match.
Additionality, it also ensures that i am getting the most recent parent in the inheritance tree in the second block of 
the test case.

test4 may seem trivial but my compiler kept segfaulting on this, i couldn't just rely on ensuring temporaries are odd,
For this to work i had to drop the lower 4 bits before calling clib functions just like the updated reference
compiler does. This test case also led me down a long tangent of trying to dynamically calculate the stack temporaries 
to try and have rsp aligned which was good i guess.