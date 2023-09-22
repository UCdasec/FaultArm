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
	.file	"simple_insecure.c"
	.text
	.data
	.align	1
	.type	trivial_1, %object
	.size	trivial_1, 2
trivial_1:
	.short	255
	.align	1
	.type	trivial_2, %object
	.size	trivial_2, 2
trivial_2:
	.short	1
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Constant coding example.\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	mov	r3, #1
	str	r3, [fp, #-16]
	mov	r3, #0
	str	r3, [fp, #-12]
	mov	r3, #3
	str	r3, [fp, #-8]
	ldr	r0, .L3
	bl	puts
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L4:
	.align	2
.L3:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
