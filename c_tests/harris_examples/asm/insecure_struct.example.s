	.file	"insecure_struct.example.c"
	.text
	.section	.rodata
.LC0:
	.string	"Execute critical code"
.LC1:
	.string	"Do not execute critical code"
.LC2:
	.string	"both conditions are true"
.LC3:
	.string	"neither conditions are true"
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
	subq	$16, %rsp
	movl	$10, -16(%rbp)
	movl	$12, -12(%rbp)
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %eax
	cmpl	%eax, %edx
	jge	.L2
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
	movl	$30, -8(%rbp)
	movl	$15, -4(%rbp)
	movl	-16(%rbp), %edx
	movl	-4(%rbp), %eax
	cmpl	%eax, %edx
	jge	.L4
	movl	-8(%rbp), %edx
	movl	-12(%rbp), %eax
	cmpl	%eax, %edx
	jle	.L4
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
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
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
