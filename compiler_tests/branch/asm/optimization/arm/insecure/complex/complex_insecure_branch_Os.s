	.arch armv5t
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 4
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
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC0:
	.ascii	"Access granted.\000"
.LC1:
	.ascii	"Access denied.\000"
	.section	.rodata.cst4,"aM",%progbits,4
	.align	2
.LC2:
	.word	__stack_chk_guard
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, lr}
	ldr	r3, .L7
	ldr	r3, [r3]
	str	r3, [sp, #4]
	mov	r3,#0
	bl	getchar
	str	r0, [sp]
	mov	r0, sp
	bl	foo
	cmp	r0, #1
	bne	.L3
	ldr	r0, .L7+4
	bl	puts
	mov	r0, #0
.L2:
	ldr	r3, .L7
	ldr	r2, [r3]
	ldr	r3, [sp, #4]
	eors	r2, r3, r2
	mov	r3, #0
	beq	.L5
	bl	__stack_chk_fail
.L3:
	ldr	r0, .L7+8
	bl	puts
	mov	r0, #1
	b	.L2
.L5:
	add	sp, sp, #12
	@ sp needed
	ldr	pc, [sp], #4
.L8:
	.align	2
.L7:
	.word	.LC2
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
