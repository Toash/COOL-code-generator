import sys
sys.path.append('../scanner')
sys.path.append('../utils')
from scanner import tokens
from utils import has_lexeme
from ply.lex import LexToken
import ply.yacc as yacc


if __name__ == "__main__":
    # creates LexTokens from lex_tokens.
    class Lexer:
        def __init__(self):
            self.lex_tokens = []
            pass

        def token(self):
            if self.lex_tokens == []:
                return None
            (lineno,type,lexeme)= self.lex_tokens.pop(0) 
            token = LexToken()
            token.lineno = int(lineno)
            token.type=type
            token.value=lexeme 
            token.lexpos = 0
            return token

    # Given a .cl-lex file, deserialize it, parse the tokens, and then serialize the ast.
    if len(sys.argv) >= 2:
        with open(sys.argv[1],'r') as lex_file:
            lines = lex_file.readlines()
            
            def get_token_line():
                global lines
                result = lines[0]
                lines = lines[1:]
                return result

            # append tokens to lexer. 
            lexer = Lexer()
            while lines:
                lineno = get_token_line().strip()
                type = get_token_line().strip()
                lexeme =type 
            
                # has lexeme
                if has_lexeme(type):
                    lexeme = get_token_line().rstrip('\n')

                lexer.lex_tokens.append((int(lineno),type.upper(),lexeme))

            precedence = (
                ('right', 'LARROW'),
                ('left', 'NOT'),
                ('nonassoc', 'LE', 'LT', 'EQUALS'),
                ('left', 'PLUS', 'MINUS'),
                ('left', 'TIMES', 'DIVIDE'),
                ('left', 'ISVOID'),
                ('left', 'TILDE'),
                ('left', 'AT'),
                ('left', 'DOT'),
            )

            # grammar rules
            def p_program_classlist(p):
                'program : classlist'
                p[0] = p[1] 
            def p_classlist(p):
                '''
                classlist : class SEMI classlist 
                        | class SEMI
                '''
                if len(p) == 4:
                    p[0] = [p[1]] + p[3]
                else:
                    p[0] = [p[1]] 

                    
            def p_class_noinherit(p):
                '''
                class : CLASS type LBRACE featurelist RBRACE
                '''
                p[0] = (p.lineno(1), 'class_noinherits', p[2], p[4])

            def p_class_inherit(p):
                '''
                class : CLASS type INHERITS type LBRACE featurelist RBRACE
                '''
                p[0] = (p.lineno(1), 'class_inherits', p[2], p[4],p[6])

            def p_type(p):
                'type : TYPE'
                p[0] = (p.lineno(1), p[1])


            
            def p_featurelist_none(p):
                'featurelist :'
                p[0] = []
            def p_featurelist_some(p):
                'featurelist : feature SEMI featurelist'
                p[0] = [p[1]] + p[3]
            
            def p_feature_attribute_no_init(p):
                'feature : identifier COLON type'
                p[0] = (p[1][0], 'attribute_no_init',p[1],p[3])
            def p_feature_attribute_init(p):
                'feature : identifier COLON type LARROW exp'
                p[0] = (p[1][0], 'attribute_init',p[1],p[3],p[5])

            def p_formal(p):
                'formal : identifier COLON type'
                p[0] = (p[1][0], 'formal',p[1],p[3])

            def p_formallist(p):
                '''formallist : formal COMMA formallist
                | formal 
                |
                '''
                if len(p) == 4:
                    p[0] = [p[1]] + p[3]
                elif len(p) == 2:
                    p[0] = [p[1]] 
                else:
                    p[0] = []
            def p_feature_method(p):
                'feature : identifier LPAREN formallist RPAREN COLON type LBRACE exp RBRACE'
                p[0] = (p[1][0], 'method',p[1],p[3],p[6],p[8])

            def p_assign(p):
                'exp : identifier LARROW exp'
                p[0] = (p[1][0], 'assign',p[1],p[3])


            def p_explist(p):
                '''explist : exp COMMA explist
                |          exp 
                |
                '''
                if len(p) == 4:
                    p[0] = [p[1]] + p[3]
                elif len(p)==2:
                    p[0] = [p[1]] 
                else: 
                    p[0] = []

            def p_dynamic_dispatch(p):
                'exp : exp DOT identifier LPAREN explist RPAREN'
                p[0] = (p[1][0], 'dynamic_dispatch', p[1], p[3],p[5])
            def p_static_dispatch(p):
                'exp : exp AT type DOT identifier LPAREN explist RPAREN'
                p[0] = (p[1][0], 'static_dispatch', p[1], p[3],p[5],p[7])
            def p_self_dispatch(p):
                'exp : identifier LPAREN explist RPAREN'
                p[0] = (p[1][0], 'self_dispatch', p[1], p[3])

            def p_if(p):
                'exp : IF exp THEN exp ELSE exp FI'
                p[0] = (p.lineno(1), 'if', p[2], p[4],p[6])
            def p_while(p):
                'exp : WHILE exp LOOP exp POOL'
                p[0] = (p.lineno(1), 'while', p[2], p[4])
            
            def p_block_explist(p):
                '''block_exp_list : exp SEMI block_exp_list
                | exp SEMI'''
                if len(p) == 4:
                    p[0] = [p[1]] + p[3]
                else: 
                    p[0] = [p[1]] 

            def p_block(p):
                'exp : LBRACE block_exp_list RBRACE'
                p[0] = (p.lineno(1), 'block', p[2])

               
            def p_bindinglist(p): 
                '''bindinglist : binding COMMA bindinglist
                | binding
                '''
                if len(p) == 4:
                    p[0] = [p[1]] + p[3]
                else: 
                    p[0] = [p[1]]
            def p_binding_no_init(p):
                'binding : identifier COLON type'
                p[0] = (p[1][0], "let_binding_no_init",p[1],p[3])
            def p_binding_init(p):
                'binding : identifier COLON type LARROW exp'
                p[0] = (p[1][0], "let_binding_init",p[1],p[3],p[5])

            def p_let(p):
                'exp : LET bindinglist IN exp'
                p[0] = (p.lineno(1), "let",p[2],p[4])

            def p_case_element_list(p):
                '''elementlist : element elementlist 
                | element'''
                if len(p) == 3:
                    p[0] = [p[1]] + p[2]
                else:
                    p[0] = [p[1]]

            def p_case_element(p):
                'element : identifier COLON type RARROW exp SEMI'
                p[0] = (p[1][0], 'case_element',p[1],p[3],p[5])
            def p_case(p):
                'exp : CASE exp OF elementlist ESAC'
                p[0] = (p.lineno(1),'case',p[2],p[4])

            def p_new(p):
                'exp : NEW type'
                p[0] = (p.lineno(1),'new',p[2])
            def p_isvoid(p):
                'exp : ISVOID exp'
                p[0] = (p.lineno(1),'isvoid',p[2])

            def p_exp_plus(p):
                'exp : exp PLUS exp'
                p[0] = (p[1][0], 'plus', p[1], p[3])
            def p_exp_minus(p):
                'exp : exp MINUS exp'
                p[0] = (p[1][0], 'minus', p[1], p[3])
            def p_exp_times(p):
                'exp : exp TIMES exp'
                p[0] = (p[1][0], 'times', p[1], p[3])
            def p_exp_divide(p):
                'exp : exp DIVIDE exp'
                p[0] = (p[1][0], 'divide', p[1], p[3])
            def p_negate(p):
                'exp : TILDE exp'
                p[0] = (p.lineno(1), 'negate', p[2])

            def p_lt(p):
                'exp : exp LT exp'
                p[0] = (p[1][0], 'lt',p[1],p[3])
            def p_le(p):
                'exp : exp LE exp'
                p[0] = (p[1][0], 'le',p[1],p[3])
            def p_eq(p):
                'exp : exp EQUALS exp'
                p[0] = (p[1][0], 'eq',p[1],p[3])
            def p_not(p):
                'exp : NOT exp'
                p[0] = (p.lineno(1), 'not',p[2])
            
            # ?
            def p_paren(p):
                'exp : LPAREN exp RPAREN'
                p[0] = p[2] 

            
            
            def p_exp_identifier(p):
                'exp : identifier'
                p[0] = (p[1][0], 'identifier', p[1])
            def p_identifier(p):
                'identifier : IDENTIFIER'
                p[0] = (p.lineno(1), p[1])
            def p_exp_integer(p):
                'exp : INTEGER'
                p[0] = (p.lineno(1), 'integer', p[1])
            def p_exp_string(p):
                'exp : STRING'
                p[0] = (p.lineno(1), 'string', p[1])
            def p_exp_true(p):
                'exp : TRUE'
                p[0] = (p.lineno(1), 'true', p[1])
            def p_exp_false(p):
                'exp : FALSE'
                p[0] = (p.lineno(1), 'false', p[1])

            
            def p_error(p):
                if p:
                    print(f"Syntax error at token {p.type}, on line {p.lineno}")
                    sys.exit(1)
                else:
                    print("Syntax error at EOF")

            # create the parser and parse using the grammar rules to get the ast.
            parser = yacc.yacc()
            ast = yacc.parse(lexer=lexer)
            
            # print(ast)
            ast_filename = (sys.argv[1])[:-4] + "-ast"
            with open(ast_filename,'w') as ast_file:
                # define mutually recursive methods to serialize the AST.

                def print_list(ast, print_element_function):
                    ast_file.write(str(len(ast)) + "\n")
                    for elem in ast:
                        print_element_function(elem)

                def print_identifier(ast):
                    #line #
                    ast_file.write(str(ast[0]) + "\n")
                    # value
                    ast_file.write( ast[1] + "\n")

                def print_exp(ast):
                    ast_file.write( str(ast[0]) + "\n")
                    ast_file.write( ast[1] + "\n")
                    if ast[1] == 'assign':
                        print_identifier(ast[2])
                        print_exp(ast[3])
                    elif ast[1] == 'dynamic_dispatch':
                        print_exp(ast[2])
                        print_identifier(ast[3])
                        print_list(ast[4],print_exp)
                    elif ast[1] == 'static_dispatch':
                        print_exp(ast[2])
                        print_identifier(ast[3])
                        print_identifier(ast[4])
                        print_list(ast[5],print_exp)
                    elif ast[1] == 'self_dispatch':
                        print_identifier(ast[2])
                        print_list(ast[3],print_exp)
                    elif ast[1] == 'if':
                        print_exp(ast[2])
                        print_exp(ast[3])
                        print_exp(ast[4])
                    elif ast[1] == 'while':
                        print_exp(ast[2])
                        print_exp(ast[3])
                    elif ast[1] == 'block':
                        print_list(ast[2],print_exp)
                    elif ast[1] == 'let': 
                        print_list(ast[2],print_binding)
                        print_exp(ast[3])
                    elif ast[1] == 'case':
                        print_exp(ast[2])
                        print_list(ast[3],print_element)
                    elif ast[1] == 'new':
                        print_identifier(ast[2])
                    elif ast[1] == 'isvoid':
                        print_exp(ast[2])
                    elif ast[1] in ['plus','minus','times','divide']:
                        print_exp(ast[2]) 
                        print_exp(ast[3]) 
                    elif ast[1] == 'negate':
                        print_exp(ast[2])
                    elif ast[1] == 'lt':
                        print_exp(ast[2])
                        print_exp(ast[3])
                    elif ast[1] == 'le':
                        print_exp(ast[2])
                        print_exp(ast[3])
                    elif ast[1] == 'eq':
                        print_exp(ast[2])
                        print_exp(ast[3])
                    elif ast[1] == 'not':
                        print_exp(ast[2])
                    elif ast[1] == 'identifier':
                        print_identifier(ast[2])
                    elif ast[1] == 'integer':
                        ast_file.write(str(ast[2]) + "\n")
                    elif ast[1] == 'string':
                        ast_file.write(str(ast[2]) + "\n")
                    elif ast[1] == 'true':
                        pass
                    elif ast[1] == 'false':
                        pass
                    else:
                        print("unhandled expression: ", ast)
                        sys.exit(1)


                def print_element(ast):
                    print_identifier(ast[2])
                    print_identifier(ast[3])
                    print_exp(ast[4])

                def print_binding(ast):
                    if ast[1] == "let_binding_no_init":
                        ast_file.write("let_binding_no_init\n")
                        print_identifier(ast[2])
                        print_identifier(ast[3])
                    elif ast[1] == "let_binding_init":
                        ast_file.write("let_binding_init\n")
                        print_identifier(ast[2])
                        print_identifier(ast[3])
                        print_exp(ast[4])
                    else:
                        print("unhandled let binding")
                        sys.exit(1)

                def print_formal(ast):
                    print_identifier(ast[2])
                    print_identifier(ast[3])

                def print_feature(ast):
                    if ast[1] == 'attribute_no_init':
                        ast_file.write("attribute_no_init\n")
                        print_identifier(ast[2])
                        print_identifier(ast[3])
                    elif ast[1] == 'attribute_init':
                        ast_file.write("attribute_init\n")
                        print_identifier(ast[2])
                        print_identifier(ast[3])
                        print_exp(ast[4]) 
                    elif ast[1] == 'method':
                        ast_file.write("method\n")
                        print_identifier(ast[2])
                        print_list(ast[3],print_formal)
                        print_identifier(ast[4])
                        print_exp(ast[5])
                    else:
                        print("unhandled feature")
                        sys.exit(1)
                    

                def print_class(ast): 
                    print_identifier(ast[2])
                    if ast[1] == "class_noinherits":
                        ast_file.write("no_inherits\n")
                        print_list(ast[3],print_feature)
                    elif ast[1] == "class_inherits":
                        ast_file.write("inherits\n")
                        print_identifier(ast[3])
                        print_list(ast[4],print_feature)
                    else:
                        print("unhandled class type")
                        sys.exit(1)

                
                def print_program(ast):
                    print_list(ast, print_class)

                print_program(ast)
                
    else:
        print("Please supply input .cl-lex")


