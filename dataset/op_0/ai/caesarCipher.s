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
	.file	"caesarCipher.c"
	.text
	.align	2
	.global	caesarCipher
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	caesarCipher, %function
caesarCipher:
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
.L4:
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-16]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #64
	bls	.L3
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-16]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #90
	bhi	.L3
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-16]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	sub	r2, r3, #65
	ldr	r3, [fp, #-20]
	add	r1, r2, r3
	ldr	r3, .L5
	smull	r2, r3, r1, r3
	asr	r2, r3, #3
	asr	r3, r1, #31
	sub	r2, r2, r3
	mov	r3, r2
	lsl	r3, r3, #1
	add	r3, r3, r2
	lsl	r3, r3, #2
	add	r3, r3, r2
	lsl	r3, r3, #1
	sub	r2, r1, r3
	and	r2, r2, #255
	ldr	r3, [fp, #-8]
	ldr	r1, [fp, #-16]
	add	r3, r1, r3
	add	r2, r2, #65
	and	r2, r2, #255
	strb	r2, [r3]
.L3:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L2:
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-16]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L4
	nop
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L6:
	.align	2
.L5:
	.word	1321528399
	.size	caesarCipher, .-caesarCipher
	.section	.rodata
	.align	2
.LC0:
	.ascii	"r\000"
	.align	2
.LC1:
	.ascii	"text.txt\000"
	.align	2
.LC2:
	.ascii	"Unable to open the file.\000"
	.align	2
.LC3:
	.ascii	"Unable to read from the file.\000"
	.align	2
.LC4:
	.ascii	"Enter the Caesar cipher shift value: \000"
	.align	2
.LC5:
	.ascii	"%d\000"
	.align	2
.LC6:
	.ascii	"Caesar Cipher: %s\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 10008
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #9984
	sub	sp, sp, #24
	ldr	r1, .L12
	ldr	r0, .L12+4
	bl	fopen
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bne	.L8
	ldr	r0, .L12+8
	bl	puts
	mov	r3, #1
	b	.L11
.L8:
	sub	r3, fp, #9984
	sub	r3, r3, #4
	sub	r3, r3, #24
	ldr	r2, [fp, #-8]
	ldr	r1, .L12+12
	mov	r0, r3
	bl	fgets
	mov	r3, r0
	cmp	r3, #0
	bne	.L10
	ldr	r0, .L12+16
	bl	puts
	ldr	r0, [fp, #-8]
	bl	fclose
	mov	r3, #1
	b	.L11
.L10:
	ldr	r0, [fp, #-8]
	bl	fclose
	ldr	r0, .L12+20
	bl	printf
	sub	r3, fp, #12
	mov	r1, r3
	ldr	r0, .L12+24
	bl	scanf
	ldr	r2, [fp, #-12]
	sub	r3, fp, #9984
	sub	r3, r3, #4
	sub	r3, r3, #24
	mov	r1, r2
	mov	r0, r3
	bl	caesarCipher
	sub	r3, fp, #9984
	sub	r3, r3, #4
	sub	r3, r3, #24
	mov	r1, r3
	ldr	r0, .L12+28
	bl	printf
	mov	r3, #0
.L11:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L13:
	.align	2
.L12:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	10000
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
