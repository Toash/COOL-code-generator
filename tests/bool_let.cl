class Main inherits IO{
    main(): Object {
        -- bools with let 
        let x:Int <- 1, y:Int <- 2 in
        {
            if x<y then
                {
                    out_int(y);
                    out_int(x);
                }
            else
                {
                    out_int(y);
                    out_int(x);
                }
            fi;

            if x<=x then
                {
                    out_int(x);
                    out_int(x);
                }
            else
                {
                    out_int(0);
                }
            fi;

            if x=x then
                {
                    out_int(x);
                    out_int(x);
                }
            else
                {
                    out_int(0);
                }
            fi;

            if x=y then
                {
                    out_int(0);
                }
            else
                {
                    out_int(x);
                    out_int(y);
                }
            fi;
        }

    };
};