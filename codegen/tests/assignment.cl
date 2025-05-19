class Stuff_doer inherits IO{
    a:Int<-1;
    change():Object{
        a<-a+3
    };
    print():Object{
       out_int(a) 
    };
};

class Main inherits IO{
    main(): Object {
        {
            -- assignment
            let x:Int <- 1 in
            {
                x<-1337;
                out_int(x);
                x<-420;
                out_int(x);
            };
            let doer1:Stuff_doer<-(new Stuff_doer), doer2:Stuff_doer,doer3:Stuff_doer in
            {
                doer2<-doer1;
                doer2.change();
                doer1.print();
                doer2.print();
                
            };
        }
    };
};