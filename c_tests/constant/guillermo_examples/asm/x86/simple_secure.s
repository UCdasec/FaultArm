	.file	"simple_secure.c"
	.text
	.data
	.align 2
	.type	STATE_INIT, @object
	.size	STATE_INIT, 2
STATE_INIT:
	.value	23100
	.align 2
	.type	STATE_PERSO, @object
	.size	STATE_PERSO, 2
STATE_PERSO:
	.value	-23101
	.align 2
	.type	STATE_ISSUED, @object
	.size	STATE_ISSUED, 2
STATE_ISSUED:
	.value	15450
	.align 2
	.type	STATE_LOCKED, @object
	.size	STATE_LOCKED, 2
STATE_LOCKED:
	.value	-15451
	.align 2
	.type	closeHamming1, @object
	.size	closeHamming1, 2
closeHamming1:
	.value	13107
	.align 2
	.type	closeHamming2, @object
	.size	closeHamming2, 2
closeHamming2:
	.value	13106
	.section	.rodata
.LC0:
	.string	"Constant coding example."
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
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$1012, -12(%rbp)
	movl	$1000, -8(%rbp)
	movl	$3000, -4(%rbp)
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
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
