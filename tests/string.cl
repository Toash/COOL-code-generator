class Main inherits IO{
    main():Object{
        {
            out_string("Hello world!\n");
            out_string("Hello world!\n");
            let x:String <- "Hello", y:String <- "Goodbye" in 
            {
                out_int(x.length());
                out_string("\n");
                out_string(x.concat(y));
                out_string("\n");
            };
        }
    };
};