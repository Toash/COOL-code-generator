class Parent inherits IO{
    print():Object{
        out_string("Inherited!\n")
    };   
};

class Child inherits Parent{
};


class Main{
    main(): Object {
       (new Child).print() 
    };
};
