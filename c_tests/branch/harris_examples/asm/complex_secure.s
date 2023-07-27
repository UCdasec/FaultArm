	.file	"complex_secure.c"
	.text
	.section	.rodata
.LC0:
	.string	"%x, %x, %x, %x, %x"
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
	movl	$43981, -4(%rbp)
	movl	-4(%rbp), %eax
	andl	$15, %eax
	movl	%eax, %esi
	movl	-4(%rbp), %eax
	andl	$240, %eax
	movl	%eax, %ecx
	movl	-4(%rbp), %eax
	andl	$3840, %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	movl	%esi, %r9d
	movl	%ecx, %r8d
	movl	%edx, %ecx
	movl	$3840, %edx
	movl	%eax, %esi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
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
