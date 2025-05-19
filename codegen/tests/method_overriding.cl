class Foo inherits IO{
    print():Object{
        out_string("Foo!\n")
    };   
};

class Bazz inherits Foo{
    print():Object{
        out_string("Bazz!\n")
    };   
};

class Foo2 inherits Foo{

};


class Main{
    main(): Object {
        {
            (new Foo).print(); 
            (new Bazz).print(); 
            (new Foo2).print(); 
        }
    };
};
