class A{

};
class Main inherits IO{
    main():Object{
        {
            let a:A in 
            if isvoid(a) then
                out_string("It is void.\n")
            else
                out_string("It is not void.\n")
            fi;

            let a:A<-(new A) in 
            if isvoid(a) then
                out_string("It is void.\n")
            else
                out_string("It is not void.\n")
            fi;
        }
    };
};