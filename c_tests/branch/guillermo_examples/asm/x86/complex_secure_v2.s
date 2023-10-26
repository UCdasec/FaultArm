	.file	"complex_secure.c"
	.text
	.section	.rodata
.LC0:
	.string	"Flag 1 is set."
.LC1:
	.string	"Flag 1 is not set."
.LC2:
	.string	"Flag 2 is set."
.LC3:
	.string	"Flag 2 is not set."
.LC4:
	.string	"Flag 3 is set."
.LC5:
	.string	"Flag 3 is not set."
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	rsp, rbp
	.cfi_def_cfa_register 6
	subq	$16, rsp
	movl	$43981, -4(rbp)
	movl	-4(rbp), eax
	andl	$3840, eax
	cmpl	$256, eax
	jne	.L2
	leaq	.LC0(rip), rdi
	call	puts@PLT
	jmp	.L3
.L2:
	leaq	.LC1(rip), rdi
	call	puts@PLT
.L3:
	movl	-4(rbp), eax
	andl	$240, eax
	cmpl	$160, eax
	jne	.L4
	leaq	.LC2(rip), rdi
	call	puts@PLT
	jmp	.L5
.L4:
	leaq	.LC3(rip), rdi
	call	puts@PLT
.L5:
	movl	-4(rbp), eax
	andl	$15, eax
	cmpl	$13, eax
	jne	.L6
	leaq	.LC4(rip), rdi
	call	puts@PLT
	jmp	.L7
.L6:
	leaq	.LC5(rip), rdi
	call	puts@PLT
.L7:
	movl	$0, eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
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
