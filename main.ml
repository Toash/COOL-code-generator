open Printf
(*
PA3 Checkpoint 2
generate TAC for cool programs 

traverse ast
we want to get all the meaningful stuff, ignore other stuff.
*)

type cool_program = cool_class list
and loc = string 
and id = loc * string 

and cool_type = id 

and cool_class = id * (id option) * feature list

and feature =
  | Attribute of id * cool_type * (exp option) 
  | Method of id * (formal list) * cool_type * exp
and formal = id * cool_type 

and binding = id * cool_type * (exp option) 
and case_element = id * cool_type * exp 
and exp = 
  | AST_Self_Dispatch of id * (exp list)

  | AST_Block of exp list
 
  | AST_New of cool_type
  | AST_Isvoid of exp

  | AST_Plus of exp * exp
  | AST_Minus of exp * exp
  | AST_Times of exp * exp
  | AST_Divide of exp * exp

  | AST_Not of exp
  | AST_Negate of exp

  | AST_Int of string 
  | AST_Variable of string
and
(* what we will output *)
tac_instr = 
| TAC_Assign_Call of  string * string * tac_expr(* t$0 <- call out_int t$1 *)
| TAC_Assign_Int of string * string (* x <- int 1 *) 
| TAC_Assign_Plus of string * tac_expr * tac_expr (* x <- + 1 2 *)
| TAC_Assign_Minus of string * tac_expr * tac_expr (* x <- - 1 2 *)
| TAC_Assign_Times of string * tac_expr * tac_expr (* x <- * 1 2 *)
| TAC_Assign_Divide of string * tac_expr * tac_expr (* x <- / 1 2 *)
and
tac_expr =
| TAC_Variable of string

let counter = ref 0 
let main () = begin
  (* 
  when recursive descenting and finding variable,
  make a fresh new variable
  *)
  let rec fresh_var = 
    fun () -> 
      let v = !counter in
      counter := !counter + 1;
      "t$" ^ (string_of_int v)
  in

  (*
  convert expressions in ast to TAC instructions

  return list of instructions and
  the returned variable 
  *)
  let rec convert ast = begin
    match ast with
    | AST_Block(v) -> 
      (* 
      accumualte instructions for each instruction in the block,
       return last expression
        *)
      let rec convert_block lst =
        match lst with
        | [] -> failwith "empty block"
        | [x] -> convert x
        | hd::tl -> 
          let i1, t1 = convert hd in
          let i2, t2 = convert_block tl in
          i1@i2, t2
      in
      convert_block v
    | AST_Variable (v) -> [], TAC_Variable(v)
    



    | AST_Self_Dispatch ((_,mname), exps) -> 
      let instr, return_exp= List.fold_left (fun (acc_inst, acc_exp) exp -> 
        (* extract instructions and return value *)
        let inst, expr = convert exp in
        (acc_inst @ inst, acc_exp @ [expr])
      ) ([], []) exps in
      (*hmm*)
      let last_return_exp= List.hd (List.rev return_exp) in
      let new_var = fresh_var () in
      (* t0 <- call out_int t1  (just have to match t1) *)
      let to_output = TAC_Assign_Call(new_var,mname,last_return_exp) in
      (instr@ [to_output]), TAC_Variable(new_var)
    



    | AST_Int (v) -> 
      let new_var = fresh_var () in
      [TAC_Assign_Int (new_var, v)], TAC_Variable(new_var)
    | AST_Plus(a1,a2) ->
      (*
      to output correct register numbers, the var for the instructions before calling convert
      *)
      let i1, ta1 = convert a1 in
      let i2, ta2 = convert a2 in
      let new_var = fresh_var () in
      let to_output = TAC_Assign_Plus(new_var, ta1, ta2) in
      (i1@i2@[to_output]), TAC_Variable(new_var)
    | AST_Minus(a1,a2) ->
      let i1, ta1 = convert a1 in
      let i2, ta2 = convert a2 in
      let new_var = fresh_var () in
      let to_output = TAC_Assign_Minus(new_var, ta1, ta2) in
      (i1@i2@[to_output]), TAC_Variable(new_var)
    | AST_Times(a1,a2) ->
      let i1, ta1 = convert a1 in
      let i2, ta2 = convert a2 in
      let new_var = fresh_var () in
      let to_output = TAC_Assign_Times(new_var, ta1, ta2) in
      (i1@i2@[to_output]), TAC_Variable(new_var)
    | AST_Divide(a1,a2) ->
      let i1, ta1 = convert a1 in
      let i2, ta2 = convert a2 in
      let new_var = fresh_var () in
      let to_output = TAC_Assign_Divide(new_var, ta1, ta2) in
      (i1@i2@[to_output]), TAC_Variable(new_var)
    | _ -> failwith "not implemented"
  
    end in

  let fname = Sys.argv.(1) in
  let fin = open_in fname in 

  let out = (Filename.chop_extension fname) ^ ".cl-tac" in
  let fout = open_out out in

  let read () = 
    input_line fin 
  in
  let rec range k = 
    if k <= 0 then []
    else k ::(range (k-1))
  in 
  let read_list worker = (* call worker k times *)  
    let k = int_of_string(read()) in
    let lst = range k in
    List.map(fun _ -> worker()) lst
  in
  (* ugly *)
  let read_list2 worker = (* call worker k times *)  
    let k = int_of_string(read()) in
    let lst = range (k*2) in
    List.map(fun _ -> worker()) lst
  in
  (* let rec read_method_body () =
    read_exp() *)
  let rec read_aast() = 
    try
      let line = input_line fin in
      if line = "parent_map" then begin
        (* read the parent map away *)
        read_list2 read;

        (* read classes until we find a method *)
        read_list(read_cool_class)
      end
      else
        read_aast()
    with Not_found -> 
         printf "error: did not find implementation\n"; 
         exit 1
  and 
  read_id() = 
    let loc = input_line fin in
    let id = input_line fin in
    (loc,id)
  and read_cool_class () =
    let cname = read_id() in 
    let inherits = match read() with
    | "no_inherits" -> None
    | "inherits" ->
      let super = read_id () in
      Some(super)
    | x -> failwith ("error reading class:" ^ x)
    in
    let features = read_list read_feature in
    (cname, inherits, features)
  and read_feature () = 
    let feature_type = read() in
    match feature_type with
    | "attribute_no_init" ->
      let fname = read_id() in
      let ftype = read_id() in
      Attribute(fname, ftype, None) 
    | "attribute_init" ->
      let fname = read_id() in
      let ftype = read_id() in
      let finit = read_exp() in
      Attribute(fname, ftype, (Some finit))
    | "method" ->
      let mname = read_id() in
      let formals = read_list read_formal in
      let mtype = read_id() in
      let mbody = read_exp() in 
      Method(mname, formals, mtype, mbody)
    | x -> failwith ("error reading feature:" ^ x)
    and
  read_formal () =
    let fname = read_id () in
    let ftype = read_id() in
    (fname, ftype)
  and read_exp () =
    let loc = read() in
    let annotated_type = read() in
    let ast_root= match read() with
    | "self_dispatch" ->
      let id = read_id() in
      let exps = read_list read_exp in
      AST_Self_Dispatch(id, exps)
    | "plus" -> 
      let exp1 = read_exp() in
      let exp2 = read_exp() in
      AST_Plus(exp1,exp2)
    | "minus" -> 
      let exp1 = read_exp() in
      let exp2 = read_exp() in
      AST_Minus(exp1,exp2)
    | "times" -> 
      let exp1 = read_exp() in
      let exp2 = read_exp() in
      AST_Times(exp1,exp2)
    | "divide" -> 
      let exp1 = read_exp() in
      let exp2 = read_exp() in
      AST_Divide(exp1,exp2)
    | "integer" ->
      let ival=read() in 
      AST_Int(ival)
    | "identifier" -> 
      let _,ident = read_id () in
      AST_Variable(ident)
    | "block" ->
      AST_Block(read_list read_exp)
    | x -> (
      printf "expression kind unhandled: %s" x;
      exit 1
      )
    in 
    ast_root
  in
  let rec print_tac instructions expression = 
    (* let instructions, expression = convert method_body in *)
    (* print expressions*)
    List.iter (fun x -> (match x 
    with
   | TAC_Assign_Call (var, mname, e) -> 
        fprintf fout "%s <- call %s %s\n" var mname (match e with TAC_Variable(v) -> v)  
    | TAC_Assign_Int (v,i) -> 
        fprintf fout "%s <- int %s\n" v i
    | TAC_Assign_Plus (v, e1, e2) -> 
        fprintf fout "%s <- + %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)
    | TAC_Assign_Minus(v, e1, e2) -> 
        fprintf fout "%s <- - %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)
    | TAC_Assign_Times(v, e1, e2) -> 
        fprintf fout "%s <- * %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)
    | TAC_Assign_Divide(v, e1, e2) -> 
        fprintf fout "%s <- / %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)
    ) ) instructions;
    fprintf fout "return %s\n" (match expression with TAC_Variable(v) -> v); 
  in
  (* go through ast and print TAC *)
  let ast = read_aast() in
  fprintf fout "comment start\n";
  List.iter (fun x -> (match x
  with
  | ((_,cname), _ , features) -> 
      List.iter(fun x -> (match x
      with
      | Attribute(fname, ftype, Some(finit)) -> 
        (* fprintf fout "attribute, need to handle later\n"; *)
        ()
      | Method((_,mname), formals, mtype, mbody) -> 
        fprintf fout "label %s_%s_0\n" cname mname;
        (* convert method body to TAC *)
        let _ = counter := 0 in
        let instructions, expression = convert mbody in
        print_tac instructions expression;
      | _ -> ()
      ) ) features; 
      
  ) ) ast;

  (* printf "%s\n" out; *)

  close_out fout;
  
end;;
main();;


