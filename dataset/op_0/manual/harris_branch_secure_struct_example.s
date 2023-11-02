	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"harris_branch_secure_struct_example.c"
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
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	ldr	r3, .L7
	str	r3, [fp, #-12]
	ldr	r3, .L7+4
	str	r3, [fp, #-8]
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-8]
	cmp	r2, r3
	bge	.L2
	ldr	r0, .L7+8
	bl	printf
	b	.L3
.L2:
	ldr	r0, .L7+12
	bl	printf
.L3:
	ldr	r3, .L7+16
	str	r3, [fp, #-20]
	ldr	r3, .L7+20
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bge	.L4
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-8]
	cmp	r2, r3
	ble	.L4
	ldr	r0, .L7+24
	bl	printf
	b	.L5
.L4:
	ldr	r0, .L7+28
	bl	printf
.L5:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L8:
	.align	2
.L7:
	.word	16201
	.word	16211
	.word	.LC0
	.word	.LC1
	.word	16248
	.word	16207
	.word	.LC2
	.word	.LC3
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
