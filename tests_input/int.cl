class Main inherits IO{
    val:Int;
    main():Object{
        {
            out_string("Enter an integer: ");
            val <- in_int(); 
            out_string("You entered ");
            out_int(val);
            out_string(".\n");
        }
    };
};