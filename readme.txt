Scanning, parsing, semantic analyzing, code generation and optimization for CS485 Special Topics: Compilers

COOL is an toy programming language with object oriented features, An interesting part of this project was figuring out how objects are represented in assembly. We learned about object layout, virtual tables to store pointers to functions, and how this works for inheritance.

More information for each stage is in each directory.

Files:

SCANNER
./scanner/scanner.py - scans tokens

PARSER
./parser/parser.py - creates ast from tokens given by the scanner. 

SEMANTIC ANALYZER
./semantic/semantic.ml  - semantic analyzer, type checks, creates class, implementation, and parent maps for use in later stages.

CODE GENERATION
./codegen/src - source code for the code generation stage.
./codegen/src/asm.py - emits cool assembly instructions from an annotated ast.
./codegen/src/x86.py - emits x86 AT&T assembly from cool assembly.


EXAMPLE PROGRAMS
./programs - example cool programs and their generated assembly output.