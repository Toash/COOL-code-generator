Bool..vtable:
		.quad	 string1
		.quad	 Bool..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
IO..vtable:
		.quad	 string2
		.quad	 IO..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 IO.in_int
		.quad	 IO.in_string
		.quad	 IO.out_int
		.quad	 IO.out_string
Int..vtable:
		.quad	 string3
		.quad	 Int..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
Main..vtable:
		.quad	 string4
		.quad	 Main..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 IO.in_int
		.quad	 IO.in_string
		.quad	 IO.out_int
		.quad	 IO.out_string
		.quad	 Main.main
Object..vtable:
		.quad	 string5
		.quad	 Object..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
String..vtable:
		.quad	 string6
		.quad	 String..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 String.concat
		.quad	 String.length
		.quad	 String.substr
Bool..new:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 $8, %r14
		subq	 %r14, %rsp
		movq	 $4, %r12
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r12
		movq	 $0, %r14
		movq	 %r14, 0(%r12)
		movq	 $4, %r14
		movq	 %r14, 8(%r12)
		movq	 $Bool..vtable, %r14
		movq	 %r14, 16(%r12)
		movq	 $0, %r13
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
IO..new:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 $8, %r14
		subq	 %r14, %rsp
		movq	 $3, %r12
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r12
		movq	 $10, %r14
		movq	 %r14, 0(%r12)
		movq	 $3, %r14
		movq	 %r14, 8(%r12)
		movq	 $IO..vtable, %r14
		movq	 %r14, 16(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Int..new:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 $8, %r14
		subq	 %r14, %rsp
		movq	 $4, %r12
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r12
		movq	 $1, %r14
		movq	 %r14, 0(%r12)
		movq	 $4, %r14
		movq	 %r14, 8(%r12)
		movq	 $Int..vtable, %r14
		movq	 %r14, 16(%r12)
		movq	 $0, %r13
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main..new:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 $8, %r14
		subq	 %r14, %rsp
		movq	 $3, %r12
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r12
		movq	 $11, %r14
		movq	 %r14, 0(%r12)
		movq	 $3, %r14
		movq	 %r14, 8(%r12)
		movq	 $Main..vtable, %r14
		movq	 %r14, 16(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Object..new:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 $8, %r14
		subq	 %r14, %rsp
		movq	 $3, %r12
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r12
		movq	 $12, %r14
		movq	 %r14, 0(%r12)
		movq	 $3, %r14
		movq	 %r14, 8(%r12)
		movq	 $Object..vtable, %r14
		movq	 %r14, 16(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
String..new:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 $8, %r14
		subq	 %r14, %rsp
		movq	 $4, %r12
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r12
		movq	 $3, %r14
		movq	 %r14, 0(%r12)
		movq	 $4, %r14
		movq	 %r14, 8(%r12)
		movq	 $String..vtable, %r14
		movq	 %r14, 16(%r12)
		movq	 $the.empty.string, %r13
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Bool.abort:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 $cool_abort, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Bool.copy:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 8(%r12), %r14
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r13
		pushq	 %r13
object_copy_loop_startbranch_1:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_2
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_1
object_copy_loop_endbranch_2:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Bool.type_name:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 16(%r12), %r14
		movq	 0(%r14), %r14
		movq	 %r14, 24(%r13)
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
IO.abort:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 $cool_abort, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
IO.copy:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 8(%r12), %r14
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r13
		pushq	 %r13
object_copy_loop_startbranch_3:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_4
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_3
object_copy_loop_endbranch_4:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
IO.type_name:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 16(%r12), %r14
		movq	 0(%r14), %r14
		movq	 %r14, 24(%r13)
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
IO.in_int:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, %r14
		## in_int
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 coolinint
		movq	 %rax, %r13
		movq	 %r13, 24(%r14)
		movq	 %r14, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
IO.in_string:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, %r14
		## in_string
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 coolgetstr
		movq	 %rax, %r13
		movq	 %r13, 24(%r14)
		movq	 %r14, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
IO.out_int:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 24(%r13), %r13
		## out_int
		movq	 $percent.d, %rdi
		movl	 %r13d, %eax
		cdqe	## sign extend the 32 bit integer
		movq	 %rax, %rsi
		movl	 $0, %eax	## required by printf.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 printf
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
IO.out_string:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 24(%r13), %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Int.abort:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 $cool_abort, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Int.copy:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 8(%r12), %r14
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r13
		pushq	 %r13
object_copy_loop_startbranch_5:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_6
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_5
object_copy_loop_endbranch_6:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Int.type_name:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 16(%r12), %r14
		movq	 0(%r14), %r14
		movq	 %r14, 24(%r13)
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.abort:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 $cool_abort, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.copy:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 8(%r12), %r14
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r13
		pushq	 %r13
object_copy_loop_startbranch_7:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_8
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_7
object_copy_loop_endbranch_8:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.type_name:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 16(%r12), %r14
		movq	 0(%r14), %r14
		movq	 %r14, 24(%r13)
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.in_int:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, %r14
		## in_int
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 coolinint
		movq	 %rax, %r13
		movq	 %r13, 24(%r14)
		movq	 %r14, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.in_string:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, %r14
		## in_string
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 coolgetstr
		movq	 %rax, %r13
		movq	 %r13, 24(%r14)
		movq	 %r14, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.out_int:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 24(%r13), %r13
		## out_int
		movq	 $percent.d, %rdi
		movl	 %r13d, %eax
		cdqe	## sign extend the 32 bit integer
		movq	 %rax, %rsi
		movl	 $0, %eax	## required by printf.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 printf
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.out_string:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 24(%r13), %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.main:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string7, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 64(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Object.abort:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 $cool_abort, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Object.copy:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 8(%r12), %r14
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r13
		pushq	 %r13
object_copy_loop_startbranch_9:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_10
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_9
object_copy_loop_endbranch_10:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Object.type_name:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 16(%r12), %r14
		movq	 0(%r14), %r14
		movq	 %r14, 24(%r13)
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
String.abort:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 $cool_abort, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
String.copy:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 8(%r12), %r14
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r13
		pushq	 %r13
object_copy_loop_startbranch_11:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_12
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_11
object_copy_loop_endbranch_12:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
String.type_name:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 16(%r12), %r14
		movq	 0(%r14), %r14
		movq	 %r14, 24(%r13)
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
String.concat:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, %r15
		movq	 24(%rbp), %r13
		movq	 %r13, %r14
		movq	 24(%r13), %r14
		movq	 24(%r12), %r13
		movq	 %r13, %rdi
		movq	 %r14, %rsi
		## String.concat
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call coolstrcat
		movq	 %rax, %r13
		movq	 %r13, 24(%r15)
		movq	 %r15, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
String.length:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, %r14
		movq	 24(%r12), %r13
		## String.length
		movq	 %r13, %rdi
		movl	 $0, %eax
		call	 coolstrlen
		movq	 %rax, %r13
		movq	 %r13, 24(%r14)
		movq	 %r14, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
String.substr:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, %r15
		movq	 24(%rbp), %r13
		movq	 %r13, %r14
		movq	 24(%r14), %r14
		movq	 32(%rbp), %r13
		movq	 24(%r13), %r13
		movq	 24(%r12), %r12
		movq	 %r12, %rdi
		movq	 %r13, %rsi
		movq	 %r14, %rdx
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 coolsubstr
		movq	 %rax, %r13
		cmpq	 $0, %r13
		jne	 substr_valid_branch_13
		movq	 $substr_bad, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
substr_valid_branch_13:
		movq	 %r13, 24(%r15)
		movq	 %r15, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
the.empty.string:
		.byte	 0 	 ## null char
cool_abort:
		.byte	 97 	 		## 'a'		
		.byte	 98 	 		## 'b'		
		.byte	 111 	 		## 'o'		
		.byte	 114 	 		## 'r'		
		.byte	 116 	 		## 't'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
substr_bad:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 48 	 		## '0'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 69 	 		## 'E'		
		.byte	 120 	 		## 'x'		
		.byte	 99 	 		## 'c'		
		.byte	 101 	 		## 'e'		
		.byte	 112 	 		## 'p'		
		.byte	 116 	 		## 't'		
		.byte	 105 	 		## 'i'		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 83 	 		## 'S'		
		.byte	 116 	 		## 't'		
		.byte	 114 	 		## 'r'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 103 	 		## 'g'		
		.byte	 46 	 		## '.'		
		.byte	 115 	 		## 's'		
		.byte	 117 	 		## 'u'		
		.byte	 98 	 		## 'b'		
		.byte	 115 	 		## 's'		
		.byte	 116 	 		## 't'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 117 	 		## 'u'		
		.byte	 116 	 		## 't'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 102 	 		## 'f'		
		.byte	 32 	 		## ' '		
		.byte	 114 	 		## 'r'		
		.byte	 97 	 		## 'a'		
		.byte	 110 	 		## 'n'		
		.byte	 103 	 		## 'g'		
		.byte	 101 	 		## 'e'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string1:
		.byte	 66 	 		## 'B'		
		.byte	 111 	 		## 'o'		
		.byte	 111 	 		## 'o'		
		.byte	 108 	 		## 'l'		
		.byte	 0 	 ## null char
string7:
		.byte	 72 	 		## 'H'		
		.byte	 101 	 		## 'e'		
		.byte	 108 	 		## 'l'		
		.byte	 108 	 		## 'l'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 119 	 		## 'w'		
		.byte	 111 	 		## 'o'		
		.byte	 114 	 		## 'r'		
		.byte	 108 	 		## 'l'		
		.byte	 100 	 		## 'd'		
		.byte	 33 	 		## '!'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string2:
		.byte	 73 	 		## 'I'		
		.byte	 79 	 		## 'O'		
		.byte	 0 	 ## null char
string3:
		.byte	 73 	 		## 'I'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 0 	 ## null char
string4:
		.byte	 77 	 		## 'M'		
		.byte	 97 	 		## 'a'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string5:
		.byte	 79 	 		## 'O'		
		.byte	 98 	 		## 'b'		
		.byte	 106 	 		## 'j'		
		.byte	 101 	 		## 'e'		
		.byte	 99 	 		## 'c'		
		.byte	 116 	 		## 't'		
		.byte	 0 	 ## null char
string6:
		.byte	 83 	 		## 'S'		
		.byte	 116 	 		## 't'		
		.byte	 114 	 		## 'r'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 103 	 		## 'g'		
		.byte	 0 	 ## null char
percent.d:
		.byte 37 	# '%'
		.byte 108 	# 'l'
		.byte 100 	# 'd'
		.byte 0
percent.ld:
		.byte 32 	# ' '
		.byte 37 	# '%'
		.byte 108 	# 'l'
		.byte 100 	# 'd'
		.byte 0


## REFERENCE COMPILER BUILT-INS

                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl eq_handler
eq_handler:             ## helper function for =
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 32(%rbp), %r12
                        ## return address handling
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        cmpq %r14, %r13
			je eq_true
                        movq $0, %r15
                        cmpq %r15, %r13
			je eq_false
                        cmpq %r15, %r14
			je eq_false
                        movq 0(%r13), %r13
                        movq 0(%r14), %r14
                        ## place the sum of the type tags in r1
                        addq %r14, %r13
                        movq $0, %r14
                        cmpq %r14, %r13
			je eq_bool
                        movq $2, %r14
                        cmpq %r14, %r13
			je eq_int
                        movq $6, %r14
                        cmpq %r14, %r13
			je eq_string
                        ## otherwise, use pointer comparison
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        cmpq %r14, %r13
			je eq_true
.globl eq_false
eq_false:               ## not equal
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        jmp eq_end
.globl eq_true
eq_true:                ## equal
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp eq_end
.globl eq_bool
eq_bool:                ## two Bools
.globl eq_int
eq_int:                 ## two Ints
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        cmpq %r14, %r13
			je eq_true
                        jmp eq_false
.globl eq_string
eq_string:              ## two Strings
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        ## guarantee 16-byte alignment before call
			andq $0xFFFFFFFFFFFFFFF0, %rsp
			movq %r13, %rdi
			movq %r14, %rsi
			call strcmp 
			cmp $0, %eax
			je eq_true
                        jmp eq_false
.globl eq_end
eq_end:                 ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl le_handler
le_handler:             ## helper function for <=
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 32(%rbp), %r12
                        ## return address handling
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        cmpq %r14, %r13
			je le_true
                        movq $0, %r15
                        cmpq %r15, %r13
			je le_false
                        cmpq %r15, %r14
			je le_false
                        movq 0(%r13), %r13
                        movq 0(%r14), %r14
                        ## place the sum of the type tags in r1
                        addq %r14, %r13
                        movq $0, %r14
                        cmpq %r14, %r13
			je le_bool
                        movq $2, %r14
                        cmpq %r14, %r13
			je le_int
                        movq $6, %r14
                        cmpq %r14, %r13
			je le_string
                        ## for non-primitives, equality is our only hope
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        cmpq %r14, %r13
			je le_true
.globl le_false
le_false:               ## not less-than-or-equal
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        jmp le_end
.globl le_true
le_true:                ## less-than-or-equal
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp le_end
.globl le_bool
le_bool:                ## two Bools
.globl le_int
le_int:                 ## two Ints
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        cmpl %r14d, %r13d
			jle le_true
                        jmp le_false
.globl le_string
le_string:              ## two Strings
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        ## guarantee 16-byte alignment before call
			andq $0xFFFFFFFFFFFFFFF0, %rsp
			movq %r13, %rdi
			movq %r14, %rsi
			call strcmp 
			cmp $0, %eax
			jle le_true
                        jmp le_false
.globl le_end
le_end:                 ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl lt_handler
lt_handler:             ## helper function for <
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 32(%rbp), %r12
                        ## return address handling
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq $0, %r15
                        cmpq %r15, %r13
			je lt_false
                        cmpq %r15, %r14
			je lt_false
                        movq 0(%r13), %r13
                        movq 0(%r14), %r14
                        ## place the sum of the type tags in r1
                        addq %r14, %r13
                        movq $0, %r14
                        cmpq %r14, %r13
			je lt_bool
                        movq $2, %r14
                        cmpq %r14, %r13
			je lt_int
                        movq $6, %r14
                        cmpq %r14, %r13
			je lt_string
                        ## for non-primitives, < is always false
.globl lt_false
lt_false:               ## not less than
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        jmp lt_end
.globl lt_true
lt_true:                ## less than
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp lt_end
.globl lt_bool
lt_bool:                ## two Bools
.globl lt_int
lt_int:                 ## two Ints
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        cmpl %r14d, %r13d
			jl lt_true
                        jmp lt_false
.globl lt_string
lt_string:              ## two Strings
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        ## guarantee 16-byte alignment before call
			andq $0xFFFFFFFFFFFFFFF0, %rsp
			movq %r13, %rdi
			movq %r14, %rsi
			call strcmp 
			cmp $0, %eax
			jl lt_true
                        jmp lt_false
.globl lt_end
lt_end:                 ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl start
start:                  ## program begins here
                        .globl main
			.type main, @function
main:
                        movq $Main..new, %r14
                        pushq %rbp
                        call *%r14
                        pushq %rbp
                        pushq %r13
                        movq $Main.main, %r14
                        call *%r14
                        ## guarantee 16-byte alignment before call
			andq $0xFFFFFFFFFFFFFFF0, %rsp
			movl $0, %edi
			call exit
                        
	.globl	cooloutstr
	.type	cooloutstr, @function
cooloutstr:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L5:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$92, %al
	jne	.L3
	movl	-4(%rbp), %eax
	cltq
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$110, %al
	jne	.L3
	movq	stdout(%rip), %rax
	movq	%rax, %rsi
	movl	$10, %edi
	call	fputc@PLT
	addl	$2, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$92, %al
	jne	.L4
	movl	-4(%rbp), %eax
	cltq
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$116, %al
	jne	.L4
	movq	stdout(%rip), %rax
	movq	%rax, %rsi
	movl	$9, %edi
	call	fputc@PLT
	addl	$2, -4(%rbp)
	jmp	.L2
.L4:
	movq	stdout(%rip), %rdx
	movl	-4(%rbp), %eax
	movslq	%eax, %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc@PLT
	addl	$1, -4(%rbp)
.L2:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L5
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	cooloutstr, .-cooloutstr
	.globl	coolstrlen
	.type	coolstrlen, @function
coolstrlen:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L7
.L8:
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
.L7:
	movl	-4(%rbp), %eax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L8
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	coolstrlen, .-coolstrlen
	.section	.rodata
.LC0:
	.string	"%s%s"
	.text
	.globl	coolstrcat
	.type	coolstrcat, @function
coolstrcat:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L11
	movq	-48(%rbp), %rax
	jmp	.L12
.L11:
	cmpq	$0, -48(%rbp)
	jne	.L13
	movq	-40(%rbp), %rax
	jmp	.L12
.L13:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	coolstrlen
	movl	%eax, %ebx
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	coolstrlen
	addl	%ebx, %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	cltq
	movl	$1, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -24(%rbp)
	movl	-28(%rbp), %eax
	movslq	%eax, %rsi
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rcx, %r8
	movq	%rdx, %rcx
	leaq	.LC0(%rip), %rdx
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	movq	-24(%rbp), %rax
.L12:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	coolstrcat, .-coolstrcat
	.globl	coolgetstr
	.type	coolgetstr, @function
coolgetstr:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	movq	stdin(%rip), %rdx
	leaq	-24(%rbp), %rcx
	leaq	-32(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	getline@PLT
	movq	%rax, -16(%rbp)
	cmpq	$-1, -16(%rbp)
	je	.L15
	movq	-32(%rbp), %rax
	testq	%rax, %rax
	jne	.L16
.L15:
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$1, %edi
	call	malloc@PLT
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movb	$0, (%rax)
	jmp	.L17
.L16:
	movq	-16(%rbp), %rdx
	movq	-32(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memchr@PLT
	testq	%rax, %rax
	je	.L18
	movq	-32(%rbp), %rax
	movb	$0, (%rax)
	jmp	.L17
.L18:
	movq	-32(%rbp), %rdx
	movq	-16(%rbp), %rax
	subq	$1, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$10, %al
	jne	.L17
	movq	-32(%rbp), %rdx
	subq	$1, -16(%rbp)
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
.L17:
	movq	-32(%rbp), %rax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L20
	call	__stack_chk_fail@PLT
.L20:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	coolgetstr, .-coolgetstr
	.globl	coolsubstr
	.type	coolsubstr, @function
coolsubstr:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	coolstrlen
	movl	%eax, -4(%rbp)
	cmpq	$0, -32(%rbp)
	js	.L22
	cmpq	$0, -40(%rbp)
	js	.L22
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	cmpq	%rax, %rdx
	jle	.L23
.L22:
	movl	$0, %eax
	jmp	.L24
.L23:
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strndup@PLT
.L24:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	coolsubstr, .-coolsubstr
	.globl	coolinint
	.type	coolinint, @function
coolinint:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$304, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	stdin(%rip), %rdx
	leaq	-272(%rbp), %rax
	movl	$256, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L26
	movl	$0, %eax
	jmp	.L37
.L26:
	leaq	-272(%rbp), %rax
	movq	%rax, -288(%rbp)
	jmp	.L28
.L29:
	addq	$1, -288(%rbp)
.L28:
	call	__ctype_b_loc@PLT
	movq	(%rax), %rdx
	movq	-288(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	jne	.L29
	movq	-288(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L30
	movq	-288(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$45, %al
	je	.L31
	movq	-288(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$43, %al
	je	.L31
	call	__ctype_b_loc@PLT
	movq	(%rax), %rdx
	movq	-288(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$2048, %eax
	testl	%eax, %eax
	jne	.L31
.L30:
	movl	$0, %eax
	jmp	.L37
.L31:
	leaq	-296(%rbp), %rcx
	movq	-288(%rbp), %rax
	movl	$10, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strtol@PLT
	movq	%rax, -280(%rbp)
	movabsq	$-2147483649, %rax
	cmpq	%rax, -280(%rbp)
	jle	.L32
	movl	$2147483648, %eax
	cmpq	%rax, -280(%rbp)
	jl	.L34
.L32:
	movl	$0, %eax
	jmp	.L37
.L36:
	movq	-296(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -296(%rbp)
.L34:
	movq	-296(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L35
	movq	-296(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$10, %al
	jne	.L36
.L35:
	movq	-280(%rbp), %rax
.L37:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L38
	call	__stack_chk_fail@PLT
.L38:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	coolinint, .-coolinint
.section .note.GNU-stack,"",@progbits
