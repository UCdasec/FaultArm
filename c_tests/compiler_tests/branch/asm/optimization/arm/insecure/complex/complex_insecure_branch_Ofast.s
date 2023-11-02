	.arch armv5t
	.eabi_attribute 23, 1
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"complex_insecure_branch.c"
	.text
	.align	2
	.global	foo
	.syntax unified
	.arm
	.fpu softvfp
	.type	foo, %function
foo:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0]
	add	r3, r3, #1
	str	r3, [r0]
	subs	r0, r3, #1
	movne	r0, #1
	bx	lr
	.size	foo, .-foo
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Access denied.\000"
	.align	2
.LC1:
	.ascii	"Access granted.\000"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L8
	push	{r4, lr}
	ldr	r0, [r3]
	bl	getc
	cmp	r0, #0
	beq	.L7
	ldr	r0, .L8+4
	bl	puts
	mov	r0, #0
	pop	{r4, pc}
.L7:
	ldr	r0, .L8+8
	bl	puts
	mov	r0, #1
	pop	{r4, pc}
.L9:
	.align	2
.L8:
	.word	stdin
	.word	.LC1
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
