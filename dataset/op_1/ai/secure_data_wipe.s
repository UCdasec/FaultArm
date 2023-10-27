	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 1
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
	@ link register save eliminated.
	cmp	r1, #0
	bxeq	lr
	sub	r3, r0, #1
	add	r0, r0, r1
	sub	r2, r0, #1
	mov	r1, #0
.L3:
	strb	r1, [r3, #1]!
	cmp	r3, r2
	bne	.L3
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
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #20
	ldr	r2, .L7
	add	r3, sp, #4
	ldm	r2, {r0, r1, r2}
	stmia	r3!, {r0, r1}
	strh	r2, [r3], #2	@ movhi
	lsr	r2, r2, #16
	strb	r2, [r3]
	add	r1, sp, #4
	ldr	r0, .L7+4
	bl	printf
	add	r0, sp, #4
	bl	strlen
	mov	r1, r0
	add	r0, sp, #4
	bl	secure_wipe
	add	r1, sp, #4
	ldr	r0, .L7+8
	bl	printf
	mov	r0, #0
	add	sp, sp, #20
	@ sp needed
	ldr	lr, [sp], #4
	bx	lr
.L8:
	.align	2
.L7:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
