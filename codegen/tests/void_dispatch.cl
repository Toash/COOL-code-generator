class A{
    a:Int;
};
class IntWrapper {
    myInt: Int <- 0;

    set(newInt : Int) : Int { myInt <- newInt };
    get() :Int {myInt};
    incr() : Int {myInt <- myInt + 1};
};
class Main{
    x:IntWrapper;
    main() : Object {
        x.abort()
    };
};