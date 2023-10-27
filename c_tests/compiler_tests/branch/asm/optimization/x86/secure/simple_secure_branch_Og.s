	.file	"simple_secure_branch.c"
	.text
	.globl	foo
	.type	foo, @function
foo:
.LFB23:
	.cfi_startproc
	endbr64
	movl	$15525, (%rdi)
	ret
	.cfi_endproc
.LFE23:
	.size	foo, .-foo
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Executing critical code..."
.LC1:
	.string	"Exiting out..."
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
	movl	$0, 4(%rsp)
	leaq	4(%rsp), %rdi
	call	foo
	cmpl	$15525, 4(%rsp)
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
