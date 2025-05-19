class Main inherits IO{

   main():Object{
      let i : Int <- 0, j:Int<-0, p:Bool<-true in 
      while i<20 loop
         {
            while j<i loop
            {
               if p  then
                  out_string("o")
               else
                  out_string("x")
               fi;
               j <- j+1;
            }
            pool;
            out_string("\n");
            i <- i+1;
            j<-0;
            p <- not p;
         }
      pool
   };
};