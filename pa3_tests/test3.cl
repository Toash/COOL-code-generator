
class A{};
class B{};
class C inherits B{};
class Main inherits IO{
    a: A <- (new A);
    b: B <- (new B);
    c: C <- (new C);
    main():Object{
        {
            case c of 
                x: A => 0;

                -- C -> B -> Object (bad)
                -- B -> Object (good, direct parent.)
                -- we need a way to determine if a class exists as a parent generically.
                --      keep going up inheritance tree, add parents to a list (ordered).
                x: Object => out_string("=)\n");
            esac;
            case c of 
                x: A => 0;
                -- Object is not most recent parent!
                x: Object => out_string("=(\n");

                -- B is most recent.
                x: B => out_string("=)\n");

            esac;
        }
    };
};