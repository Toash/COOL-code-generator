class StringCompare inherits IO{
    compare(a:String, b:String):Object{
        if a = b then
            {
                out_string(a);
                out_string(" is equal to ");
                out_string(b);
                out_string(".\n");
            }
        else
            if a < b then
                {
                    out_string(a);
                    out_string(" is less than ");
                    out_string(b);
                    out_string(".\n");
                }
            else
                {
                    out_string(a);
                    out_string(" is greater than ");
                    out_string(b);
                    out_string(".\n");
                }
            fi
        fi
    };
};

class Main inherits IO{
    string:StringCompare <- (new StringCompare);
    main():Object{
        {
            string.compare("abc","ABC");   
            string.compare("bbc","bbd");   
            string.compare("abc","abc");   
            string.compare("bbd","abc");   
            string.compare("1","10");   
            string.compare("10","1");   
            string.compare("10","10");   
        }
    };
};