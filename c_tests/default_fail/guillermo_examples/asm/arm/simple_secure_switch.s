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
	.file	"simple_secure_switch.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Zero\000"
	.align	2
.LC1:
	.ascii	"One\000"
	.align	2
.LC2:
	.ascii	"Two\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	mov	r3, #1
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	beq	.L2
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	bgt	.L3
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L4
	ldr	r3, [fp, #-8]
	cmp	r3, #1
	beq	.L5
	b	.L3
.L4:
	ldr	r0, .L7
	bl	printf
	b	.L3
.L5:
	ldr	r0, .L7+4
	bl	printf
	b	.L3
.L2:
	ldr	r0, .L7+8
	bl	printf
	nop
.L3:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L8:
	.align	2
.L7:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
