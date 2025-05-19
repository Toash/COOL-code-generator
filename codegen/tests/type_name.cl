class Some_class{

};
class Another_class{

};
class Main inherits IO{
    main():Object{
        let obj:Object<-(new Object),int:Int,str:String,bool:Bool,some:Some_class <- (new Some_class),another:Another_class<-(new Another_class) in
        {
            out_string(obj.type_name());
            out_string("\n");
            out_string(int.type_name());
            out_string("\n");
            out_string(str.type_name());
            out_string("\n");
            out_string(bool.type_name());
            out_string("\n");
            out_string(some.type_name());
            out_string("\n");
            out_string(another.type_name());
            out_string("\n");
        }       
    };
};