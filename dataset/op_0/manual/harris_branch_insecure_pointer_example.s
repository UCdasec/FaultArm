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
	.file	"harris_branch_insecure_pointer_example.c"
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
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	mov	r3, #1
	str	r3, [fp, #-24]
	sub	r3, fp, #24
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	ldr	r2, [r3]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	ble	.L2
	ldr	r0, .L14
	bl	printf
	b	.L3
.L2:
	ldr	r0, .L14+4
	bl	printf
.L3:
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-24]
	ldr	r2, [fp, #-12]
	cmp	r2, r3
	ble	.L4
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	cmp	r3, #0
	beq	.L4
	ldr	r0, .L14+8
	bl	printf
	b	.L5
.L4:
	ldr	r0, .L14+12
	bl	printf
.L5:
	ldr	r3, [fp, #-24]
	ldr	r2, [fp, #-12]
	cmp	r2, r3
	bgt	.L6
	ldr	r3, [fp, #-8]
	ldr	r2, [r3]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	ble	.L7
.L6:
	ldr	r0, .L14+16
	bl	printf
	b	.L8
.L7:
	ldr	r0, .L14+20
	bl	printf
.L8:
	ldr	r3, [fp, #-24]
	ldr	r2, [fp, #-12]
	mul	r2, r3, r2
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	cmp	r2, r3
	movgt	r3, #1
	movle	r3, #0
	and	r3, r3, #255
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	beq	.L9
	ldr	r0, .L14+24
	bl	printf
	b	.L10
.L9:
	ldr	r0, .L14+28
	bl	printf
.L10:
	ldr	r3, [fp, #-8]
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
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-24]
	ldr	r2, [fp, #-20]
	cmp	r2, r3
	bge	.L11
	ldr	r0, .L14+32
	bl	printf
	b	.L12
.L11:
	ldr	r0, .L14+36
	bl	printf
.L12:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L15:
	.align	2
.L14:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
