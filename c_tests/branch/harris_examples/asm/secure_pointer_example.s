	.file	"secure_pointer_example.c"
	.text
	.section	.rodata
.LC0:
	.string	"Execute critcal code"
.LC1:
	.string	"Do not excute critical code"
.LC2:
	.string	"Both x < z and *p are true"
.LC3:
	.string	"Neither x < z and *p are true"
	.align 8
.LC4:
	.string	"Either x < z or *p > x are true"
	.align 8
.LC5:
	.string	"Neither x < z or *p > x are true"
.LC6:
	.string	"x * z is greater than *p"
.LC7:
	.string	"x * z is less than *p"
.LC9:
	.string	"y is less than x"
.LC10:
	.string	"y is greater than x"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
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
	movl	$16200, -32(%rbp)
	leaq	-32(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movl	(%rax), %edx
	movl	-32(%rbp), %eax
	cmpl	%eax, %edx
	jle	.L2
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L3
.L2:
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L3:
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -28(%rbp)
	movl	-32(%rbp), %eax
	cmpl	%eax, -28(%rbp)
	jle	.L4
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	je	.L4
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L5
.L4:
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L5:
	movl	-32(%rbp), %eax
	cmpl	%eax, -28(%rbp)
	jg	.L6
	movq	-16(%rbp), %rax
	movl	(%rax), %edx
	movl	-32(%rbp), %eax
	cmpl	%eax, %edx
	jle	.L7
.L6:
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L8
.L7:
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L8:
	movl	-32(%rbp), %eax
	imull	-28(%rbp), %eax
	movl	%eax, %edx
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jle	.L9
	movl	$16204, %eax
	jmp	.L10
.L9:
	movl	$16203, %eax
.L10:
	movl	%eax, -24(%rbp)
	cmpl	$0, -24(%rbp)
	je	.L11
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L12
.L11:
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L12:
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%eax, %xmm2
	movq	%xmm2, %rax
	movsd	.LC8(%rip), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	cvttsd2sil	%xmm0, %eax
	movl	%eax, -20(%rbp)
	movl	-32(%rbp), %eax
	cmpl	%eax, -20(%rbp)
	jge	.L13
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L14
.L13:
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L14:
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L16
	call	__stack_chk_fail@PLT
.L16:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC8:
	.long	0
	.long	1073741824
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04.1) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
