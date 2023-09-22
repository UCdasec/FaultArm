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
	.file	"simple_secure.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Executing critical code... \000"
	.align	2
.LC1:
	.ascii	"Exiting out...\000"
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
	mov	r3, #16192
	str	r3, [fp, #-12]
	ldr	r3, .L6
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-12]
	cmp	r3, #16192
	bne	.L2
	ldr	r3, [fp, #-8]
	ldr	r2, .L6
	cmp	r3, r2
	bne	.L3
	ldr	r0, .L6+4
	bl	puts
	mov	r3, #0
	b	.L5
.L3:
	ldr	r0, .L6+8
	bl	puts
	mov	r3, #2
	b	.L5
.L2:
	ldr	r0, .L6+8
	bl	puts
	mov	r3, #1
.L5:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L7:
	.align	2
.L6:
	.word	16236
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
