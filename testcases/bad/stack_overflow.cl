class Main inherits IO {
    (* too much activation records on stack *)
    main (): Object {
        main()
    };
};