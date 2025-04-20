class Main{

    x:Int<-100;

    assert(what_we_have:Int, what_we_want:Int) : Object{
        if what_we_have = what_we_want then
            {
                (new IO).out_string("good");
                (new IO).out_string("\n");
            }
        else
            {
                (new IO).out_string("bad");
                (new IO).out_string("\n");
            }
        fi
    };

    main(): Object {
        {
            -- Shadowing
            -- push new symbol_table
            let x:Int<-1 in 
            {
                self.assert(x,1);
                x <- 2;
                let x:Int<-3 in
                {
                    self.assert(x,3);
                };
                self.assert(x,2);
            };

            self.assert(x,100);
        }
    };
};