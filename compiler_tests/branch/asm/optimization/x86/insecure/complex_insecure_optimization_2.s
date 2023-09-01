	.file	"complex_insecure_branch.c"
	.text
	.p2align 4
	.globl	checkPassword
	.type	checkPassword, @function
checkPassword:
.LFB23:
	.cfi_startproc
	endbr64
	movl	(%rdi), %eax
	addl	$1, %eax
	cmpl	$1, %eax
	movl	%eax, (%rdi)
	setne	%al
	movzbl	%al, %eax
	ret
	.cfi_endproc
.LFE23:
	.size	checkPassword, .-checkPassword
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Access denied."
.LC1:
	.string	"Access granted."
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	stdin(%rip), %rdi
	call	getc@PLT
	testl	%eax, %eax
	je	.L7
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	xorl	%eax, %eax
.L3:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L7:
	.cfi_restore_state
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$1, %eax
	jmp	.L3
	.cfi_endproc
.LFE24:
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
