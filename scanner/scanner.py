import ply.lex as lex
from sys import argv

# List of token names.   This is always required
tokens = (
    'at',
    'case',
    'class',
    'colon',
    'comma',
    'divide',
    'dot',
    'else',
    'equals',
    'esac',
    'false',
    'fi',
    'identifier',
    'if',
    'in',
    'inherits',
    'integer',
    'isvoid',
    'larrow',
    'lbrace',
    'le',
    'let',
    'loop',
    'lparen',
    'lt',
    'minus',
    'new',
    'not',
    'of',
    'plus',
    'pool',
    'rarrow',
    'rbrace',
    'rparen',
    'semi',
    'string',
    'then',
    'tilde',
    'times',
    'true',
    'type',
    'while',
)

reserved = {

    'true':'true',
    'false':'false',

    'class':'class',
    'inherits':'inherits',

    'if':'if',
    'else':'else',
    'fi':'fi',

    'while':'while',
    'loop':'loop',
    'pool':'pool',

    'case':'case',
    'esac':'esac',

    'let':'let',
    'in':'in',

    'isvoid':'isvoid'
}



# Regular expression rules for simple tokens
t_at = r'\@'
t_case= r'case'
t_class = r'class'
t_colon= r':'
t_comma= r','
t_dot= r'\.'

t_if= r'if'


t_equals= r'\='

t_plus= r'\+'
t_minus= r'-'
t_times= r'\*'
t_divide= r'/'

t_lparen= r'\('
t_rparen= r'\)'

def t_identifier(t):
    r'[a-z][A-Za-z_]*'
    t.type = reserved.get(t.value,"identifier")
    return t

def t_string(t):
    r'"[^"\n]*"'
    t.value = t.value[1:-1]
    return t

# A regular expression rule with some action code
def t_integer(t):
    r'\d+'
    t.value = int(t.value)    
    return t

# Define a rule so we can track line numbers
def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)

# A string containing ignored characters (spaces and tabs)
t_ignore  = ' \t'

# Error handling rule
def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

# Build the lexer
lexer = lex.lex()


if len(argv) >= 2:
    output = ""
    with open(argv[1],'r') as fp:

        lexer.input(fp.read())

        # Tokenize
        while True:
            tok = lexer.token()
            if not tok: 
                break      
            # print(tok.lineno)
            # print(tok.type)
            output+=str(tok.lineno)
            output+='\n'
            output+=str(tok.type)
            output+='\n'
            # lexeme
            if tok.type == "identifier" \
                or tok.type == "integer" \
                    or tok.type == "string" \
                        or tok.type == "type":
                output+=str(tok.value)
                output+='\n'
            # print(tok)

    with open(argv[1]+"-lex",'w') as fp:
        fp.write(output)
else:
    print("Please specify source .cl file.")
