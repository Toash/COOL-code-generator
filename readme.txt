Code generation and optimization for CS485 Special Topics: Compilers

Files:
./scanner/scanner.py - scans tokens
./parser/parser.py - creates ast from tokens given by the scanner. 
./semantic (WIP) - semantic analyzer, type checks, creates class, implementation, and parent maps for use in later stages.
./codegen/src/asm.py emits cool assembly instructions from an annotated ast.
./codegen/src/x86.py emits x86 AT&T assembly from cool assembly.
