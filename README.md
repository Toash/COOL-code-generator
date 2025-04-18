known bugs:

chaining concat segfaults (not 16 byte aligned before clib function calls), the reference   compiler does this as well :/

segfault on cells.cl

Change later:

Right now emitting all of the method implementations, from parent the children. For example out_int is being emitted for Main if it inherits it. Should just emit direct implementations.



Notes:

The way I implemented arithmetic makes it all non communative :) 
