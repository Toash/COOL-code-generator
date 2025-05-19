class A{};
class B{};
class C inherits B{};
class Main inherits IO{
    a: A <- (new A);
    b: B <- (new B);
    c: C <- (new C);
    main():Object{
        case c of 
            x: A => 0;

            -- C -> B -> Object (bad)
            -- B -> Object (good, direct parent.)
            -- we need a way to determine if a class exists as a parent generically.
            --      keep going up inheritance tree, add parents to a set.
            --      just check if a class is in this set. 
            x: Object => 0;
        esac
    };
};