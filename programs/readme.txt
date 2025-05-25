Here are some example programs in cool along with their corresponding assembly output.

run.py runs through all of the stages. To eventually emit the corresponding assembly file. 

To run the generated assembly (on x86 architecture):
gcc -no-pie -static <assembly file>
./a.out
We are not generating position independent code because there is no pedagogical benefit in doing so.

My semantic analyzer implemention isn't matching the prose of the reference semantic analyzer exactly for certain input/outputs, 
which leads the code generation stage to segfault since it depends on the output of the reference semantic analyzer, 
because of this the reference semantic analyzer is stubbed in so that more cool programs will work.