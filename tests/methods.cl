
class Main inherits IO{
    method():Object{
        out_string("calling method\n")
    };
    method2():Object{
        out_string("calling method\n")
    };
    main(): Object {
        {
            method();
            method2();
        }

    };
};
