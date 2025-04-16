class A{};
class Main inherits  IO{
   a:A <- (new A);
   main():Object{
      case a of 
      thingy:A => out_string(thingy.type_name());
      esac
   };
};