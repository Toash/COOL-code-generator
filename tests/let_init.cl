class Main inherits IO{
    main(): Object {
        -- let init
        {
            let x:Int<-123,y:Int<-456 in
            {
                out_int(x);
                out_int(y);
            };
            let x:Int <- 1 in
            let x:Int <- 2 in
            let x:Int <- 3 in
            let x:Int <- 4 in
            out_int(x);

            -- nesting shenanigans
            let x:Int <- 5 in
            {
                out_int(x);
                let x:Int <- 6 in
                {
                    out_int(x);
                    let x:Int <- 7 in
                    {
                        out_int(x);
                    };
                    out_int(x);
                };
                out_int(x);
            };
        }
    };
};