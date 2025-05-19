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

    'new':'new',

    'not':'not',
    'true':'true',
    'false':'false',

    'class':'class',
    'inherits':'inherits',

    'if':'if',
    'then':'then',
    'else':'else',
    'fi':'fi',

    'while':'while',
    'loop':'loop',
    'pool':'pool',

    'case':'case',
    'of':'of',
    'esac':'esac',

    'let':'let',
    'in':'in',

    'isvoid':'isvoid',
    
}



# Regular expression rules for simple tokens

t_le = r'\<\='
t_lt = r'\<'
t_equals = r'\='

t_larrow= r'\<\-'
t_rarrow= r'\=\>'

t_lbrace= r'\{'
t_rbrace= r'\}'

t_lparen = r'\('
t_rparen= r'\)'

t_at = r'\@'
t_colon= r'\:'
t_comma= r'\,'
t_dot= r'\.'
t_semi = r'\;'
t_tilde= r'\~'

t_plus= r'\+'
t_minus= r'\-'
t_times= r'\*'
t_divide= r'\/'


def t_identifier(t):
    r'[a-z][A-Za-z0-9_]*'
    t.type = reserved.get(t.value,"identifier")
    return t

def t_type(t):
    r'[A-Z][A-Za-z0-9_]*'
    if t.value.lower() == "class":
        t.type = "class"
    return t

def t_string(t):
    r'"[^"\n]*"'
    t.value = t.value[1:-1]
    return t

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


# -- comment or (* comments*)
def t_COMMENT(t):
    r'(--.*)|(\(\*(.|\n)*?\*\))'
    t.lexer.lineno += t.value.count('\n')
    pass


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
