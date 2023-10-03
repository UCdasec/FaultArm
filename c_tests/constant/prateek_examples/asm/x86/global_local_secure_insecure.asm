	.file	"global_local_secure_insecure.c"
	.text
	.globl	global_secure
	.data
	.align 4
	.type	global_secure, @object
	.size	global_secure, 4
global_secure:
	.long	255
	.globl	global_insecure
	.align 4
	.type	global_insecure, @object
	.size	global_insecure, 4
global_insecure:
	.long	1
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
	subq	$48, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$16, -36(%rbp)
	movw	$-1, -38(%rbp)
	movl	$1, -32(%rbp)
	movl	$2, -28(%rbp)
	movl	$4, -24(%rbp)
	movl	$8, -20(%rbp)
	movl	$16, -16(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	printNumber
	movl	global_insecure(%rip), %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	printNumber
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L3
	call	__stack_chk_fail@PLT
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
.LC0:
	.string	"%d"
	.text
	.globl	printNumber
	.type	printNumber, @function
printNumber:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	printNumber, .-printNumber
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
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
