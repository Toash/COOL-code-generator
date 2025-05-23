import ply.lex as lex
import sys
sys.path.append('../utils')
from utils import has_lexeme

# List of token names.   This is always required
tokens = (
    'AT',
    'CASE',
    'CLASS',
    'COLON',
    'COMMA',
    'DIVIDE',
    'DOT',
    'ELSE',
    'EQUALS',
    'ESAC',
    'FALSE',
    'FI',
    'IDENTIFIER',
    'IF',
    'IN',
    'INHERITS',
    'INTEGER',
    'ISVOID',
    'LARROW',
    'LBRACE',
    'LE',
    'LET',
    'LOOP',
    'LPAREN',
    'LT',
    'MINUS',
    'NEW',
    'NOT',
    'OF',
    'PLUS',
    'POOL',
    'RARROW',
    'RBRACE',
    'RPAREN',
    'SEMI',
    'STRING',
    'THEN',
    'TILDE',
    'TIMES',
    'TRUE',
    'TYPE',
    'WHILE',
)

reserved = {
    'new': 'NEW',
    'not': 'NOT',
    'true': 'TRUE',
    'false': 'FALSE',

    'class': 'CLASS',
    'inherits': 'INHERITS',

    'if': 'IF',
    'then': 'THEN',
    'else': 'ELSE',
    'fi': 'FI',

    'while': 'WHILE',
    'loop': 'LOOP',
    'pool': 'POOL',

    'case': 'CASE',
    'of': 'OF',
    'esac': 'ESAC',

    'let': 'LET',
    'in': 'IN',

    'isvoid': 'ISVOID',
}



# Regular expression rules for simple tokens

t_LE = r'\<\='
t_LT = r'\<'
t_EQUALS = r'\='

t_LARROW = r'\<\-'
t_RARROW = r'\=\>'

t_LBRACE = r'\{'
t_RBRACE = r'\}'

t_LPAREN = r'\('
t_RPAREN = r'\)'

t_AT = r'\@'
t_COLON = r'\:'
t_COMMA = r'\,'
t_DOT = r'\.'
t_SEMI = r'\;'
t_TILDE = r'\~'

t_PLUS = r'\+'
t_MINUS = r'\-'
t_TIMES = r'\*'
t_DIVIDE = r'\/'


def t_IDENTIFIER(t):
    r'[a-z][A-Za-z0-9_]*'
    t.type = reserved.get(t.value.lower(),"IDENTIFIER")
    return t

def t_TYPE(t):
    r'[A-Z][A-Za-z0-9_]*'
    if t.value.lower() == "class":
        t.type = "CLASS"
    return t

def t_STRING(t):
    r'"[^"\n]*"'
    t.value = t.value[1:-1]
    return t

def t_INTEGER(t):
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


if __name__ == "__main__":
    
    # Build the lexer
    lexer = lex.lex()


    if len(sys.argv) >= 2:
        output = ""
        with open(sys.argv[1],'r') as fp:

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
                output+=str(tok.type.lower())
                output+='\n'
                # lexeme
                if has_lexeme(tok.type):
                    output+=str(tok.value)
                    output+='\n'
                # print(tok)

        with open(sys.argv[1]+"-lex",'w') as fp:
            fp.write(output)
    else:
        print("Please specify source .cl file.")