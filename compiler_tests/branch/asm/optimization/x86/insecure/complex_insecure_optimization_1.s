	.file	"complex_insecure_branch.c"
	.text
	.globl	checkPassword
	.type	checkPassword, @function
checkPassword:
.LFB23:
	.cfi_startproc
	endbr64
	movl	(%rdi), %eax
	addl	$1, %eax
	movl	%eax, (%rdi)
	cmpl	$1, %eax
	setne	%al
	movzbl	%al, %eax
	ret
	.cfi_endproc
.LFE23:
	.size	checkPassword, .-checkPassword
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Access granted."
.LC1:
	.string	"Access denied."
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movq	stdin(%rip), %rdi
	call	getc@PLT
	movl	%eax, 4(%rsp)
	leaq	4(%rsp), %rdi
	call	checkPassword
	cmpl	$1, %eax
	jne	.L3
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
.L2:
	movq	8(%rsp), %rdx
	xorq	%fs:40, %rdx
	jne	.L7
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L3:
	.cfi_restore_state
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movl	$1, %eax
	jmp	.L2
.L7:
	call	__stack_chk_fail@PLT
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
