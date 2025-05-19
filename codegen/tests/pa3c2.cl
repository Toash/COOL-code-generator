class Main inherits IO {
    compare(a:Int, b:Int):Object{
        if a=b then
            out_string("a equal to than b\n")        
        else
            if a<b then
                out_string("a less than b\n")        
            else
                    out_string("a greater than b\n")        
            fi
        fi
    };
    main(): Object {
        {
            -- Arithmetic basics
            out_int(1 + 2);           
            out_int(10 - 4);          
            out_int(3 * 4);           
            out_int(20 / 5);          

            -- Unary negation and nested negation
            out_int(~1);              
            out_int(~~2);             
            out_int(~~~3);            

            -- Operator precedence and grouping
            out_int(1 + 2 * 3);       
            out_int((1 + 2) * 3);     
            out_int(10 / 2 + 3);      
            out_int(10 / (2 + 3));    
            out_int(1 + ~2 - 3 * ~4 / 5); 

            -- Let bindings and assignment
            let x : Int <- 5, y : Int <- 2 in {
                out_int(x);           
                out_int(y);           
                x <- x + y;
                out_int(x);           
                y <- ~y;
                out_int(y);           
                x <- x * y;
                out_int(x); 
            };

            -- Comparisons and boolean logic
            self.compare(1,2);
            self.compare(2,1);
            self.compare(3,3);
            self.compare(3,4);

            -- Deeply nested expression
            out_int((((1 + 2) * (3 + 4)) / 5) - 1);
            out_int(
                1 + ~(2 * (3 + ~(4 - (5 * (~(6 + 1)))) / (8 - 3)))
            );
            -- Bit more negation edge cases
            out_int(~(~(~(~0))));    

            -- Variable reuse
            let z : Int <- 0 in {
                z <- 1;
                out_int(z);
                z <- z + 1;
                out_int(z); 
                z <- ~z;
                out_int(z); 
            };
            out_string("\n");
        }
    };
};
