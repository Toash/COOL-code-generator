class Main inherits IO{
    main(): Object {
        -- bools
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
                0
            fi;

            if x=x then
                {
                    out_int(x);
                    out_int(x);
                }
            else
              0
            fi;

            if x=y then
              0
            else
                {
                    out_int(x);
                    out_int(y);
                }
            fi;
        }
    };
};
