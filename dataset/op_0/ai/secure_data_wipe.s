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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L2
.L3:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	mov	r2, #0
	strb	r2, [r3]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L2:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bcc	.L3
	nop
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	secure_wipe, .-secure_wipe
	.section	.rodata
	.align	2
.LC1:
	.ascii	"Before wipe: %s\012\000"
	.align	2
.LC2:
	.ascii	"After wipe: %s\012\000"
	.align	2
.LC0:
	.ascii	"VerySecret\000"
	.text
	.align	2
	.global	main
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
	ldr	r2, .L6
	sub	r3, fp, #16
	ldm	r2, {r0, r1, r2}
	stmia	r3!, {r0, r1}
	strh	r2, [r3]	@ movhi
	add	r3, r3, #2
	lsr	r2, r2, #16
	strb	r2, [r3]
	sub	r3, fp, #16
	mov	r1, r3
	ldr	r0, .L6+4
	bl	printf
	sub	r3, fp, #16
	mov	r0, r3
	bl	strlen
	mov	r2, r0
	sub	r3, fp, #16
	mov	r1, r2
	mov	r0, r3
	bl	secure_wipe
	sub	r3, fp, #16
	mov	r1, r3
	ldr	r0, .L6+8
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L7:
	.align	2
.L6:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
