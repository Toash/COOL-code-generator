class A {
};
class Main inherits IO{
    main(): Object {
        -- probably not the ultimate test but close enough
        {
            -- arithmetic
            out_string("arithmetic:\n");
            out_int(2+2);
            out_int(2-2);
            out_int(2*2);
            out_int(2/2);
            out_int(1+2-3*4/5);
            out_int((1*3)+7);
            out_int(1+(3*7));
            out_string("\n\n");

            -- control flow
            out_string("control flow:\n");
            if true then
                out_string("true!")
            else
                out_string("false")
            fi;
            out_string("\n\n");

            -- let no init
            out_string("let no init:\n");
            let x:Int,y:Int in
            {
                out_int(x);
                out_int(y);
            };
            out_string("\n\n");

            -- default
            out_string("default:\n");
            let x:A in
            out_string("we got default!");
            out_string("\n\n");

            -- bools
            out_string("bools:\n");
            let x:Int <- 1, y:Int <- 2 in
            {
                if x<y then
                    {
                        out_int(y);
                        out_string(" is greater than ");
                        out_int(x);
                        out_string("\n");
                    }
                else
                    {
                        out_int(y);
                        out_string(" is less than or equal to  ");
                        out_int(x);
                        out_string("\n");
                    }
                fi;

                if x<=x then
                    {
                        out_int(x);
                        out_string(" is greater than or equal to ");
                        out_int(x);
                        out_string("\n");
                    }
                else
                    {
                        out_string("this makes no sense somethign went wrong");
                        out_string("\n");
                    }
                fi;

                if x=x then
                    {
                        out_int(x);
                        out_string(" is equal to ");
                        out_int(x);
                        out_string("\n");
                    }
                else
                    {
                        out_string("this makes no sense somethign went wrong");
                        out_string("\n");
                    }
                fi;

                if x=y then
                    {
                        out_string("this makes no sense somethign went wrong");
                        out_string("\n");
                    }
                else
                    {
                        out_int(x);
                        out_string(" is not equal to ");
                        out_int(y);
                        out_string("\n");
                    }
                fi;
            };
            out_string("\n\n");

            -- assignment
            out_string("assignment:\n");
            let x:Int <- 1 in
            {
                x<-1337;
                out_int(x);
            };
            out_string("\n\n");
        }
    };
};