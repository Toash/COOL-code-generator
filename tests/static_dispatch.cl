class Foo inherits IO{
    print() : Object{
       out_string("Foo!\n") 
    };
};

class Bazz inherits Foo{
    print() : Object{
       out_string("Bazz!\n") 
    };
};

class Main{
    main(): Object{

        let foo : Bazz <- (new Bazz) in 
        foo@Foo.print()
    };
};