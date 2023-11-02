	.file	"rate_limiting_brute_force.c"
	.text
	.section	.rodata
.LC0:
	.string	"secure123"
	.text
	.globl	check_password
	.type	check_password, @function
check_password:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	leaq	.LC0(%rip), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	check_password, .-check_password
	.section	.rodata
.LC1:
	.string	"Enter password: "
.LC2:
	.string	"%49s"
.LC3:
	.string	"Access granted."
.LC4:
	.string	"Access denied."
.LC5:
	.string	"Too many incorrect attempts."
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -68(%rbp)
	jmp	.L4
.L7:
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-64(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	check_password
	testl	%eax, %eax
	je	.L5
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L8
.L5:
	leaq	.LC4(%rip), %rdi
	call	puts@PLT
	addl	$1, -68(%rbp)
	movl	$1, %edi
	call	sleep@PLT
.L4:
	cmpl	$2, -68(%rbp)
	jle	.L7
	leaq	.LC5(%rip), %rdi
	call	puts@PLT
	movl	$1, %eax
.L8:
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
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
