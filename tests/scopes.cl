class Main inherits IO{
    main(): Object {
        {
            -- variable scopes
            let x:Int <- 111 in
            {
                let x:Int<-333 in 
                out_int(x);
                out_int(x);
            };
            let x:Int <- 222 in
            {
                out_int(x);
            };
        }
    };
};
