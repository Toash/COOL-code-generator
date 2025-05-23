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
                result = lines[0].strip()
                lines = lines[1:]
                return result

            # append tokens to lexer. 
            lexer = Lexer()
            while lines:
                lineno = get_token_line()
                type = get_token_line()
                lexeme =type 
            
                # has lexeme
                if has_lexeme(type):
                    lexeme = get_token_line()

                lexer.lex_tokens.append((int(lineno),type.upper(),lexeme))

            precedence = (
                ('left', 'PLUS', 'MINUS'),
                ('left', 'TIMES', 'DIVIDE'),
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

            def p_type(p):
                'type : TYPE'
                p[0] = (p.lineno(1), p[1])

            def p_identifier(p):
                'identifier : IDENTIFIER'
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
            
            def p_exp_integer(p):
                'exp : INTEGER'
                p[0] = (p.lineno(1), 'integer', p[1])

            
            def p_error(p):
                if p:
                    print("Syntax error at token", p.type)
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
                    ast_file.write(str(ast[0]) + "\n")
                    ast_file.write( ast[1] + "\n")

                def print_exp(ast):
                    ast_file.write( str(ast[0]) + "\n")
                    ast_file.write( ast[1] + "\n")
                    if ast[1] in ['plus','minus','times','divide']:
                        print_exp(ast[2]) 
                        print_exp(ast[3]) 
                    elif ast[1] == 'integer':
                        ast_file.write(str(ast[2]) + "\n")
                    else:
                        print("unhandled expression")
                        sys.exit(1)

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
                    else:
                        print("unhandled feature")
                        sys.exit(1)
                    

                def print_class(ast): 
                    print_identifier(ast[2])
                    # FIXME
                    ast_file.write("no_inherits\n")
                    print_list(ast[3],print_feature)
                
                def print_program(ast):
                    print_list(ast, print_class)

                print_program(ast)
                
    else:
        print("Please supply input .cl-lex")


