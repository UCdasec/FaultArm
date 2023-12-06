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
	.file	"prateek_constant_global_local_secure_insecure.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"%d\000"
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
	ldr	r4, .L4
	mov	r1, #16
	mov	r0, r4
	bl	printf
	ldr	r3, .L4+4
	mov	r0, r4
	ldr	r1, [r3]
	bl	printf
	mov	r0, #0
	pop	{r4, lr}
	bx	lr
.L5:
	.align	2
.L4:
	.word	.LC1
	.word	.LANCHOR0
	.size	main, .-main
	.text
	.align	2
	.global	printNumber
	.syntax unified
	.arm
	.fpu softvfp
	.type	printNumber, %function
printNumber:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r1, r0
	ldr	r0, .L8
	bl	printf
	pop	{r4, lr}
	bx	lr
.L9:
	.align	2
.L8:
	.word	.LC1
	.size	printNumber, .-printNumber
	.global	global_insecure
	.global	global_secure
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	global_insecure, %object
	.size	global_insecure, 4
global_insecure:
	.word	1
	.type	global_secure, %object
	.size	global_secure, 4
global_secure:
	.word	255
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
