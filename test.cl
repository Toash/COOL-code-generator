class Main inherits IO{
    main():Object{
        let string:String <- "Hello\n" in 
        {
            out_string(string);
            out_int(string.length());
            out_string("\n");
        }

    };
};