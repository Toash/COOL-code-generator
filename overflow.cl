-- we could do 64 bit arithmetic but the reference compiler does 32 bit
--  so we should target that. 

class Main inherits IO{
  main():Object {
    {
      out_int(2000000000 + 2000000000);
      out_string("\n");
      out_int(~2000000000 - 2000000000);
      out_string("\n");
      out_int(2000000000 * 2000000000);
      out_string("\n");

      out_int(2000000000 * 200 );
      out_string("\n");
      out_int((2000000000 * 200) / 10);
      out_string("\n");
    }
  };
};