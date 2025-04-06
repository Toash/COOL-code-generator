class Main inherits IO{
    main(): Object {
        -- assignment
        let x:Int <- 1 in
        {
            x<-1337;
            out_int(x);
            x<-420;
            out_int(x);
        }
    };
};