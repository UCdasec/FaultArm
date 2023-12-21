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
	push	{r4, lr}
	ldr	lr, .L17
.L5:
	sub	r3, r3, #65
	add	r2, r3, r1
	and	r3, r3, #255
	cmp	r3, #25
	asr	ip, r2, #31
	bhi	.L3
	smull	r4, r3, lr, r2
	rsb	r3, ip, r3, asr #3
	add	ip, r3, r3, lsl #1
	add	r3, r3, ip, lsl #2
	sub	r2, r2, r3, lsl #1
	add	r2, r2, #65
	strb	r2, [r0]
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L5
	pop	{r4, lr}
	bx	lr
.L3:
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L5
	pop	{r4, lr}
	bx	lr
.L18:
	.align	2
.L17:
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
	ldr	r1, .L36
	ldr	r0, .L36+4
	sub	sp, sp, #24
	bl	fopen
	subs	r4, r0, #0
	beq	.L34
	mov	r2, r4
	ldr	r1, .L36+8
	add	r0, sp, #8
	bl	fgets
	cmp	r0, #0
	beq	.L35
	mov	r0, r4
	bl	fclose
	ldr	r0, .L36+12
	bl	printf
	ldr	r0, .L36+16
	add	r1, sp, #4
	bl	scanf
	ldrb	r3, [sp, #8]	@ zero_extendqisi2
	cmp	r3, #0
	ldr	ip, [sp, #4]
	beq	.L23
	ldr	lr, .L36+20
	add	r0, sp, #8
.L26:
	sub	r3, r3, #65
	add	r2, r3, ip
	and	r3, r3, #255
	cmp	r3, #25
	asr	r1, r2, #31
	bhi	.L24
	smull	r4, r3, lr, r2
	rsb	r3, r1, r3, asr #3
	add	r1, r3, r3, lsl #1
	add	r3, r3, r1, lsl #2
	sub	r2, r2, r3, lsl #1
	add	r2, r2, #65
	strb	r2, [r0]
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L26
.L23:
	ldr	r0, .L36+24
	add	r1, sp, #8
	bl	printf
	mov	r0, #0
.L19:
	add	sp, sp, #9984
	add	sp, sp, #24
	@ sp needed
	pop	{r4, lr}
	bx	lr
.L24:
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L26
	b	.L23
.L34:
	ldr	r0, .L36+28
	bl	puts
	mov	r0, #1
	b	.L19
.L35:
	ldr	r0, .L36+32
	bl	puts
	mov	r0, r4
	bl	fclose
	mov	r0, #1
	b	.L19
.L37:
	.align	2
.L36:
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
