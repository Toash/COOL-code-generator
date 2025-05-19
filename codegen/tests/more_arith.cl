class Arithmetic {

   add(a : Int, b : Int) : Int {
      a + b
   };

   negate(n : Int) : Int {
      ~n
   };

   subtract(a : Int, b : Int) : Int {
      if b < a then a - b else b - a fi
   };

   factorial(n : Int) : Int {
      (let x : Int <- 1 in
        {
         (let y : Int <- 1 in
            while y <= n loop {
               x <- x * y;
               y <- y + 1;
            } pool
         );
         x;
        }
      )
   };

   square(n : Int) : Int {
      n * n
   };

   cube(n : Int) : Int {
      n * n * n
   };

   is_multiple_of_3(n : Int) : Bool {
      (let x : Int <- if n < 0 then ~n else n fi in
         if x = 0 then true else
         if x = 1 then false else
         if x = 2 then false else
            is_multiple_of_3(x - 3)
         fi fi fi
      )
   };

   divide_by_8(n : Int) : Int {
      n / 8
   };

   mod_8(n : Int) : Int {
      n - (n / 8 * 8)
   };

   is_even(n : Int) : Bool {
      (let x : Int <- if n < 0 then ~n else n fi in
         if x = 0 then true else
         if x = 1 then false else
            is_even(x - 2)
         fi fi
      )
   };
};



class Main inherits IO {

   main(): Object {
      {
         (let a : Int <- 6, b : Int <- 3 in
            {
               (let arith : Arithmetic <- new Arithmetic in {
                  
                  out_string("a = 6, b = 3\n");

                  out_string("add(a, b) = ");
                  out_int(arith.add(a, b));
                  out_string("\n");

                  out_string("negate(a) = ");
                  out_int(arith.negate(a));
                  out_string("\n");

                  out_string("subtract(a, b) = ");
                  out_int(arith.subtract(a, b));
                  out_string("\n");

                  out_string("factorial(a) = ");
                  out_int(arith.factorial(a));
                  out_string("\n");

                  out_string("square(b) = ");
                  out_int(arith.square(b));
                  out_string("\n");

                  out_string("cube(b) = ");
                  out_int(arith.cube(b));
                  out_string("\n");

                  out_string("is_multiple_of_3(a) = ");
                  if arith.is_multiple_of_3(a) then out_string("true\n") else out_string("false\n") fi;

                  out_string("divide_by_8(a) = ");
                  out_int(arith.divide_by_8(a));
                  out_string("\n");

                  out_string("mod_8(a) = ");
                  out_int(arith.mod_8(a));
                  out_string("\n");

                  out_string("is_even(a) = ");
                  if arith.is_even(a) then out_string("true\n") else out_string("false\n") fi;

               }); -- end let arith
            }
         );
         0;
      }
   };
};
