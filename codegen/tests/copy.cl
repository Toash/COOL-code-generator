class Stuff_doer inherits IO{
    a:Int<-1;
    b:Int<-1;
    c:Int<-1;
    change():Object{
        a<-a+3
    };
    print():Object{
       out_int(a) 
    };
};
class Main inherits IO{
    main():Object{
        let doer1:Stuff_doer<-(new Stuff_doer), doer2:Stuff_doer,doer3:Stuff_doer in
        {
            doer2<-doer1;
            doer2.change();
            doer1.print();
            doer2.print();

            out_string("\n");
            
            doer3<-doer2.copy();
            doer3.change();
            doer2.print();
            doer3.print();

            out_string("\n");
            
        }
    };
};
