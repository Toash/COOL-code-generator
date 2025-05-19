class A{};
class B{};
class Main inherits IO{
    a: A <- (new A);
    b: B <- (new B);
    main():Object{
        case a of 
        thing1: A => out_string(thing1.type_name());
        thing2: B => 0;
        esac
    };
};