	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"harris_branch_secure_pointer_example.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Do not excute critical code\000"
	.align	2
.LC1:
	.ascii	"Neither x < z and *p are true\000"
	.align	2
.LC2:
	.ascii	"Neither x < z or *p > x are true\000"
	.align	2
.LC3:
	.ascii	"x * z is greater than *p\000"
	.align	2
.LC4:
	.ascii	"y is greater than x\000"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L4
	bl	printf
	ldr	r0, .L4+4
	bl	printf
	ldr	r0, .L4+8
	bl	printf
	ldr	r0, .L4+12
	bl	printf
	ldr	r0, .L4+16
	bl	printf
	mov	r0, #0
	pop	{r4, lr}
	bx	lr
.L5:
	.align	2
.L4:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
