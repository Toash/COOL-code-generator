known bugs:

chaining concat segfaults

negate not working correctly 



Change later:

Not computing temporaries yet. just using a constant :)

Right now emitting all of the method implementations, from parent the children. For example out_int is being emitted for Main if it inherits it. Should just emit direct implementations.