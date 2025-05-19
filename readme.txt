Code generation and optimization for CS485 Special Topics: Compilers

This course skips past the lexer and parser, and focuses on the semantic analyzer, codegen, and optimization.
The semantic analyzer I wrote is incomplete so will probably rewrite it later,
also I would eventually like to just implement the scanner and parser so that the
full implementation for cool is complete. 

Files:
./scanner/scanner.py - scans tokens
./codegen/src/asm.py emits cool assembly instructions from an annotated ast.
./codegen/src/x86.py emits x86 AT&T assembly from cool assembly.
