	.file	"simple_secure_branch.c"
	.text
	.globl	foo
	.type	foo, @function
foo:
.LFB13:
	.cfi_startproc
	endbr64
	movl	$15525, (%rdi)
	ret
	.cfi_endproc
.LFE13:
	.size	foo, .-foo
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Executing critical code..."
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rax
	.cfi_def_cfa_offset 16
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	xorl	%eax, %eax
	popq	%rdx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE14:
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
