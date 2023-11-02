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
	.file	"prateek_constant_global_local_secure_insecure.c"
	.text
	.global	global_secure
	.data
	.align	2
	.type	global_secure, %object
	.size	global_secure, 4
global_secure:
	.word	255
	.global	global_insecure
	.align	2
	.type	global_insecure, %object
	.size	global_insecure, 4
global_insecure:
	.word	1
	.section	.rodata
	.align	2
.LC0:
	.word	1
	.word	2
	.word	4
	.word	8
	.word	16
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
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	mov	r3, #16
	str	r3, [fp, #-8]
	mvn	r3, #0
	strh	r3, [fp, #-10]	@ movhi
	ldr	r3, .L3
	sub	ip, fp, #32
	mov	lr, r3
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	str	r3, [ip]
	ldr	r0, [fp, #-8]
	bl	printNumber
	ldr	r3, .L3+4
	ldr	r3, [r3]
	mov	r0, r3
	bl	printNumber
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L4:
	.align	2
.L3:
	.word	.LC0
	.word	global_insecure
	.size	main, .-main
	.section	.rodata
	.align	2
.LC1:
	.ascii	"%d\000"
	.text
	.align	2
	.global	printNumber
	.syntax unified
	.arm
	.fpu softvfp
	.type	printNumber, %function
printNumber:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r1, [fp, #-8]
	ldr	r0, .L6
	bl	printf
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L7:
	.align	2
.L6:
	.word	.LC1
	.size	printNumber, .-printNumber
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
