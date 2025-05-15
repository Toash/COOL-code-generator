My compiler does not do dead code elimination or any dataflow analysis my bad.

The main optimization it does is constant folding, (eval_constant_expr). Its just matching 
through the possible types of arithmetic and doing them in compile time. although it does not work with 
variables which would required some dataflow analysis. 

benchmark1 tests out constant folding without variables

benchmark2 tests out loop unrolling that I didn't implement, where unrolling would suppposedly offer 
more operations per control overhead.