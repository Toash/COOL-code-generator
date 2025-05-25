A..vtable:
		.quad	 string1
		.quad	 A..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 A.value
		.quad	 A.set_var
		.quad	 A.method1
		.quad	 A.method2
		.quad	 A.method3
		.quad	 A.method4
		.quad	 A.method5
A2I..vtable:
		.quad	 string2
		.quad	 A2I..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 A2I.c2i
		.quad	 A2I.i2c
		.quad	 A2I.a2i
		.quad	 A2I.a2i_aux
		.quad	 A2I.i2a
		.quad	 A2I.i2a_aux
B..vtable:
		.quad	 string3
		.quad	 B..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 B.value
		.quad	 B.set_var
		.quad	 B.method1
		.quad	 B.method2
		.quad	 B.method3
		.quad	 B.method4
		.quad	 B.method5
Bool..vtable:
		.quad	 string4
		.quad	 Bool..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
C..vtable:
		.quad	 string5
		.quad	 C..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 C.value
		.quad	 C.set_var
		.quad	 C.method1
		.quad	 C.method2
		.quad	 C.method3
		.quad	 C.method4
		.quad	 C.method5
		.quad	 C.method6
D..vtable:
		.quad	 string6
		.quad	 D..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 D.value
		.quad	 D.set_var
		.quad	 D.method1
		.quad	 D.method2
		.quad	 D.method3
		.quad	 D.method4
		.quad	 D.method5
		.quad	 D.method7
E..vtable:
		.quad	 string7
		.quad	 E..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 E.value
		.quad	 E.set_var
		.quad	 E.method1
		.quad	 E.method2
		.quad	 E.method3
		.quad	 E.method4
		.quad	 E.method5
		.quad	 E.method7
		.quad	 E.method6
IO..vtable:
		.quad	 string8
		.quad	 IO..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 IO.in_int
		.quad	 IO.in_string
		.quad	 IO.out_int
		.quad	 IO.out_string
Int..vtable:
		.quad	 string9
		.quad	 Int..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
Main..vtable:
		.quad	 string10
		.quad	 Main..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 IO.in_int
		.quad	 IO.in_string
		.quad	 IO.out_int
		.quad	 IO.out_string
		.quad	 Main.menu
		.quad	 Main.prompt
		.quad	 Main.get_int
		.quad	 Main.is_even
		.quad	 Main.class_type
		.quad	 Main.print
		.quad	 Main.main
Object..vtable:
		.quad	 string11
		.quad	 Object..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
String..vtable:
		.quad	 string12
		.quad	 String..new
		.quad	 Object.abort
		.quad	 Object.copy
		.quad	 Object.type_name
		.quad	 String.concat
		.quad	 String.length
		.quad	 String.substr
A..new:
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
		movq	 $13, %r14
		movq	 %r14, 0(%r12)
		movq	 $4, %r14
		movq	 %r14, 8(%r12)
		movq	 $A..vtable, %r14
		movq	 %r14, 16(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 24(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A2I..new:
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
		movq	 $14, %r14
		movq	 %r14, 0(%r12)
		movq	 $3, %r14
		movq	 %r14, 8(%r12)
		movq	 $A2I..vtable, %r14
		movq	 %r14, 16(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
B..new:
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
		movq	 $15, %r14
		movq	 %r14, 0(%r12)
		movq	 $4, %r14
		movq	 %r14, 8(%r12)
		movq	 $B..vtable, %r14
		movq	 %r14, 16(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 24(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
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
C..new:
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
		movq	 $16, %r14
		movq	 %r14, 0(%r12)
		movq	 $4, %r14
		movq	 %r14, 8(%r12)
		movq	 $C..vtable, %r14
		movq	 %r14, 16(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 24(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
D..new:
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
		movq	 $17, %r14
		movq	 %r14, 0(%r12)
		movq	 $4, %r14
		movq	 %r14, 8(%r12)
		movq	 $D..vtable, %r14
		movq	 %r14, 16(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 24(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E..new:
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
		movq	 $18, %r14
		movq	 %r14, 0(%r12)
		movq	 $4, %r14
		movq	 %r14, 8(%r12)
		movq	 $E..vtable, %r14
		movq	 %r14, 16(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 24(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
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
		movq	 $7, %r12
		## --- CALLOC ---
		## first argument - amount of entries
		movq	 %r12, %rdi
		## second argument - size of each entry
		movq	 $8, %rsi
		call calloc
		movq	 %rax, %r12
		movq	 $11, %r14
		movq	 %r14, 0(%r12)
		movq	 $7, %r14
		movq	 %r14, 8(%r12)
		movq	 $Main..vtable, %r14
		movq	 %r14, 16(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 24(%r12)
		movq	 $0, %r13
		movq	 %r13, 32(%r12)
		movq	 $0, %r13
		movq	 %r13, 40(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 48(%r12)
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 48(%r12)
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
A.abort:
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
A.copy:
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
A.type_name:
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
A.value:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%r12), %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A.set_var:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A.method1:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A.method2:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 32(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		addq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 B..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_3
		movq	 $dispatch_void_string_28, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_3:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A.method3:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 C..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_4
		movq	 $dispatch_void_string_37, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_4:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A.method4:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 32(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 lt_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_5
false_branch_6:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 32(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_8
		movq	 $dispatch_void_string_54, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_8:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_7
true_branch_5:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 32(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_9
		movq	 $dispatch_void_string_47, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_9:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
end_branch_7:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A.method5:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $16, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, -8(%rbp)
while_predicate_branch_10:
		pushq	 %r12
		pushq	 %rbp
		movq	 -8(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 le_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		je	 end_while_branch_11
		movq	 0(%rbp), %r13
		pushq	 %r13
		movq	 -8(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		movq	 %r14, %rax
		imull	 %r13d, %eax
		shlq $32, %rax
		shrq $32, %rax
		movl	 %eax, %r14d
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		movq	 -8(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		addq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, -8(%rbp)
		jmp	 while_predicate_branch_10
end_while_branch_11:
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 E..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_12
		movq	 $dispatch_void_string_71, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_12:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A2I.abort:
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
A2I.copy:
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
object_copy_loop_startbranch_13:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_14
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_13
object_copy_loop_endbranch_14:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A2I.type_name:
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
A2I.c2i:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string13, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_15
false_branch_16:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string14, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_18
false_branch_19:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string15, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_21
false_branch_22:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string16, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_24
false_branch_25:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string17, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_27
false_branch_28:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string18, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_30
false_branch_31:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string19, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_33
false_branch_34:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string20, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_36
false_branch_37:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string21, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_39
false_branch_40:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string22, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_42
false_branch_43:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 16(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		jmp	 end_branch_44
true_branch_42:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $9, %r14
		movq	 %r14, 24(%r13)
end_branch_44:
		jmp	 end_branch_41
true_branch_39:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $8, %r14
		movq	 %r14, 24(%r13)
end_branch_41:
		jmp	 end_branch_38
true_branch_36:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $7, %r14
		movq	 %r14, 24(%r13)
end_branch_38:
		jmp	 end_branch_35
true_branch_33:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $6, %r14
		movq	 %r14, 24(%r13)
end_branch_35:
		jmp	 end_branch_32
true_branch_30:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $5, %r14
		movq	 %r14, 24(%r13)
end_branch_32:
		jmp	 end_branch_29
true_branch_27:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $4, %r14
		movq	 %r14, 24(%r13)
end_branch_29:
		jmp	 end_branch_26
true_branch_24:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $3, %r14
		movq	 %r14, 24(%r13)
end_branch_26:
		jmp	 end_branch_23
true_branch_21:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $2, %r14
		movq	 %r14, 24(%r13)
end_branch_23:
		jmp	 end_branch_20
true_branch_18:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
end_branch_20:
		jmp	 end_branch_17
true_branch_15:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
end_branch_17:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A2I.i2c:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_45
false_branch_46:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_48
false_branch_49:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $2, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_51
false_branch_52:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $3, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_54
false_branch_55:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $4, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_57
false_branch_58:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $5, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_60
false_branch_61:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $6, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_63
false_branch_64:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $7, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_66
false_branch_67:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $8, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_69
false_branch_70:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $9, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_72
false_branch_73:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 16(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string23, %r14
		movq	 %r14, 24(%r13)
		jmp	 end_branch_74
true_branch_72:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string22, %r14
		movq	 %r14, 24(%r13)
end_branch_74:
		jmp	 end_branch_71
true_branch_69:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string21, %r14
		movq	 %r14, 24(%r13)
end_branch_71:
		jmp	 end_branch_68
true_branch_66:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string20, %r14
		movq	 %r14, 24(%r13)
end_branch_68:
		jmp	 end_branch_65
true_branch_63:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string19, %r14
		movq	 %r14, 24(%r13)
end_branch_65:
		jmp	 end_branch_62
true_branch_60:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string18, %r14
		movq	 %r14, 24(%r13)
end_branch_62:
		jmp	 end_branch_59
true_branch_57:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string17, %r14
		movq	 %r14, 24(%r13)
end_branch_59:
		jmp	 end_branch_56
true_branch_54:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string16, %r14
		movq	 %r14, 24(%r13)
end_branch_56:
		jmp	 end_branch_53
true_branch_51:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string15, %r14
		movq	 %r14, 24(%r13)
end_branch_53:
		jmp	 end_branch_50
true_branch_48:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string14, %r14
		movq	 %r14, 24(%r13)
end_branch_50:
		jmp	 end_branch_47
true_branch_45:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string13, %r14
		movq	 %r14, 24(%r13)
end_branch_47:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A2I.a2i:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_78
		movq	 $dispatch_void_string_200, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_78:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_75
false_branch_76:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_82
		movq	 $dispatch_void_string_201, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_82:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 56(%r14), %r14
		call	 *%r14
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string24, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_79
false_branch_80:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_86
		movq	 $dispatch_void_string_202, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_86:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 56(%r14), %r14
		call	 *%r14
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string25, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_83
false_branch_84:
		pushq	 %rbp
		pushq	 %r12
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 64(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_85
true_branch_83:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_87
		movq	 $dispatch_void_string_202, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_87:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_88
		movq	 $dispatch_void_string_202, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_88:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 56(%r14), %r14
		call	 *%r14
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 64(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
end_branch_85:
		jmp	 end_branch_81
true_branch_79:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_89
		movq	 $dispatch_void_string_201, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_89:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_90
		movq	 $dispatch_void_string_201, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_90:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 56(%r14), %r14
		call	 *%r14
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 64(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
end_branch_81:
		jmp	 end_branch_77
true_branch_75:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
end_branch_77:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A2I.a2i_aux:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $24, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_91
		movq	 $dispatch_void_string_214, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_91:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, -8(%rbp)
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, -16(%rbp)
while_predicate_branch_92:
		pushq	 %r12
		pushq	 %rbp
		movq	 -16(%rbp), %r13
		pushq	 %r13
		movq	 -8(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 lt_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		je	 end_while_branch_93
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $10, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		movq	 %r14, %rax
		imull	 %r13d, %eax
		shlq $32, %rax
		shrq $32, %rax
		movl	 %eax, %r14d
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 -16(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_94
		movq	 $dispatch_void_string_218, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_94:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 56(%r14), %r14
		call	 *%r14
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		addq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		movq	 -16(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		addq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, -16(%rbp)
		jmp	 while_predicate_branch_92
end_while_branch_93:
		movq	 0(%rbp), %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A2I.i2a:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_95
false_branch_96:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 lt_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_98
false_branch_99:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		movq	 %r14, %rax
		imull	 %r13d, %eax
		shlq $32, %rax
		shrq $32, %rax
		movl	 %eax, %r14d
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 80(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string24, %r14
		movq	 %r14, 24(%r13)
		cmpq	 $0, %r13
		jne	 non_void_branch_101
		movq	 $dispatch_void_string_235, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_101:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_100
true_branch_98:
		pushq	 %rbp
		pushq	 %r12
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 80(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
end_branch_100:
		jmp	 end_branch_97
true_branch_95:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string13, %r14
		movq	 %r14, 24(%r13)
end_branch_97:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
A2I.i2a_aux:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_102
false_branch_103:
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $10, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		cmpq	 $0, %r13
		jne	 div_ok_branch_105
		movq	 $divide_by_zero_string_243, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
div_ok_branch_105:
		movq	 $0, %rdx
		movq	 %r14, %rax
		cdq
		idivl	 %r13d
		movq	 %rax, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $10, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		movq	 %r14, %rax
		imull	 %r13d, %eax
		shlq $32, %rax
		shrq $32, %rax
		movl	 %eax, %r14d
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 80(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_106
		movq	 $dispatch_void_string_244, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_106:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_104
true_branch_102:
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string23, %r14
		movq	 %r14, 24(%r13)
end_branch_104:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
B.abort:
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
B.copy:
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
object_copy_loop_startbranch_107:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_108
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_107
object_copy_loop_endbranch_108:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
B.type_name:
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
B.value:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%r12), %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
B.set_var:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
B.method1:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
B.method2:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 32(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		addq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 B..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_109
		movq	 $dispatch_void_string_28, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_109:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
B.method3:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 C..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_110
		movq	 $dispatch_void_string_37, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_110:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
B.method4:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 32(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 lt_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_111
false_branch_112:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 32(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_114
		movq	 $dispatch_void_string_54, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_114:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_113
true_branch_111:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 32(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_115
		movq	 $dispatch_void_string_47, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_115:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
end_branch_113:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
B.method5:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		movq	 %r14, %rax
		imull	 %r13d, %eax
		shlq $32, %rax
		shrq $32, %rax
		movl	 %eax, %r14d
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 E..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_116
		movq	 $dispatch_void_string_84, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_116:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
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
object_copy_loop_startbranch_117:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_118
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_117
object_copy_loop_endbranch_118:
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
C.abort:
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
C.copy:
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
object_copy_loop_startbranch_119:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_120
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_119
object_copy_loop_endbranch_120:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
C.type_name:
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
C.value:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%r12), %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
C.set_var:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
C.method1:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
C.method2:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 32(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		addq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 B..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_121
		movq	 $dispatch_void_string_28, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_121:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
C.method3:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 C..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_122
		movq	 $dispatch_void_string_37, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_122:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
C.method4:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 32(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 lt_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_123
false_branch_124:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 32(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_126
		movq	 $dispatch_void_string_54, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_126:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_125
true_branch_123:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 32(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_127
		movq	 $dispatch_void_string_47, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_127:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
end_branch_125:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
C.method5:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		movq	 %r14, %rax
		imull	 %r13d, %eax
		shlq $32, %rax
		shrq $32, %rax
		movl	 %eax, %r14d
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		movq	 %r14, %rax
		imull	 %r13d, %eax
		shlq $32, %rax
		shrq $32, %rax
		movl	 %eax, %r14d
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 E..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_128
		movq	 $dispatch_void_string_106, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_128:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
C.method6:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 A..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_129
		movq	 $dispatch_void_string_97, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_129:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
D.abort:
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
D.copy:
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
object_copy_loop_startbranch_130:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_131
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_130
object_copy_loop_endbranch_131:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
D.type_name:
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
D.value:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%r12), %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
D.set_var:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
D.method1:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
D.method2:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 32(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		addq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 B..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_132
		movq	 $dispatch_void_string_28, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_132:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
D.method3:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 C..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_133
		movq	 $dispatch_void_string_37, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_133:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
D.method4:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 32(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 lt_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_134
false_branch_135:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 32(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_137
		movq	 $dispatch_void_string_54, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_137:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_136
true_branch_134:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 32(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_138
		movq	 $dispatch_void_string_47, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_138:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
end_branch_136:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
D.method5:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		movq	 %r14, %rax
		imull	 %r13d, %eax
		shlq $32, %rax
		shrq $32, %rax
		movl	 %eax, %r14d
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 E..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_139
		movq	 $dispatch_void_string_84, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_139:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
D.method7:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 %r13, 0(%rbp)
		pushq	 %r12
		pushq	 %rbp
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 lt_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_140
false_branch_141:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_143
false_branch_144:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_146
false_branch_147:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $2, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_149
false_branch_150:
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $3, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 96(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_151
true_branch_149:
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
end_branch_151:
		jmp	 end_branch_148
true_branch_146:
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
end_branch_148:
		jmp	 end_branch_145
true_branch_143:
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
end_branch_145:
		jmp	 end_branch_142
true_branch_140:
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 96(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
end_branch_142:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E.abort:
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
E.copy:
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
object_copy_loop_startbranch_152:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_153
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_152
object_copy_loop_endbranch_153:
		popq	 %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E.type_name:
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
E.value:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%r12), %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E.set_var:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 %r13, 24(%r12)
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E.method1:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $0, %r14
		subq	 %r14, %rsp
		movq	 %r12, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E.method2:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 32(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		addq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 B..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_154
		movq	 $dispatch_void_string_28, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_154:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E.method3:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 C..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_155
		movq	 $dispatch_void_string_37, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_155:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E.method4:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 32(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 lt_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_156
false_branch_157:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 32(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_159
		movq	 $dispatch_void_string_54, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_159:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_158
true_branch_156:
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 32(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_160
		movq	 $dispatch_void_string_47, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_160:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
end_branch_158:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E.method5:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		pushq	 %r13
		movq	 24(%rbp), %r13
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		movq	 %r14, %rax
		imull	 %r13d, %eax
		shlq $32, %rax
		shrq $32, %rax
		movl	 %eax, %r14d
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 E..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_161
		movq	 $dispatch_void_string_84, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_161:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E.method7:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 %r13, 0(%rbp)
		pushq	 %r12
		pushq	 %rbp
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 lt_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_162
false_branch_163:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_165
false_branch_166:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_168
false_branch_169:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $2, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_171
false_branch_172:
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $3, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 96(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_173
true_branch_171:
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
end_branch_173:
		jmp	 end_branch_170
true_branch_168:
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
end_branch_170:
		jmp	 end_branch_167
true_branch_165:
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
end_branch_167:
		jmp	 end_branch_164
true_branch_162:
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 96(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
end_branch_164:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
E.method6:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		movq	 24(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $8, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		cmpq	 $0, %r13
		jne	 div_ok_branch_174
		movq	 $divide_by_zero_string_133, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
div_ok_branch_174:
		movq	 $0, %rdx
		movq	 %r14, %rax
		cdq
		idivl	 %r13d
		movq	 %rax, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 A..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_175
		movq	 $dispatch_void_string_134, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_175:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
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
object_copy_loop_startbranch_176:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_177
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_176
object_copy_loop_endbranch_177:
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
object_copy_loop_startbranch_178:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_179
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_178
object_copy_loop_endbranch_179:
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
object_copy_loop_startbranch_180:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_181
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_180
object_copy_loop_endbranch_181:
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
Main.menu:
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
		movq	 $string26, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string27, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string28, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string29, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string30, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string31, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string32, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string33, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string34, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string35, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string36, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string37, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string38, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string39, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string40, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string41, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string42, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string43, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.prompt:
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
		movq	 $string44, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string45, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.get_int:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $16, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 A2I..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 80(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, -8(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 -8(%rbp), %r13
		pushq	 %r13
		movq	 0(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_182
		movq	 $dispatch_void_string_303, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_182:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 56(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.is_even:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		movq	 %r13, 0(%rbp)
		pushq	 %r12
		pushq	 %rbp
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 lt_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_183
false_branch_184:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_186
false_branch_187:
		pushq	 %r12
		pushq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_189
false_branch_190:
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $2, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 96(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		jmp	 end_branch_191
true_branch_189:
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
end_branch_191:
		jmp	 end_branch_188
true_branch_186:
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
		movq	 $1, %r14
		movq	 %r14, 24(%r13)
end_branch_188:
		jmp	 end_branch_185
true_branch_183:
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		movq	 24(%r13), %r13
		movq	 $0, %r14
		subq	 %r13, %r14
		movq	 %r14, %r15
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 %r15, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 96(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
end_branch_185:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.class_type:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		je	 case_void_branch_320
		movq	 %r13, 0(%rbp)
		movq	 0(%r13), %r13
		movq	 $13, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_A_branch_192
		movq	 $15, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_B_branch_193
		movq	 $16, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_C_branch_194
		movq	 $17, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_D_branch_195
		movq	 $18, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_E_branch_196
		movq	 $12, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_197
		movq	 $14, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_197
		movq	 $0, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_197
		movq	 $10, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_197
		movq	 $1, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_197
		movq	 $11, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_197
		movq	 $3, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_197
		movq	 $0, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_320_A
		movq	 $1, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_320_A
		movq	 $3, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_320_A
		movq	 $10, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_320_A
		movq	 $11, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_320_A
		movq	 $14, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_320_A
case_without_branch_320_A:
		movq	 $case_without_branch_string_320_A, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
case_void_branch_320:
		movq	 $case_void_string_320, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
case_exp_for_A_branch_192:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string46, %r14
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
		jmp	 case_exp_end_branch_198
case_exp_for_B_branch_193:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string47, %r14
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
		jmp	 case_exp_end_branch_198
case_exp_for_C_branch_194:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string48, %r14
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
		jmp	 case_exp_end_branch_198
case_exp_for_D_branch_195:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string49, %r14
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
		jmp	 case_exp_end_branch_198
case_exp_for_E_branch_196:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string50, %r14
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
		jmp	 case_exp_end_branch_198
case_exp_for_Object_branch_197:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string51, %r14
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
		jmp	 case_exp_end_branch_198
case_exp_end_branch_198:
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
Main.print:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $8, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 A2I..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 24(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_199
		movq	 $dispatch_void_string_333, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_199:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		movq	 0(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_200
		movq	 $dispatch_void_string_333, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_200:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 72(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 64(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string52, %r14
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
Main.main:
		pushq	 %rbp
		movq	 %rsp, %rbp
		movq	 16(%rsp), %r12
		movq	 $24, %r14
		subq	 %r14, %rsp
		pushq	 %rbp
		pushq	 %r12
		call	 A..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 32(%r12)
while_predicate_branch_201:
		movq	 48(%r12), %r13
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		je	 end_while_branch_202
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string53, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_206
		movq	 $dispatch_void_string_347, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_206:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 96(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_203
false_branch_204:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string54, %r14
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
		jmp	 end_branch_205
true_branch_203:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string55, %r14
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
end_branch_205:
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 104(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 72(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 24(%r12)
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%r12), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string56, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_207
false_branch_208:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%r12), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string57, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_210
false_branch_211:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%r12), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string58, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_213
false_branch_214:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%r12), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string59, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_216
false_branch_217:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%r12), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string60, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_219
false_branch_220:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%r12), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string61, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_222
false_branch_223:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%r12), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string62, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_225
false_branch_226:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%r12), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string63, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_228
false_branch_229:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%r12), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string64, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_231
false_branch_232:
		pushq	 %r12
		pushq	 %rbp
		movq	 24(%r12), %r13
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string65, %r14
		movq	 %r14, 24(%r13)
		pushq	 %r13
		pushq	 %r12
		call	 eq_handler
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %rbp
		popq	 %r12
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_234
false_branch_235:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_237
		movq	 $dispatch_void_string_422, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_237:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 A..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_238
		movq	 $dispatch_void_string_422, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_238:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 56(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 32(%r12)
		jmp	 end_branch_236
true_branch_234:
		pushq	 %rbp
		pushq	 %r12
		call	 Bool..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 48(%r12)
end_branch_236:
		jmp	 end_branch_233
true_branch_231:
		pushq	 %rbp
		pushq	 %r12
		call	 A..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 32(%r12)
end_branch_233:
		jmp	 end_branch_230
true_branch_228:
		movq	 $0, %r13
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_239
		movq	 $dispatch_void_string_398, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_239:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 E..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_240
		movq	 $dispatch_void_string_398, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_240:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 104(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 0(%rbp)
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_241
		movq	 $dispatch_void_string_399, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_241:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_242
		movq	 $dispatch_void_string_399, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_242:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $8, %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		movq	 %r14, %rax
		imull	 %r13d, %eax
		shlq $32, %rax
		shrq $32, %rax
		movl	 %eax, %r14d
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		popq	 %r14
		movq	 24(%r13), %r13
		movq	 24(%r14), %r14
		subq	 %r13, %r14
		pushq	 %r14
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		popq	 %r14
		movq	 %r14, 24(%r13)
		movq	 %r13, -8(%rbp)
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string53, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string66, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string67, %r14
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
		pushq	 %rbp
		pushq	 %r12
		call	 A2I..new
		popq	 %r12
		popq	 %rbp
		movq	 %r13, -16(%rbp)
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 -8(%rbp), %r13
		pushq	 %r13
		movq	 -16(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_243
		movq	 $dispatch_void_string_408, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_243:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 72(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 64(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string44, %r14
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
		movq	 0(%rbp), %r13
		movq	 %r13, 32(%r12)
end_branch_230:
		jmp	 end_branch_227
true_branch_225:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_247
		movq	 $dispatch_void_string_381, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_247:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_248
		movq	 $dispatch_void_string_381, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_248:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 96(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 24(%r13), %r13
		cmpq	 $0, %r13
		jne	 true_branch_244
false_branch_245:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string53, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string68, %r14
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
		jmp	 end_branch_246
true_branch_244:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string53, %r14
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
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		pushq	 %r13
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 112(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string69, %r14
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
end_branch_246:
end_branch_227:
		jmp	 end_branch_224
true_branch_222:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_249
		movq	 $dispatch_void_string_378, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_249:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 C..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_250
		movq	 $dispatch_void_string_378, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_250:
		pushq	 %r13
		movq	 $C..vtable, %r14
		movq	 88(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 32(%r12)
end_branch_224:
		jmp	 end_branch_221
true_branch_219:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_251
		movq	 $dispatch_void_string_376, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_251:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 C..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_252
		movq	 $dispatch_void_string_376, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_252:
		pushq	 %r13
		movq	 $B..vtable, %r14
		movq	 88(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 32(%r12)
end_branch_221:
		jmp	 end_branch_218
true_branch_216:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_253
		movq	 $dispatch_void_string_374, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_253:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 C..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_254
		movq	 $dispatch_void_string_374, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_254:
		pushq	 %r13
		movq	 $A..vtable, %r14
		movq	 88(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 32(%r12)
end_branch_218:
		jmp	 end_branch_215
true_branch_213:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 88(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 A..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_255
		movq	 $dispatch_void_string_371, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_255:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 40(%r12)
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_256
		movq	 $dispatch_void_string_372, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_256:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		movq	 40(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_257
		movq	 $dispatch_void_string_372, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_257:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 D..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_258
		movq	 $dispatch_void_string_372, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_258:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 80(%r14), %r14
		call	 *%r14
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 32(%r12)
end_branch_215:
		jmp	 end_branch_212
true_branch_210:
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		je	 case_void_branch_361
		movq	 %r13, 0(%rbp)
		movq	 0(%r13), %r13
		movq	 $16, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_C_branch_259
		movq	 $13, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_A_branch_260
		movq	 $12, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_261
		movq	 $14, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_261
		movq	 $15, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_A_branch_260
		movq	 $15, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_261
		movq	 $0, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_261
		movq	 $17, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_A_branch_260
		movq	 $17, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_261
		movq	 $18, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_A_branch_260
		movq	 $18, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_261
		movq	 $10, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_261
		movq	 $1, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_261
		movq	 $11, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_261
		movq	 $3, %r14
		cmpq	 %r13, %r14
		je	 case_exp_for_Object_branch_261
		movq	 $0, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_361_A
		movq	 $1, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_361_A
		movq	 $3, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_361_A
		movq	 $10, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_361_A
		movq	 $11, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_361_A
		movq	 $14, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_361_A
		movq	 $15, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_361_A
		movq	 $17, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_361_A
		movq	 $18, %r14
		cmpq	 %r13, %r14
		je	 case_without_branch_361_A
case_without_branch_361_A:
		movq	 $case_without_branch_string_361_A, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
case_void_branch_361:
		movq	 $case_void_string_361, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
case_exp_for_C_branch_259:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_263
		movq	 $dispatch_void_string_362, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_263:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		movq	 0(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_264
		movq	 $dispatch_void_string_362, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_264:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 96(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 32(%r12)
		jmp	 case_exp_end_branch_262
case_exp_for_A_branch_260:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 0(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_265
		movq	 $dispatch_void_string_363, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_265:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		movq	 0(%rbp), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_266
		movq	 $dispatch_void_string_363, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_266:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 72(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 32(%r12)
		jmp	 case_exp_end_branch_262
case_exp_for_Object_branch_261:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		call	 String..new
		popq	 %r12
		popq	 %rbp
		movq	 $string51, %r14
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
		pushq	 %rbp
		pushq	 %r12
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 16(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %rbp
		pushq	 %r12
		call	 Int..new
		popq	 %r12
		popq	 %rbp
		movq	 $0, %r14
		movq	 %r14, 24(%r13)
		jmp	 case_exp_end_branch_262
case_exp_end_branch_262:
end_branch_212:
		jmp	 end_branch_209
true_branch_207:
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		pushq	 %r12
		movq	 16(%r12), %r14
		movq	 88(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 A..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_267
		movq	 $dispatch_void_string_357, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_267:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 48(%r14), %r14
		call	 *%r14
		movq	 $16, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 40(%r12)
		pushq	 %rbp
		pushq	 %r12
		pushq	 %rbp
		pushq	 %r12
		movq	 32(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_268
		movq	 $dispatch_void_string_358, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_268:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		movq	 40(%r12), %r13
		cmpq	 $0, %r13
		jne	 non_void_branch_269
		movq	 $dispatch_void_string_358, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_269:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 40(%r14), %r14
		call	 *%r14
		movq	 $8, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		pushq	 %r13
		pushq	 %rbp
		pushq	 %r12
		call	 B..new
		popq	 %r12
		popq	 %rbp
		cmpq	 $0, %r13
		jne	 non_void_branch_270
		movq	 $dispatch_void_string_358, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
non_void_branch_270:
		pushq	 %r13
		movq	 16(%r13), %r14
		movq	 64(%r14), %r14
		call	 *%r14
		movq	 $24, %r14
		addq	 %r14, %rsp
		popq	 %r12
		popq	 %rbp
		movq	 %r13, 32(%r12)
end_branch_209:
		jmp	 while_predicate_branch_201
end_while_branch_202:
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
object_copy_loop_startbranch_271:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_272
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_271
object_copy_loop_endbranch_272:
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
object_copy_loop_startbranch_273:
		cmpq	 $0, %r14
		je	 object_copy_loop_endbranch_274
		movq	 0(%r12), %r15
		movq	 %r15, 0(%r13)
		movq	 $8, %r15
		addq	 %r15, %r12
		addq	 %r15, %r13
		movq	 $1, %r15
		subq	 %r15, %r14
		jmp	 object_copy_loop_startbranch_273
object_copy_loop_endbranch_274:
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
		jne	 substr_valid_branch_275
		movq	 $substr_bad, %r13
		## out_string
		movq	 %r13, %rdi ## move string pointer (just raw value in a String object) to rdi.
		## 16 byte align rsp before call
		andq	 $0xFFFFFFFFFFFFFFF0, %rsp
		call	 cooloutstr
		movl	 $0, %edi
		call	 exit
substr_valid_branch_275:
		movq	 %r13, 24(%r15)
		movq	 %r15, %r13
		movq	 %rbp, %rsp
		popq	 %rbp
		ret
dispatch_void_string_134:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 49 	 		## '1'		
		.byte	 51 	 		## '3'		
		.byte	 52 	 		## '4'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_398:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 57 	 		## '9'		
		.byte	 56 	 		## '8'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_399:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 57 	 		## '9'		
		.byte	 57 	 		## '9'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_408:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 52 	 		## '4'		
		.byte	 48 	 		## '0'		
		.byte	 56 	 		## '8'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_28:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 50 	 		## '2'		
		.byte	 56 	 		## '8'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_37:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 55 	 		## '7'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_422:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 52 	 		## '4'		
		.byte	 50 	 		## '2'		
		.byte	 50 	 		## '2'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_47:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 52 	 		## '4'		
		.byte	 55 	 		## '7'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_303:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 48 	 		## '0'		
		.byte	 51 	 		## '3'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_54:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 53 	 		## '5'		
		.byte	 52 	 		## '4'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_71:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 55 	 		## '7'		
		.byte	 49 	 		## '1'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_200:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 50 	 		## '2'		
		.byte	 48 	 		## '0'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_201:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 50 	 		## '2'		
		.byte	 48 	 		## '0'		
		.byte	 49 	 		## '1'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_202:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 50 	 		## '2'		
		.byte	 48 	 		## '0'		
		.byte	 50 	 		## '2'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_333:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 51 	 		## '3'		
		.byte	 51 	 		## '3'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_84:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 56 	 		## '8'		
		.byte	 52 	 		## '4'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_214:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 50 	 		## '2'		
		.byte	 49 	 		## '1'		
		.byte	 52 	 		## '4'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_218:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 50 	 		## '2'		
		.byte	 49 	 		## '1'		
		.byte	 56 	 		## '8'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_347:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 52 	 		## '4'		
		.byte	 55 	 		## '7'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_97:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 57 	 		## '9'		
		.byte	 55 	 		## '7'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_357:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 53 	 		## '5'		
		.byte	 55 	 		## '7'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_358:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 53 	 		## '5'		
		.byte	 56 	 		## '8'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_106:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 49 	 		## '1'		
		.byte	 48 	 		## '0'		
		.byte	 54 	 		## '6'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_235:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 50 	 		## '2'		
		.byte	 51 	 		## '3'		
		.byte	 53 	 		## '5'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_362:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 54 	 		## '6'		
		.byte	 50 	 		## '2'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_363:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 54 	 		## '6'		
		.byte	 51 	 		## '3'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_371:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 55 	 		## '7'		
		.byte	 49 	 		## '1'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_244:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 50 	 		## '2'		
		.byte	 52 	 		## '4'		
		.byte	 52 	 		## '4'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_372:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 55 	 		## '7'		
		.byte	 50 	 		## '2'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_374:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 55 	 		## '7'		
		.byte	 52 	 		## '4'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_376:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 55 	 		## '7'		
		.byte	 54 	 		## '6'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_378:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 55 	 		## '7'		
		.byte	 56 	 		## '8'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
dispatch_void_string_381:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 56 	 		## '8'		
		.byte	 49 	 		## '1'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 112 	 		## 'p'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
case_void_string_320:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 50 	 		## '2'		
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
		.byte	 99 	 		## 'c'		
		.byte	 97 	 		## 'a'		
		.byte	 115 	 		## 's'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
case_without_branch_string_320_A:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 50 	 		## '2'		
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
		.byte	 99 	 		## 'c'		
		.byte	 97 	 		## 'a'		
		.byte	 115 	 		## 's'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 119 	 		## 'w'		
		.byte	 105 	 		## 'i'		
		.byte	 116 	 		## 't'		
		.byte	 104 	 		## 'h'		
		.byte	 111 	 		## 'o'		
		.byte	 117 	 		## 'u'		
		.byte	 116 	 		## 't'		
		.byte	 32 	 		## ' '		
		.byte	 109 	 		## 'm'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 103 	 		## 'g'		
		.byte	 32 	 		## ' '		
		.byte	 98 	 		## 'b'		
		.byte	 114 	 		## 'r'		
		.byte	 97 	 		## 'a'		
		.byte	 110 	 		## 'n'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
case_void_string_361:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 54 	 		## '6'		
		.byte	 49 	 		## '1'		
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
		.byte	 99 	 		## 'c'		
		.byte	 97 	 		## 'a'		
		.byte	 115 	 		## 's'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 118 	 		## 'v'		
		.byte	 111 	 		## 'o'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
case_without_branch_string_361_A:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 54 	 		## '6'		
		.byte	 49 	 		## '1'		
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
		.byte	 99 	 		## 'c'		
		.byte	 97 	 		## 'a'		
		.byte	 115 	 		## 's'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 119 	 		## 'w'		
		.byte	 105 	 		## 'i'		
		.byte	 116 	 		## 't'		
		.byte	 104 	 		## 'h'		
		.byte	 111 	 		## 'o'		
		.byte	 117 	 		## 'u'		
		.byte	 116 	 		## 't'		
		.byte	 32 	 		## ' '		
		.byte	 109 	 		## 'm'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 103 	 		## 'g'		
		.byte	 32 	 		## ' '		
		.byte	 98 	 		## 'b'		
		.byte	 114 	 		## 'r'		
		.byte	 97 	 		## 'a'		
		.byte	 110 	 		## 'n'		
		.byte	 99 	 		## 'c'		
		.byte	 104 	 		## 'h'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
divide_by_zero_string_243:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 50 	 		## '2'		
		.byte	 52 	 		## '4'		
		.byte	 51 	 		## '3'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 118 	 		## 'v'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 105 	 		## 'i'		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 98 	 		## 'b'		
		.byte	 121 	 		## 'y'		
		.byte	 32 	 		## ' '		
		.byte	 122 	 		## 'z'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 111 	 		## 'o'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
divide_by_zero_string_133:
		.byte	 69 	 		## 'E'		
		.byte	 82 	 		## 'R'		
		.byte	 82 	 		## 'R'		
		.byte	 79 	 		## 'O'		
		.byte	 82 	 		## 'R'		
		.byte	 58 	 		## ':'		
		.byte	 32 	 		## ' '		
		.byte	 49 	 		## '1'		
		.byte	 51 	 		## '3'		
		.byte	 51 	 		## '3'		
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
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 118 	 		## 'v'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 105 	 		## 'i'		
		.byte	 111 	 		## 'o'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 98 	 		## 'b'		
		.byte	 121 	 		## 'y'		
		.byte	 32 	 		## ' '		
		.byte	 122 	 		## 'z'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 111 	 		## 'o'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
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
string23:
		.byte	 0 	 ## null char
string52:
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string25:
		.byte	 43 	 		## '+'		
		.byte	 0 	 ## null char
string24:
		.byte	 45 	 		## '-'		
		.byte	 0 	 ## null char
string27:
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 97 	 		## 'a'		
		.byte	 58 	 		## ':'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string29:
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 98 	 		## 'b'		
		.byte	 58 	 		## ':'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string33:
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 100 	 		## 'd'		
		.byte	 58 	 		## ':'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string35:
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 101 	 		## 'e'		
		.byte	 58 	 		## ':'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string37:
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 102 	 		## 'f'		
		.byte	 58 	 		## ':'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string13:
		.byte	 48 	 		## '0'		
		.byte	 0 	 ## null char
string14:
		.byte	 49 	 		## '1'		
		.byte	 0 	 ## null char
string15:
		.byte	 50 	 		## '2'		
		.byte	 0 	 ## null char
string16:
		.byte	 51 	 		## '3'		
		.byte	 0 	 ## null char
string17:
		.byte	 52 	 		## '4'		
		.byte	 0 	 ## null char
string18:
		.byte	 53 	 		## '5'		
		.byte	 0 	 ## null char
string19:
		.byte	 54 	 		## '6'		
		.byte	 0 	 ## null char
string20:
		.byte	 55 	 		## '7'		
		.byte	 0 	 ## null char
string21:
		.byte	 56 	 		## '8'		
		.byte	 0 	 ## null char
string22:
		.byte	 57 	 		## '9'		
		.byte	 0 	 ## null char
string1:
		.byte	 65 	 		## 'A'		
		.byte	 0 	 ## null char
string2:
		.byte	 65 	 		## 'A'		
		.byte	 50 	 		## '2'		
		.byte	 73 	 		## 'I'		
		.byte	 0 	 ## null char
string3:
		.byte	 66 	 		## 'B'		
		.byte	 0 	 ## null char
string4:
		.byte	 66 	 		## 'B'		
		.byte	 111 	 		## 'o'		
		.byte	 111 	 		## 'o'		
		.byte	 108 	 		## 'l'		
		.byte	 0 	 ## null char
string5:
		.byte	 67 	 		## 'C'		
		.byte	 0 	 ## null char
string46:
		.byte	 67 	 		## 'C'		
		.byte	 108 	 		## 'l'		
		.byte	 97 	 		## 'a'		
		.byte	 115 	 		## 's'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 116 	 		## 't'		
		.byte	 121 	 		## 'y'		
		.byte	 112 	 		## 'p'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 111 	 		## 'o'		
		.byte	 119 	 		## 'w'		
		.byte	 32 	 		## ' '		
		.byte	 65 	 		## 'A'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string47:
		.byte	 67 	 		## 'C'		
		.byte	 108 	 		## 'l'		
		.byte	 97 	 		## 'a'		
		.byte	 115 	 		## 's'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 116 	 		## 't'		
		.byte	 121 	 		## 'y'		
		.byte	 112 	 		## 'p'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 111 	 		## 'o'		
		.byte	 119 	 		## 'w'		
		.byte	 32 	 		## ' '		
		.byte	 66 	 		## 'B'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string48:
		.byte	 67 	 		## 'C'		
		.byte	 108 	 		## 'l'		
		.byte	 97 	 		## 'a'		
		.byte	 115 	 		## 's'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 116 	 		## 't'		
		.byte	 121 	 		## 'y'		
		.byte	 112 	 		## 'p'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 111 	 		## 'o'		
		.byte	 119 	 		## 'w'		
		.byte	 32 	 		## ' '		
		.byte	 67 	 		## 'C'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string49:
		.byte	 67 	 		## 'C'		
		.byte	 108 	 		## 'l'		
		.byte	 97 	 		## 'a'		
		.byte	 115 	 		## 's'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 116 	 		## 't'		
		.byte	 121 	 		## 'y'		
		.byte	 112 	 		## 'p'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 111 	 		## 'o'		
		.byte	 119 	 		## 'w'		
		.byte	 32 	 		## ' '		
		.byte	 68 	 		## 'D'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string50:
		.byte	 67 	 		## 'C'		
		.byte	 108 	 		## 'l'		
		.byte	 97 	 		## 'a'		
		.byte	 115 	 		## 's'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 116 	 		## 't'		
		.byte	 121 	 		## 'y'		
		.byte	 112 	 		## 'p'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 111 	 		## 'o'		
		.byte	 119 	 		## 'w'		
		.byte	 32 	 		## ' '		
		.byte	 69 	 		## 'E'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string6:
		.byte	 68 	 		## 'D'		
		.byte	 0 	 ## null char
string7:
		.byte	 69 	 		## 'E'		
		.byte	 0 	 ## null char
string8:
		.byte	 73 	 		## 'I'		
		.byte	 79 	 		## 'O'		
		.byte	 0 	 ## null char
string9:
		.byte	 73 	 		## 'I'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 0 	 ## null char
string10:
		.byte	 77 	 		## 'M'		
		.byte	 97 	 		## 'a'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string11:
		.byte	 79 	 		## 'O'		
		.byte	 98 	 		## 'b'		
		.byte	 106 	 		## 'j'		
		.byte	 101 	 		## 'e'		
		.byte	 99 	 		## 'c'		
		.byte	 116 	 		## 't'		
		.byte	 0 	 ## null char
string51:
		.byte	 79 	 		## 'O'		
		.byte	 111 	 		## 'o'		
		.byte	 111 	 		## 'o'		
		.byte	 111 	 		## 'o'		
		.byte	 112 	 		## 'p'		
		.byte	 115 	 		## 's'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string45:
		.byte	 80 	 		## 'P'		
		.byte	 108 	 		## 'l'		
		.byte	 101 	 		## 'e'		
		.byte	 97 	 		## 'a'		
		.byte	 115 	 		## 's'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 97 	 		## 'a'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 117 	 		## 'u'		
		.byte	 109 	 		## 'm'		
		.byte	 98 	 		## 'b'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 32 	 		## ' '		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string12:
		.byte	 83 	 		## 'S'		
		.byte	 116 	 		## 't'		
		.byte	 114 	 		## 'r'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 103 	 		## 'g'		
		.byte	 0 	 ## null char
string44:
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string26:
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 92 	 		## '\\'		
		.byte	 116 	 		## 't'		
		.byte	 84 	 		## 'T'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 97 	 		## 'a'		
		.byte	 100 	 		## 'd'		
		.byte	 100 	 		## 'd'		
		.byte	 32 	 		## ' '		
		.byte	 97 	 		## 'a'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 117 	 		## 'u'		
		.byte	 109 	 		## 'm'		
		.byte	 98 	 		## 'b'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 116 	 		## 't'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string36:
		.byte	 92 	 		## '\\'		
		.byte	 116 	 		## 't'		
		.byte	 84 	 		## 'T'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 99 	 		## 'c'		
		.byte	 117 	 		## 'u'		
		.byte	 98 	 		## 'b'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string40:
		.byte	 92 	 		## '\\'		
		.byte	 116 	 		## 't'		
		.byte	 84 	 		## 'T'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 118 	 		## 'v'		
		.byte	 105 	 		## 'i'		
		.byte	 100 	 		## 'd'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string38:
		.byte	 92 	 		## '\\'		
		.byte	 116 	 		## 't'		
		.byte	 84 	 		## 'T'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 102 	 		## 'f'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 100 	 		## 'd'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 117 	 		## 'u'		
		.byte	 116 	 		## 't'		
		.byte	 32 	 		## ' '		
		.byte	 105 	 		## 'i'		
		.byte	 102 	 		## 'f'		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string30:
		.byte	 92 	 		## '\\'		
		.byte	 116 	 		## 't'		
		.byte	 84 	 		## 'T'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 102 	 		## 'f'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 100 	 		## 'd'		
		.byte	 32 	 		## ' '		
		.byte	 116 	 		## 't'		
		.byte	 104 	 		## 'h'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 102 	 		## 'f'		
		.byte	 102 	 		## 'f'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 99 	 		## 'c'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 98 	 		## 'b'		
		.byte	 101 	 		## 'e'		
		.byte	 116 	 		## 't'		
		.byte	 119 	 		## 'w'		
		.byte	 101 	 		## 'e'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string32:
		.byte	 92 	 		## '\\'		
		.byte	 116 	 		## 't'		
		.byte	 84 	 		## 'T'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 102 	 		## 'f'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 100 	 		## 'd'		
		.byte	 32 	 		## ' '		
		.byte	 116 	 		## 't'		
		.byte	 104 	 		## 'h'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 102 	 		## 'f'		
		.byte	 97 	 		## 'a'		
		.byte	 99 	 		## 'c'		
		.byte	 116 	 		## 't'		
		.byte	 111 	 		## 'o'		
		.byte	 114 	 		## 'r'		
		.byte	 105 	 		## 'i'		
		.byte	 97 	 		## 'a'		
		.byte	 108 	 		## 'l'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 102 	 		## 'f'		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string42:
		.byte	 92 	 		## '\\'		
		.byte	 116 	 		## 't'		
		.byte	 84 	 		## 'T'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 103 	 		## 'g'		
		.byte	 101 	 		## 'e'		
		.byte	 116 	 		## 't'		
		.byte	 32 	 		## ' '		
		.byte	 97 	 		## 'a'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 101 	 		## 'e'		
		.byte	 119 	 		## 'w'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 117 	 		## 'u'		
		.byte	 109 	 		## 'm'		
		.byte	 98 	 		## 'b'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 106 	 		## 'j'		
		.byte	 58 	 		## ':'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string28:
		.byte	 92 	 		## '\\'		
		.byte	 116 	 		## 't'		
		.byte	 84 	 		## 'T'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 101 	 		## 'e'		
		.byte	 103 	 		## 'g'		
		.byte	 97 	 		## 'a'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string43:
		.byte	 92 	 		## '\\'		
		.byte	 116 	 		## 't'		
		.byte	 84 	 		## 'T'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 113 	 		## 'q'		
		.byte	 117 	 		## 'u'		
		.byte	 105 	 		## 'i'		
		.byte	 116 	 		## 't'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 113 	 		## 'q'		
		.byte	 58 	 		## ':'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string34:
		.byte	 92 	 		## '\\'		
		.byte	 116 	 		## 't'		
		.byte	 84 	 		## 'T'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 115 	 		## 's'		
		.byte	 113 	 		## 'q'		
		.byte	 117 	 		## 'u'		
		.byte	 97 	 		## 'a'		
		.byte	 114 	 		## 'r'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string56:
		.byte	 97 	 		## 'a'		
		.byte	 0 	 ## null char
string31:
		.byte	 97 	 		## 'a'		
		.byte	 110 	 		## 'n'		
		.byte	 100 	 		## 'd'		
		.byte	 32 	 		## ' '		
		.byte	 97 	 		## 'a'		
		.byte	 110 	 		## 'n'		
		.byte	 111 	 		## 'o'		
		.byte	 116 	 		## 't'		
		.byte	 104 	 		## 'h'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 117 	 		## 'u'		
		.byte	 109 	 		## 'm'		
		.byte	 98 	 		## 'b'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 99 	 		## 'c'		
		.byte	 58 	 		## ':'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string57:
		.byte	 98 	 		## 'b'		
		.byte	 0 	 ## null char
string41:
		.byte	 98 	 		## 'b'		
		.byte	 121 	 		## 'y'		
		.byte	 32 	 		## ' '		
		.byte	 56 	 		## '8'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 104 	 		## 'h'		
		.byte	 58 	 		## ':'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string58:
		.byte	 99 	 		## 'c'		
		.byte	 0 	 ## null char
string59:
		.byte	 100 	 		## 'd'		
		.byte	 0 	 ## null char
string60:
		.byte	 101 	 		## 'e'		
		.byte	 0 	 ## null char
string61:
		.byte	 102 	 		## 'f'		
		.byte	 0 	 ## null char
string62:
		.byte	 103 	 		## 'g'		
		.byte	 0 	 ## null char
string63:
		.byte	 104 	 		## 'h'		
		.byte	 0 	 ## null char
string39:
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 97 	 		## 'a'		
		.byte	 32 	 		## ' '		
		.byte	 109 	 		## 'm'		
		.byte	 117 	 		## 'u'		
		.byte	 108 	 		## 'l'		
		.byte	 116 	 		## 't'		
		.byte	 105 	 		## 'i'		
		.byte	 112 	 		## 'p'		
		.byte	 108 	 		## 'l'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 102 	 		## 'f'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 46 	 		## '.'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 116 	 		## 't'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 103 	 		## 'g'		
		.byte	 58 	 		## ':'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string69:
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 118 	 		## 'v'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 105 	 		## 'i'		
		.byte	 98 	 		## 'b'		
		.byte	 108 	 		## 'l'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 98 	 		## 'b'		
		.byte	 121 	 		## 'y'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 46 	 		## '.'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string66:
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 101 	 		## 'e'		
		.byte	 113 	 		## 'q'		
		.byte	 117 	 		## 'u'		
		.byte	 97 	 		## 'a'		
		.byte	 108 	 		## 'l'		
		.byte	 32 	 		## ' '		
		.byte	 116 	 		## 't'		
		.byte	 111 	 		## 'o'		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string55:
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 101 	 		## 'e'		
		.byte	 118 	 		## 'v'		
		.byte	 101 	 		## 'e'		
		.byte	 110 	 		## 'n'		
		.byte	 33 	 		## '!'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string68:
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 110 	 		## 'n'		
		.byte	 111 	 		## 'o'		
		.byte	 116 	 		## 't'		
		.byte	 32 	 		## ' '		
		.byte	 100 	 		## 'd'		
		.byte	 105 	 		## 'i'		
		.byte	 118 	 		## 'v'		
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 105 	 		## 'i'		
		.byte	 98 	 		## 'b'		
		.byte	 108 	 		## 'l'		
		.byte	 101 	 		## 'e'		
		.byte	 32 	 		## ' '		
		.byte	 98 	 		## 'b'		
		.byte	 121 	 		## 'y'		
		.byte	 32 	 		## ' '		
		.byte	 51 	 		## '3'		
		.byte	 46 	 		## '.'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string54:
		.byte	 105 	 		## 'i'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 100 	 		## 'd'		
		.byte	 100 	 		## 'd'		
		.byte	 33 	 		## '!'		
		.byte	 92 	 		## '\\'		
		.byte	 110 	 		## 'n'		
		.byte	 0 	 ## null char
string64:
		.byte	 106 	 		## 'j'		
		.byte	 0 	 ## null char
string53:
		.byte	 110 	 		## 'n'		
		.byte	 117 	 		## 'u'		
		.byte	 109 	 		## 'm'		
		.byte	 98 	 		## 'b'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 0 	 ## null char
string65:
		.byte	 113 	 		## 'q'		
		.byte	 0 	 ## null char
string67:
		.byte	 116 	 		## 't'		
		.byte	 105 	 		## 'i'		
		.byte	 109 	 		## 'm'		
		.byte	 101 	 		## 'e'		
		.byte	 115 	 		## 's'		
		.byte	 32 	 		## ' '		
		.byte	 56 	 		## '8'		
		.byte	 32 	 		## ' '		
		.byte	 119 	 		## 'w'		
		.byte	 105 	 		## 'i'		
		.byte	 116 	 		## 't'		
		.byte	 104 	 		## 'h'		
		.byte	 32 	 		## ' '		
		.byte	 97 	 		## 'a'		
		.byte	 32 	 		## ' '		
		.byte	 114 	 		## 'r'		
		.byte	 101 	 		## 'e'		
		.byte	 109 	 		## 'm'		
		.byte	 97 	 		## 'a'		
		.byte	 105 	 		## 'i'		
		.byte	 110 	 		## 'n'		
		.byte	 100 	 		## 'd'		
		.byte	 101 	 		## 'e'		
		.byte	 114 	 		## 'r'		
		.byte	 32 	 		## ' '		
		.byte	 111 	 		## 'o'		
		.byte	 102 	 		## 'f'		
		.byte	 32 	 		## ' '		
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
