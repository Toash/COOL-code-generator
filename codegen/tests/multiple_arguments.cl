class A inherits IO{
    print(a:Int,b:Int,c:Int) : Object {
        {
            out_int(a);
            out_int(b);
            out_int(c);
        }
    };
};

class Main inherits IO{

    a:A <- new A;
    one:Int<-1;
    two:Int<-2;
    three:Int<-3;
    main():Object{
        a.print(one,two,three)
    };

};