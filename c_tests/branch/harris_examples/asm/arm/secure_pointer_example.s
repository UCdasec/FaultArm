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
	.file	"secure_pointer_example.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Execute critcal code\000"
	.align	2
.LC1:
	.ascii	"Do not excute critical code\000"
	.align	2
.LC2:
	.ascii	"Both x < z and *p are true\000"
	.align	2
.LC3:
	.ascii	"Neither x < z and *p are true\000"
	.align	2
.LC4:
	.ascii	"Either x < z or *p > x are true\000"
	.align	2
.LC5:
	.ascii	"Neither x < z or *p > x are true\000"
	.align	2
.LC6:
	.ascii	"x * z is greater than *p\000"
	.align	2
.LC7:
	.ascii	"x * z is less than *p\000"
	.global	__aeabi_i2d
	.global	__aeabi_d2iz
	.align	2
.LC8:
	.ascii	"y is less than x\000"
	.align	2
.LC9:
	.ascii	"y is greater than x\000"
	.align	2
.LC10:
	.word	__stack_chk_guard
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
	ldr	r3, .L17
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3,#0
	ldr	r3, .L17+4
	str	r3, [fp, #-28]
	sub	r3, fp, #28
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	ldr	r2, [r3]
	ldr	r3, [fp, #-28]
	cmp	r2, r3
	ble	.L2
	ldr	r0, .L17+8
	bl	printf
	b	.L3
.L2:
	ldr	r0, .L17+12
	bl	printf
.L3:
	ldr	r3, [fp, #-24]
	ldr	r3, [r3]
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-28]
	ldr	r2, [fp, #-20]
	cmp	r2, r3
	ble	.L4
	ldr	r3, [fp, #-24]
	ldr	r3, [r3]
	cmp	r3, #0
	beq	.L4
	ldr	r0, .L17+16
	bl	printf
	b	.L5
.L4:
	ldr	r0, .L17+20
	bl	printf
.L5:
	ldr	r3, [fp, #-28]
	ldr	r2, [fp, #-20]
	cmp	r2, r3
	bgt	.L6
	ldr	r3, [fp, #-24]
	ldr	r2, [r3]
	ldr	r3, [fp, #-28]
	cmp	r2, r3
	ble	.L7
.L6:
	ldr	r0, .L17+24
	bl	printf
	b	.L8
.L7:
	ldr	r0, .L17+28
	bl	printf
.L8:
	ldr	r3, [fp, #-28]
	ldr	r2, [fp, #-20]
	mul	r2, r3, r2
	ldr	r3, [fp, #-24]
	ldr	r3, [r3]
	cmp	r2, r3
	ble	.L9
	ldr	r3, .L17+32
	b	.L10
.L9:
	ldr	r3, .L17+36
.L10:
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	ldr	r2, .L17+32
	cmp	r3, r2
	bne	.L11
	ldr	r0, .L17+40
	bl	printf
	b	.L12
.L11:
	ldr	r0, .L17+44
	bl	printf
.L12:
	ldr	r3, [fp, #-24]
	ldr	r3, [r3]
	mov	r0, r3
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1073741824
	bl	pow
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	__aeabi_d2iz
	mov	r3, r0
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	ldr	r2, [fp, #-12]
	cmp	r2, r3
	bge	.L13
	ldr	r0, .L17+48
	bl	printf
	b	.L14
.L13:
	ldr	r0, .L17+52
	bl	printf
.L14:
	mov	r3, #0
	ldr	r2, .L17
	ldr	r1, [r2]
	ldr	r2, [fp, #-8]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L16
	bl	__stack_chk_fail
.L16:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L18:
	.align	2
.L17:
	.word	.LC10
	.word	16200
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	16204
	.word	16203
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
