	.arch armv5t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"global_local_secure_insecure.c"
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
	.syntax unified
	.arm
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	ldr	r3, .L4
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3, #0
	mov	r3, #16
	str	r3, [fp, #-32]
	mvn	r3, #0
	strh	r3, [fp, #-34]	@ movhi
	ldr	r3, .L4+4
	sub	ip, fp, #28
	mov	lr, r3
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	str	r3, [ip]
	ldr	r0, [fp, #-32]
	bl	printNumber
	ldr	r3, .L4+8
	ldr	r3, [r3]
	mov	r0, r3
	bl	printNumber
	mov	r3, #0
	ldr	r2, .L4
	ldr	r1, [r2]
	ldr	r2, [fp, #-8]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L3
	bl	__stack_chk_fail
.L3:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L5:
	.align	2
.L4:
	.word	__stack_chk_guard
	.word	.LC0
	.word	global_insecure
	.size	main, .-main
	.section	.rodata
	.align	2
.LC2:
	.ascii	"%d\000"
	.text
	.align	2
	.global	printNumber
	.syntax unified
	.arm
	.type	printNumber, %function
printNumber:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r1, [fp, #-8]
	ldr	r0, .L7
	bl	printf
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L8:
	.align	2
.L7:
	.word	.LC2
	.size	printNumber, .-printNumber
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",%progbits
