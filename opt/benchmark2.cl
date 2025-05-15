-- test loop unrolling
class Main inherits IO {
    sum(n: Int): Int {
        let i: Int <- 0, s: Int <- 0 in {
            while i < n loop {
                s <- s + 1;
                i <- i + 1;
            } pool;
            s;
        }
    };

    main(): Object {
        out_int(sum(1000000))  
    };
};
