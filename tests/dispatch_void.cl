class A inherits IO {
    do_stuff():Object{
        out_string("Stuff has been done.\n")
    }; 
};

class Main{
    main():Object{
        {
            (new A).do_stuff();

            -- danger
            let stuff_doer : A in
            stuff_doer.do_stuff();
        }
    };
};
