
class Main inherits IO{
    a:Int <- 1;
    b:Int <- 2;
    c:Int <- 3;
    main(): Object {
        {
            out_int(a);
            out_int(b);
            out_int(c);
            b <- 4; 
            out_int(b);
        }
    };
};
