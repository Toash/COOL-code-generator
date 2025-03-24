open Printf
(* 
PA3c3
Walk through tac instructions and generate assembly code.
do not have to handle:

attribute_*
self_dispatch — except IO (e.g., in_out, out_int)
static_dispatch
dynamic_dispatch
internal functions
while
isvoid
case
new
let_binding_init
any novel class/method — except “Main.main”
run-time errors (e.g., division by zero)
strings — programs will largely involve integers and booleans
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


(* AST NODES *)
and exp = 
  
  | AST_Assign of id * exp (* let i : Int <- 0 *)

  | AST_Self_Dispatch of id * (exp list)
  | AST_Dynamic_Dispatch of id * (exp list) 
  (*
  1. guard
  2. then
  3. else 
  *)
  | AST_If of exp * exp * exp 
  | AST_While of exp * exp (* while (guard) { body } *)
  | AST_Block of exp list
 
  | AST_New of string (* dont need to store the line number *)
  | AST_Isvoid of exp

  | AST_Plus of exp * exp
  | AST_Minus of exp * exp
  | AST_Times of exp * exp
  | AST_Divide of exp * exp

  | AST_LessThan of exp * exp
  | AST_LessThanEqual of exp * exp
  | AST_Equal of exp * exp

  | AST_Not of exp
  | AST_Negate of exp

  | AST_Int of string 
  | AST_String of string

  | AST_Variable of string
  | AST_Default of string (* is this actually needed? *)

  | AST_Bool of string

  | AST_Let of binding list * exp

and



(* what we will output (as TAC) *)
(* TAC INSTRUCTIONS *)
tac_instr = 
| TAC_Assign_Default of tac_expr * string (* t$0 <- default Int *)
| TAC_Assign of tac_expr * tac_expr (* t$0 <- t$1 *)
| TAC_Assign_Call of  string * string * tac_expr(* t$0 <- call out_int t$1 *)

| TAC_Assign_New of string * string (* t$0 <- new String *)
| TAC_Assign_IsVoid of string * tac_expr (* t$0 <- isvoid t$1 *)

| TAC_Assign_Plus of string * tac_expr * tac_expr (* x <- + 1 2 *)
| TAC_Assign_Minus of string * tac_expr * tac_expr (* x <- - 1 2 *)
| TAC_Assign_Times of string * tac_expr * tac_expr (* x <- * 1 2 *)
| TAC_Assign_Divide of string * tac_expr * tac_expr (* x <- / 1 2 *)

| TAC_Assign_LessThan of string * tac_expr * tac_expr (* x <- < 1 2 *)
| TAC_Assign_LessThanEqual of string * tac_expr * tac_expr (* x <- <= 1 2 *)
| TAC_Assign_Equal of string * tac_expr * tac_expr (* x <- = 1 2 *)


| TAC_Assign_Int of string * string (* x <- int 1 *) 
| TAC_Assign_Bool of string * string (* x <- bool true *)
| TAC_Assign_String of string * string (* x <- string "hello" *)

(* ones complement *)
| TAC_Assign_Not of string * tac_expr (* x <- not t$0 *)
(*arithmetic negaition (twos complement )*)
| TAC_Assign_Negate of string * tac_expr (* x <- ~ t$0 *)

  (* 
  branch if true
  branch to the label if the expression is true.
  we generate a branch if true instruction  to jump to then branch
  else generate a jump instruction to the else branch
  
  *) 
| TAC_Bt of tac_expr * string (* bt t$0 Main_main_1 *)

(* unconditional jump*)
| TAC_Jmp of string (* jmp Main_main_0 *)
| TAC_Label of string (* label Main_main_1 *)

and
tac_expr =
| TAC_Variable of string


(*
  map var to temporary variables
  for example, map the variable "x" in the source code to t$0.
*)

type symbol_table = (string,string) Hashtbl.t
let var_map : symbol_table = Hashtbl.create 100


let counter = ref 0 
let label_counter = ref 0

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

  let fresh_label () = 
    let l = !label_counter in
    label_counter := !label_counter + 1;
    "confusingly_named_label_" ^ (string_of_int l)
  in


  (*
  CONVERT EXPRESSIONS TO TAC INSTRUCTIONS 

  return list of instructions and
  the return variable 
  i.e, we do a bunch of stuff (first list of instructions),
  and then store it in a variable (the second part of the tuple)
  *)
  let rec convert ast = begin
    match ast with
    | AST_Variable (v) -> (
      (* get the corresponding temp from data structure.*)
      try
        let stored_var = Hashtbl.find var_map v in
        [], TAC_Variable(stored_var)
      with Not_found ->
        [], TAC_Variable(v)
      )
    | AST_Default (typ) ->(
      let new_var = fresh_var () in
      [TAC_Assign_Default(TAC_Variable(new_var), typ)], TAC_Variable(new_var)
    ) 
      
    | AST_Assign ((_,id), exp) ->( 
      let instr, ret = convert exp in
      
      let found_var = try
        Hashtbl.find var_map id
      with Not_found -> 
        failwith "um what\n";
      in

      let to_output = TAC_Assign(TAC_Variable(found_var), ret) in
      (instr @ [to_output]), TAC_Variable(found_var)
    )
    | AST_Self_Dispatch ((_,mname), exps) | AST_Dynamic_Dispatch((_,mname),exps)-> 

      let instr, return_exp = List.fold_left (fun (acc_inst, acc_exp) exp -> 
        (* extract instructions and return value *)
        let inst, expr = convert exp in
        (acc_inst @ inst, acc_exp @ [expr])
      ) ([], []) exps in

      let last_return_exp = match List.rev return_exp with
        | hd::_ -> Some(hd)
        | _ -> None 
      in
      let new_var = fresh_var () in
      (* t0 <- call out_int t1  (just have to match t1) *)
      let to_output = match last_return_exp with
        | Some(expr) -> TAC_Assign_Call(new_var, mname, expr)
        | None -> TAC_Assign_Call(new_var, mname, TAC_Variable(""))
      in
      (instr@ [to_output]), TAC_Variable(new_var)
  
    | AST_If(cond, then_branch, else_branch) ->
      (* get tac instructions, and var for these.*)
      let cond_instr, cond_var = convert cond in
      let then_instr, then_var = convert then_branch in
      let else_instr, else_var = convert else_branch in

      let then_label = fresh_label () in
      let else_label = fresh_label () in
      let join_label = fresh_label () in

      let bt_instr = TAC_Bt(cond_var, then_label) in
      let jmp_else = TAC_Jmp(else_label) in
      let jmp_join = TAC_Jmp(join_label) in
      (cond_instr @ [bt_instr; jmp_else; TAC_Label then_label] 
      @ then_instr @ [jmp_join; TAC_Label else_label] 
      @ else_instr @ [TAC_Label join_label]), then_var

    | AST_While(cond, body) ->
      (* get tac instructions, and var for these.*)
      (*
      cond_instr is the list of tac instructions for the conditional.
      *)
      let cond_instr, cond_var = convert cond in
      let body_instr, body_var = convert body in

      let while_label = fresh_label () in
      let body_label = fresh_label () in
      let join_label = fresh_label () in

      (*
      if the temporary variable for conditional is true, jump to body_label.
      *)
      let bt_instr = TAC_Bt(cond_var, body_label) in
      let jmp_while = TAC_Jmp(while_label) in
      let jmp_join = TAC_Jmp(join_label) in

      (*
      do conditional instruction,
      if conditional is true, jump to body label
      else, jump to join label
    in body label, do body instructions and then jump to while. repeat.
      *)
      (TAC_Label while_label :: cond_instr @ [bt_instr; jmp_join; TAC_Label body_label] 
      @ body_instr @ [jmp_while; TAC_Label join_label]), body_var
      
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

    | AST_New (t) ->
      let new_var = fresh_var () in
      [TAC_Assign_New(new_var, t)], TAC_Variable(new_var)
    | AST_Isvoid (v) ->
      let new_var = fresh_var () in
      let i1, ta1 = convert v in
      let
      to_output = TAC_Assign_IsVoid(new_var, ta1) in
      (i1@[to_output]), TAC_Variable(new_var)

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

    | AST_LessThan(a1,a2) ->
      let i1, ta1 = convert a1 in
      let i2, ta2 = convert a2 in
      let new_var = fresh_var () in
      let to_output = TAC_Assign_LessThan(new_var, ta1, ta2) in
      (i1@i2@[to_output]), TAC_Variable(new_var)
    | AST_LessThanEqual(a1,a2) ->
      let i1, ta1 = convert a1 in
      let i2, ta2 = convert a2 in
      let new_var = fresh_var () in
      let to_output = TAC_Assign_LessThanEqual(new_var, ta1, ta2) in
      (i1@i2@[to_output]), TAC_Variable(new_var)
    | AST_Equal(a1,a2) ->
      let i1, ta1 = convert a1 in
      let i2, ta2 = convert a2 in
      let new_var = fresh_var () in
      let to_output = TAC_Assign_Equal(new_var, ta1, ta2) in
      (i1@i2@[to_output]), TAC_Variable(new_var)

    | AST_Int (v) -> 
      let new_var = fresh_var () in
      [TAC_Assign_Int (new_var, v)], TAC_Variable(new_var)
    | AST_Bool (v) -> 
      let new_var = fresh_var () in
      [TAC_Assign_Bool (new_var, v)], TAC_Variable(new_var)
    | AST_String (v) ->
      let new_var = fresh_var () in
      [TAC_Assign_String (new_var, v)], TAC_Variable(new_var)
    | AST_Not (v) ->
      let new_var = fresh_var () in
      let i1, ta1 = convert v in
      let
      to_output = TAC_Assign_Not(new_var, ta1) in
      (i1@[to_output]), TAC_Variable(new_var)
    | AST_Negate (v) ->
      let new_var = fresh_var () in
      let i1, ta1 = convert v in
      let
      to_output = TAC_Assign_Negate(new_var, ta1) in
      (i1@[to_output]), TAC_Variable(new_var)

    | AST_Let(bindings, body) ->
      (* Generate TAC and the return values for all expressions in lst. *)
      let rec convert_bindings lst =
        match lst with
        | [] -> failwith "empty let"
        | [x] -> 
          let instr, ret = convert x in
          instr, [ret]
        | hd::tl -> 
          let i1, t1 = convert hd in
          let i2, t2 = convert_bindings tl in
          i1 @ i2, [t1] @ t2
      in

      (*
       bindings to expressions
       for example, AST_Int
        *)
      let bindings_as_exps = List.map (fun ((_,id), (_,typ), exp_opt) -> 
        match exp_opt with
        | Some(exp) -> exp
        | None -> AST_Default(typ) (* DEFAULT *)
      ) bindings in

      let binding_instr, binding_rets = convert_bindings bindings_as_exps in

      (*
       map variables with their corresponding temporary varibales.
      binding_rets comes from recursively adding the expressions in convert_bindings 
       *)
      List.iter2 (fun ((_,id), _, _) ret -> 
        Hashtbl.add var_map id (match ret with TAC_Variable(v) -> v)
      ) bindings binding_rets;

      (* need to use that data structure that converts variables to temporaries *)
      let body_instr, body_ret = convert body in

      (* IMPORTANT: after converting body, we need to ensure that the variables are deallocated from the table. *)
      List.iter (fun ((_,id), _, _) -> 
        Hashtbl.remove var_map id
      ) bindings;

      (binding_instr @ body_instr), body_ret

    | _ ->(
      printf "expression not handled in AST. \n";
      exit 1
    ) 
  
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

  and read_binding () =
    match read() with
    | "let_binding_no_init" ->
      let bname = read_id() in
      let btype = read_id() in
      (* printf "reading let binding %s\n" (snd bname); *)
      (bname,btype,None)
    | "let_binding_init" ->
      let bname = read_id() in
      let btype = read_id() in
      let bval = read_exp() in
      (* printf "reading let binding %s\n" (snd bname); *)
      (bname,btype,Some(bval))
    | x -> failwith("error reading let binding:" ^x)
  (* and read_case_element() = 
    let cevar = read_id() in
    let cetype = read_id() in
    let cebody = read_exp() in
    (cevar,cetype,cebody)  *)




  (* READ AST NODES *)
  and read_exp () =
    let loc = read() in
    let annotated_type = read() in
    let ast_root= match read() with

    | "assign" -> 
      let id = read_id() in
      let exp = read_exp() in
      AST_Assign(id, exp)


    | "self_dispatch" ->
      let id = read_id() in
      let exps = read_list read_exp in
      AST_Self_Dispatch(id, exps)
    
    | "dynamic_dispatch" ->
      let exp = read_exp() in
      let id = read_id() in
      let exps = read_list read_exp in
      AST_Dynamic_Dispatch(id, exps)


    | "if" ->
      let cond = read_exp() in
      let then_branch = read_exp() in
      let else_branch = read_exp() in
      AST_If(cond, then_branch, else_branch)
    | "while" ->  
      let guard = read_exp() in
      let body = read_exp() in
      AST_While(guard, body)
    | "block" ->
      AST_Block(read_list read_exp)

    | "new" ->
      let _,t = read_id() in
      AST_New(t)
    | "isvoid" ->
      let exp = read_exp() in
      AST_Isvoid(exp)

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

    | "lt" ->
      let exp1 = read_exp() in
      let exp2 = read_exp() in
      AST_LessThan(exp1,exp2)
    | "le" ->
      let exp1 = read_exp() in
      let exp2 = read_exp() in
      AST_LessThanEqual(exp1,exp2)
    | "eq" ->
      let exp1 = read_exp() in
      let exp2 = read_exp() in
      AST_Equal(exp1,exp2)
    | "not" ->
      let exp = read_exp() in
      AST_Not(exp)
    | "negate" ->
      let exp = read_exp() in
      AST_Negate(exp)

    | "integer" ->
      let ival=read() in 
      AST_Int(ival)
    | "string" ->
      let sval=read() in 
      AST_String(sval)
    | "identifier" -> 
      let _,ident = read_id () in
      (* printf "reading identifier %s\n" ident; *)
      AST_Variable(ident)
    | "true" ->
      AST_Bool("true")
    | "false" ->
      AST_Bool("false")

    | "let" ->
      let bindings = read_list read_binding in
      let body = read_exp() in
      AST_Let(bindings, body)

    | x -> (
      printf "expression kind unhandled: %s" x;
      exit 1
      )
    in 
    ast_root
  in






  (* PRINT TAC INSTRUCTIONS *)
  let rec print_tac instructions expression = 
    (* let instructions, expression = convert method_body in *)
    (* print expressions*)
    List.iter (fun x -> (match x 
    with
    | TAC_Assign (var, e) -> 
        fprintf fout "%s <- %s\n" (match var with TAC_Variable(v) -> v) (match e with TAC_Variable(v) -> v)
    | TAC_Assign_Default (var, typ) -> 
        fprintf fout "%s <- default %s\n" (match var with TAC_Variable(v) -> v) typ
    | TAC_Assign_Call (var, mname, e) -> 
        fprintf fout "%s <- call %s %s\n" var mname (match e with TAC_Variable(v) -> v)  

    | TAC_Assign_New (v, t) -> 
        fprintf fout "%s <- new %s\n" v t
    | TAC_Assign_IsVoid (v, e) -> 
        fprintf fout "%s <- isvoid %s\n" v (match e with TAC_Variable(v) -> v)

    | TAC_Assign_Plus (v, e1, e2) -> 
        fprintf fout "%s <- + %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)
    | TAC_Assign_Minus(v, e1, e2) -> 
        fprintf fout "%s <- - %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)
    | TAC_Assign_Times(v, e1, e2) -> 
        fprintf fout "%s <- * %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)
    | TAC_Assign_Divide(v, e1, e2) -> 
        fprintf fout "%s <- / %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)
        


    | TAC_Assign_LessThan(v, e1, e2) -> 
        fprintf fout "%s <- < %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable
        (v) -> v)
    | TAC_Assign_LessThanEqual(v, e1, e2) -> 
        fprintf fout "%s <- <= %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)
    | TAC_Assign_Equal(v, e1, e2) -> 
        fprintf fout "%s <- = %s %s\n" v (match e1 with TAC_Variable(v) -> v) (match e2 with TAC_Variable(v) -> v)

    | TAC_Assign_Not (v, e) -> 
        fprintf fout "%s <- not %s\n" v (match e with TAC_Variable(v) -> v)
    | TAC_Assign_Negate (v, e) -> 
        fprintf fout "%s <- ~ %s\n" v (match e with TAC_Variable(v) -> v)
    

    | TAC_Assign_Int (v,i) -> 
        fprintf fout "%s <- int %s\n" v i
    | TAC_Assign_Bool (v,b) -> 
      fprintf fout "%s <- bool %s\n" v b
    | TAC_Assign_String (v,s) ->
      fprintf fout "%s <- string\n%s\n" v s
    | TAC_Bt (v, label) ->
        fprintf fout "bt %s %s\n" (match v with TAC_Variable(v) -> v) label
    | TAC_Jmp (label) ->
        fprintf fout "jmp %s\n" label
    (* this is the START of a label, not reference it from somewhere else.*)
    | TAC_Label (label) ->
        fprintf fout "label %s\n" label
    ) ) instructions;
    fprintf fout "return %s\n" (match expression with TAC_Variable(v) -> v); 





  in
  (* go through ast and print TAC *)
  let ast = read_aast() in
  List.iter (fun x -> (match x
  with
  | ((_,cname), _ , features) -> 
      List.iter(fun x -> (match x
      with
      | Attribute(fname, ftype, Some(finit)) -> 
        ()
      | Method((_,mname), formals, mtype, mbody) -> 
        let _ = counter := 0 in
        let instructions, expression = convert mbody in
        print_tac ([TAC_Label(fresh_label())] @ instructions) expression;
      | _ -> ()
      ) ) features; 
      
  ) ) ast;

  (* printf "%s\n" out; *)

  close_out fout;
  
end;;
main();;


