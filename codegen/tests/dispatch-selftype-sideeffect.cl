(* aliasing is when two names refer to the same object in memory *)
class IntWrapper {
    myInt: Int <- 0;

    set(newInt : Int) : Int { myInt <- newInt };
    get() :Int {myInt};
    incr() : SELF_TYPE {{myInt <- myInt + 1; self;}};
};
class IntWrapperChild inherits IntWrapper {

};
(* ways to make new names for the same object : 
    (1) formal paramters + dispatch
    (2) let
*)

class Main inherits IO {
    a : IntWrapper <- new IntWrapperChild ; 
    b : IntWrapper <- new IntWrapperChild ; 
    c : IntWrapper <- new IntWrapperChild ; 

    process(x :IntWrapper, y:IntWrapper) : Object {
        {
        out_int(x.get());
        out_string(" ");
        out_int(y.get());
        out_string(" ");
        x.incr();
        out_int(x.get());
        out_string(" ");
        out_int(y.get());
        out_string("\n");
        }
    };

    main (): Object {
        {
            a.set(11);
            b.set(33);
            c.set(55);
            process(a.incr(),b.incr());
            process(c.incr(),c.incr());
        }
    };
};