	.arch armv5t
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"simple_secure_branch.c"
	.text
	.align	2
	.global	foo
	.syntax unified
	.arm
	.fpu softvfp
	.type	foo, %function
foo:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r3, .L2
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	add	r2, r3, #2
	ldr	r3, [fp, #-16]
	str	r2, [r3]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L3:
	.align	2
.L2:
	.word	15523
	.size	foo, .-foo
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Executing critical code...\000"
	.align	2
.LC1:
	.ascii	"Exiting out...\000"
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
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r3, .L10
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3,#0
	mov	r3, #0
	str	r3, [fp, #-12]
	sub	r3, fp, #12
	mov	r0, r3
	bl	foo
	ldr	r3, [fp, #-12]
	ldr	r2, .L10+4
	cmp	r3, r2
	bne	.L5
	ldr	r0, .L10+8
	bl	puts
	mov	r3, #0
	b	.L8
.L5:
	ldr	r0, .L10+12
	bl	puts
	mov	r3, #1
.L8:
	ldr	r2, .L10
	ldr	r1, [r2]
	ldr	r2, [fp, #-8]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L9
	bl	__stack_chk_fail
.L9:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L11:
	.align	2
.L10:
	.word	.LC2
	.word	15525
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
