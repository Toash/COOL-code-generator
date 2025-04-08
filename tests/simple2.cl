class Main inherits IO{
    main(): Object {
        {
            -- arithmetic
            -- out_int(2+2);
            -- out_int(2-2);
            -- out_int(2*2);
            -- out_int(2/2);
            -- out_int(1+2-3*4/5);
            -- out_int((1*3)+7);
            -- out_int(1+(3*7));

            -- -- control flow
            -- if true then
            --     out_int(1)
            -- else
            --     out_int(0)
            -- fi;

            -- let no init
            let x:Int,y:Int in
            {
                out_int(x);
                out_int(y);
            };

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
            };

            -- assignment
            let x:Int <- 1 in
            {
                x<-1337;
                out_int(x);
            };
        }
    };
};
