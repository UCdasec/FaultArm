	.file	"complex_insecure.c"
	.text
	.section	.rodata
.LC0:
	.string	"Condition is true."
.LC1:
	.string	"Condition is false."
.LC2:
	.string	"Another condition is true."
.LC3:
	.string	"Another condition is false."
	.text
	.globl	basic_comp
	.type	basic_comp, @function
basic_comp:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	rsp, rbp
	.cfi_def_cfa_register 6
	subq	$16, rsp
	movl	$1, -8(rbp)
	cmpl	$1, -8(rbp)
	jne	.L2
	leaq	.LC0(rip), rdi
	call	puts@PLT
	jmp	.L3
.L2:
	leaq	.LC1(rip), rdi
	call	puts@PLT
.L3:
	movl	$0, -4(rbp)
	cmpl	$0, -4(rbp)
	je	.L4
	leaq	.LC2(rip), rdi
	call	puts@PLT
	jmp	.L5
.L4:
	leaq	.LC3(rip), rdi
	call	puts@PLT
.L5:
	movl	$0, eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	basic_comp, .-basic_comp
	.section	.rodata
	.align 8
.LC4:
	.string	"Both condition and x < y are true."
	.align 8
.LC5:
	.string	"Either condition or x < y is false."
	.align 8
.LC6:
	.string	"Either anotherCondition or z > y is true."
	.align 8
.LC7:
	.string	"Both anotherCondition and z > y are false."
.LC8:
	.string	"x is equal to y."
.LC9:
	.string	"x is not equal to y."
	.text
	.globl	advanced_comp
	.type	advanced_comp, @function
advanced_comp:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	rsp, rbp
	.cfi_def_cfa_register 6
	subq	$32, rsp
	movl	$1, -24(rbp)
	movl	$5, -20(rbp)
	movl	$10, -16(rbp)
	cmpl	$0, -24(rbp)
	je	.L8
	movl	-20(rbp), eax
	cmpl	-16(rbp), eax
	jge	.L8
	leaq	.LC4(rip), rdi
	call	puts@PLT
	jmp	.L9
.L8:
	leaq	.LC5(rip), rdi
	call	puts@PLT
.L9:
	movl	$0, -12(rbp)
	movl	$15, -8(rbp)
	cmpl	$0, -12(rbp)
	jne	.L10
	movl	-8(rbp), eax
	cmpl	-16(rbp), eax
	jle	.L11
.L10:
	leaq	.LC6(rip), rdi
	call	puts@PLT
	jmp	.L12
.L11:
	leaq	.LC7(rip), rdi
	call	puts@PLT
.L12:
	movl	-20(rbp), eax
	cmpl	-16(rbp), eax
	sete	al
	movzbl	al, eax
	movl	eax, -4(rbp)
	cmpl	$0, -4(rbp)
	je	.L13
	leaq	.LC8(rip), rdi
	call	puts@PLT
	jmp	.L14
.L13:
	leaq	.LC9(rip), rdi
	call	puts@PLT
.L14:
	movl	$0, eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	advanced_comp, .-advanced_comp
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
