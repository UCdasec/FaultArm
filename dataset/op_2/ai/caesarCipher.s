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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bxeq	lr
	str	lr, [sp, #-4]!
	ldr	lr, .L14
.L4:
	sub	r3, r3, #65
	and	r2, r3, #255
	cmp	r2, #25
	bhi	.L3
	add	r3, r3, r1
	smull	r2, ip, lr, r3
	asr	r2, r3, #31
	rsb	r2, r2, ip, asr #3
	add	ip, r2, r2, lsl #1
	add	r2, r2, ip, lsl #2
	sub	r3, r3, r2, lsl #1
	add	r3, r3, #65
	strb	r3, [r0]
.L3:
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L4
	ldr	lr, [sp], #4
	bx	lr
.L15:
	.align	2
.L14:
	.word	1321528399
	.size	caesarCipher, .-caesarCipher
	.section	.rodata.str1.4,"aMS",%progbits,1
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
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 10008
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #9984
	ldr	r1, .L30
	ldr	r0, .L30+4
	sub	sp, sp, #24
	bl	fopen
	subs	r4, r0, #0
	beq	.L28
	mov	r2, r4
	ldr	r1, .L30+8
	add	r0, sp, #8
	bl	fgets
	cmp	r0, #0
	beq	.L29
	mov	r0, r4
	bl	fclose
	ldr	r0, .L30+12
	bl	printf
	ldr	r0, .L30+16
	add	r1, sp, #4
	bl	scanf
	ldrb	r3, [sp, #8]	@ zero_extendqisi2
	cmp	r3, #0
	ldr	ip, [sp, #4]
	beq	.L20
	ldr	lr, .L30+20
	add	r1, sp, #8
.L22:
	sub	r3, r3, #65
	and	r2, r3, #255
	cmp	r2, #25
	bhi	.L21
	add	r3, r3, ip
	smull	r2, r0, lr, r3
	asr	r2, r3, #31
	rsb	r2, r2, r0, asr #3
	add	r0, r2, r2, lsl #1
	add	r2, r2, r0, lsl #2
	sub	r3, r3, r2, lsl #1
	add	r3, r3, #65
	strb	r3, [r1]
.L21:
	ldrb	r3, [r1, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L22
.L20:
	ldr	r0, .L30+24
	add	r1, sp, #8
	bl	printf
	mov	r0, #0
.L16:
	add	sp, sp, #9984
	add	sp, sp, #24
	@ sp needed
	pop	{r4, lr}
	bx	lr
.L28:
	ldr	r0, .L30+28
	bl	puts
	mov	r0, #1
	b	.L16
.L29:
	ldr	r0, .L30+32
	bl	puts
	mov	r0, r4
	bl	fclose
	mov	r0, #1
	b	.L16
.L31:
	.align	2
.L30:
	.word	.LC0
	.word	.LC1
	.word	10000
	.word	.LC4
	.word	.LC5
	.word	1321528399
	.word	.LC6
	.word	.LC2
	.word	.LC3
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
