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
	.file	"simple_secure_branch.c"
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
	ldr	r3, .L2
	str	r3, [r0]
	bx	lr
.L3:
	.align	2
.L2:
	.word	15525
	.size	foo, .-foo
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Executing critical code...\000"
	.align	2
.LC1:
	.ascii	"Exiting out...\000"
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
	ldr	r3, .L10
	ldr	r3, [r3]
	str	r3, [sp, #4]
	mov	r3,#0
	mov	r3, #0
	str	r3, [sp]
	mov	r0, sp
	bl	foo
	ldr	r2, [sp]
	ldr	r3, .L10+4
	cmp	r2, r3
	bne	.L5
	ldr	r0, .L10+8
	bl	puts
	mov	r0, #0
.L4:
	ldr	r3, .L10
	ldr	r2, [r3]
	ldr	r3, [sp, #4]
	eors	r2, r3, r2
	mov	r3, #0
	bne	.L9
	add	sp, sp, #12
	@ sp needed
	ldr	pc, [sp], #4
.L5:
	ldr	r0, .L10+12
	bl	puts
	mov	r0, #1
	b	.L4
.L9:
	bl	__stack_chk_fail
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
