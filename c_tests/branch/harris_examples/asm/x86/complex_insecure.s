	.file	"complex_insecure.c"
	.text
	.globl	basic_comp
	.type	basic_comp, @function
basic_comp:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$1, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	branch_check
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	basic_comp, .-basic_comp
	.section	.rodata
.LC0:
	.string	"Executing critical code... "
.LC1:
	.string	"Exiting out... "
	.text
	.globl	branch_check
	.type	branch_check, @function
branch_check:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$1, -4(%rbp)
	jne	.L3
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L4
.L3:
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
.L4:
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	branch_check, .-branch_check
	.section	.rodata
	.align 8
.LC2:
	.string	"Both x < y and condition are true. "
	.align 8
.LC3:
	.string	"Both x < y and condition are false. "
	.align 8
.LC4:
	.string	"Either anothercondition or z > y is true and condition is true. "
	.align 8
.LC5:
	.string	"Either anothercondition or z > y is true but condition is false. "
	.align 8
.LC6:
	.string	"Both anotherCondition and z > y are false."
	.text
	.globl	adv_comp
	.type	adv_comp, @function
adv_comp:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	$1, -20(%rbp)
	movl	$8, -16(%rbp)
	movl	$10, -12(%rbp)
	movl	-16(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.L7
	movl	-20(%rbp), %eax
	movl	%eax, %edi
	call	branch_check
	testl	%eax, %eax
	je	.L7
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L8
.L7:
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
.L8:
	movl	$0, -8(%rbp)
	movl	$12, -4(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, %edi
	call	branch_check
	testl	%eax, %eax
	jne	.L9
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jle	.L10
.L9:
	movl	-20(%rbp), %eax
	movl	%eax, %edi
	call	branch_check
	testl	%eax, %eax
	je	.L11
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L13
.L11:
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L13
.L10:
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
.L13:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	adv_comp, .-adv_comp
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
