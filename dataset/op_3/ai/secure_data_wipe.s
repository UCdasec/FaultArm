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
	.file	"secure_data_wipe.c"
	.text
	.align	2
	.global	secure_wipe
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	secure_wipe, %function
secure_wipe:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	subs	r2, r1, #0
	bxeq	lr
	push	{r4, lr}
	mov	r1, #0
	bl	memset
	pop	{r4, lr}
	bx	lr
	.size	secure_wipe, .-secure_wipe
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"Before wipe: %s\012\000"
	.align	2
.LC2:
	.ascii	"After wipe: %s\012\000"
	.align	2
.LC0:
	.ascii	"VerySecret\000"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	ldr	r3, .L17
	sub	sp, sp, #20
	ldm	r3, {r0, r1, r2}
	add	r3, sp, #4
	stmia	r3!, {r0, r1}
	strh	r2, [r3], #2	@ movhi
	add	r1, sp, #4
	lsr	r2, r2, #16
	ldr	r0, .L17+4
	strb	r2, [r3]
	bl	printf
	add	r0, sp, #4
	bl	strlen
	subs	r2, r0, #0
	movne	r1, #0
	addne	r0, sp, #4
	blne	memset
.L12:
	add	r1, sp, #4
	ldr	r0, .L17+8
	bl	printf
	mov	r0, #0
	add	sp, sp, #20
	@ sp needed
	ldr	lr, [sp], #4
	bx	lr
.L18:
	.align	2
.L17:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
