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
	.file	"insecure_struct_example.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Execute critical code\000"
	.align	2
.LC1:
	.ascii	"Do not execute critical code\000"
	.align	2
.LC2:
	.ascii	"both conditions are true\000"
	.align	2
.LC3:
	.ascii	"neither conditions are true\000"
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
	mov	r3, #0
	str	r3, [fp, #-20]
	mov	r3, #1
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	beq	.L2
	ldr	r3, [fp, #-16]
	cmp	r3, #1
	bne	.L2
	ldr	r0, .L7
	bl	printf
	b	.L3
.L2:
	ldr	r0, .L7+4
	bl	printf
.L3:
	mov	r3, #30
	str	r3, [fp, #-12]
	mov	r3, #15
	str	r3, [fp, #-8]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-8]
	cmp	r2, r3
	bge	.L4
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	ble	.L4
	ldr	r0, .L7+8
	bl	printf
	b	.L5
.L4:
	ldr	r0, .L7+12
	bl	printf
.L5:
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
	.word	.LC3
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
