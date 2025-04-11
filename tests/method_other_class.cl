class Printer inherits IO{
    print_hello():Object{
        out_string("Hello!\n")
    };
};

class Main{
    main(): Object {
        (new Printer).print_hello()
    };
};
