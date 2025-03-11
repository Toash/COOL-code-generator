open Printf
(*
PA3 Checkpoint 2
generate TAC for a method body

traverse ast
we want to get all the meaningful stuff, ignore other stuff.
*)

type ast_root = 
  | AST_Variable of string
  | AST_Int of string 
  | AST_Plus of ast_root * ast_root
  | AST_Times of ast_root * ast_root
and
(* what we will output *)
tac_instr = 
| TAC_Assign_Int of string * string (* x <- int 1 *) 
| TAC_Assign_Plus of string * tac_expr * tac_expr (* x <- + 1 2 *)
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
  convert statements in ast to TAC instructions

  return list of instructions and
  return variable 
  *)
  let rec convert ast = begin
    match ast with
    | AST_Variable (v) -> [], TAC_Variable(v)
    | AST_Int (i) -> 
      let new_var = fresh_var () in
      [TAC_Assign_Int (new_var, i)], TAC_Variable(new_var)
    | AST_Plus(a1,a2) ->
      let i1, ta1 = convert a1 in
      let i2, ta2 = convert a2 in
      let new_var = fresh_var () in
      let to_output = TAC_Assign_Plus(new_var, ta1, ta2) in
      (i1 @ i2 @ [to_output]), TAC_Variable(new_var)
    | _ -> failwith "not implemented"
  
    end in

  let fname = Sys.argv.(1) in
  let fin = open_in fname in 

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
  let rec read_method_body () =
    read_exp()
  and
  read_id() = 
    let loc = input_line fin in
    let id = input_line fin in
    (loc,id)
  and
  read_formal () =
    let fname = read_id () in
    let ftype = read_id() in
    (fname, ftype)
  and read_exp () =
    let loc = read() in
    let annotated_type = read() in
    let ast_root= match read() with
    | "plus" -> 
      printf "reading plus\n";
      let exp1 = read_exp() in
      let exp2 = read_exp() in
      AST_Plus(exp1,exp2)
    | "integer" ->
      let ival=read() in 
      printf "reading integer %s\n" ival;
      AST_Int(ival)
    | "identifier" -> 
      let _,ident = read_id () in
      printf "reading identifier %s\n" ident;
      AST_Variable(ident)
    | x -> (
      printf "expression kind unhandled: %s" x;
      exit 1
      )
    in 
    ast_root
  in
  let out = "my_epic_tac" in
  let fout = open_out out in

  let rec read_method () = 
    let line = input_line fin in
    if line = "method" then 
      (* we just want the method body *)
      let (m_loc, method_name) = read_id () in
      let formals = read_list read_formal  in
      let (t_loc,t_id) = read_id () in
      fprintf fout "comment start\n";
      (* label Main_main_0 *)
      (* hard coding the class need to fix later*)
      fprintf fout "label Main_%s_0\n" method_name;
    else
      read_method ()
  in
  read_method(); 
  (* start reading the method body*)
  (* just expressions, lets go !!!!*)
  let method_body = read_method_body () in
  
  let instructions, expression = convert method_body in
  (* print expressions*)
  List.iter (fun x -> (match x 
  with
  | TAC_Assign_Int (v,i) -> 
      fprintf fout "%s <- int %s\n" v i
  | TAC_Assign_Plus (v, e1, e2) -> 
      fprintf fout "%s <- + %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)
  ) ) instructions;
  fprintf fout "return %s\n" (match expression with TAC_Variable(v) -> v); 

  close_out fout;
  
end;;
main();;


