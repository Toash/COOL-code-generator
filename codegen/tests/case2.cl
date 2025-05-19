class A{};
class B{};
class C{};
class D inherits C {};
class Main inherits IO{
    a: A <- (new A);
    b: B <- (new B);
    c: C <- (new C);
    d: D <- (new D);
    main():Object{
        {
            case a of
                one:A => 
                {
                    out_string("A!\n");

                case a of
                    one:A => 
                    {
                        out_string("A!\n");

                    case a of
                        one:A => 
                        {
                            out_string("A!\n");

                        };
                        two:B => out_string("B!\n");
                        three:C => out_string("C or D!\n");
                        four:D => out_string("D!\n");
                    esac;
                    };
                    two:B => out_string("B!\n");
                    three:C => out_string("C or D!\n");
                    four:D => out_string("D!\n");
                esac;
                };
                two:B => out_string("B!\n");
                three:C => out_string("C or D!\n");
                four:D => out_string("D!\n");
            esac;
        }
    };
};