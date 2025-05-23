# returns true if token with the name has a corresponding lexeme.
def has_lexeme(type):
    type = type.lower()
    return type == "identifier" or type == "integer" or type == "string" or type == "type"