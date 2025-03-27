class Main inherits IO{
    main(): Object {
        -- bools
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
        }

    };
};