	.file	"complex_insecure_branch.c"
	.text
	.globl	foo
	.type	foo, @function
foo:
.LFB13:
	.cfi_startproc
	endbr64
	movl	(%rdi), %eax
	incl	%eax
	movl	%eax, (%rdi)
	decl	%eax
	setne	%al
	movzbl	%al, %eax
	ret
	.cfi_endproc
.LFE13:
	.size	foo, .-foo
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Access granted."
.LC1:
	.string	"Access denied."
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB14:
	.cfi_startproc
	endbr64
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	call	getchar@PLT
	leaq	4(%rsp), %rdi
	movl	%eax, 4(%rsp)
	call	foo
	decl	%eax
	jne	.L3
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	xorl	%eax, %eax
	jmp	.L2
.L3:
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movl	$1, %eax
.L2:
	movq	8(%rsp), %rdx
	xorq	%fs:40, %rdx
	je	.L5
	call	__stack_chk_fail@PLT
.L5:
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE14:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
