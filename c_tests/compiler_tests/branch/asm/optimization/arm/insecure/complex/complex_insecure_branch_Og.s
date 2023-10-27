	.arch armv5t
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 1
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
	cmp	r3, #1
	beq	.L4
	mov	r0, #1
	bx	lr
.L4:
	mov	r0, #0
	bx	lr
	.size	foo, .-foo
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Access granted.\000"
	.align	2
.LC1:
	.ascii	"Access denied.\000"
	.section	.rodata.cst4,"aM",%progbits,4
	.align	2
.LC2:
	.word	__stack_chk_guard
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #12
	ldr	r3, .L11
	ldr	r3, [r3]
	str	r3, [sp, #4]
	mov	r3,#0
	ldr	r3, .L11+4
	ldr	r0, [r3]
	bl	getc
	str	r0, [sp]
	mov	r0, sp
	bl	foo
	cmp	r0, #1
	bne	.L6
	ldr	r0, .L11+8
	bl	puts
	mov	r0, #0
.L5:
	ldr	r3, .L11
	ldr	r2, [r3]
	ldr	r3, [sp, #4]
	eors	r2, r3, r2
	mov	r3, #0
	bne	.L10
	add	sp, sp, #12
	@ sp needed
	ldr	pc, [sp], #4
.L6:
	ldr	r0, .L11+12
	bl	puts
	mov	r0, #1
	b	.L5
.L10:
	bl	__stack_chk_fail
.L12:
	.align	2
.L11:
	.word	.LC2
	.word	stdin
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
