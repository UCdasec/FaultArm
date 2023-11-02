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
	.file	"data_encryption_xor.c"
	.text
	.align	2
	.global	encrypt
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	encrypt, %function
encrypt:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bxeq	lr
.L3:
	eor	r3, r3, r1
	strb	r3, [r0]
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L3
	bx	lr
	.size	encrypt, .-encrypt
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"Original message: %s\012\000"
	.align	2
.LC2:
	.ascii	"Encrypted message: %s\012\000"
	.align	2
.LC3:
	.ascii	"Decrypted message: %s\012\000"
	.align	2
.LC0:
	.ascii	"SensitiveData\000"
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
	sub	sp, sp, #20
	mov	ip, sp
	ldr	r3, .L23
	ldm	r3, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2}
	mov	r1, sp
	ldr	r0, .L23+4
	strh	r3, [ip]	@ movhi
	bl	printf
	ldrb	r3, [sp]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L10
	mov	r2, sp
	mvn	r1, #85
.L11:
	eor	r3, r3, r1
	strb	r3, [r2]
	ldrb	r3, [r2, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L11
.L10:
	mov	r1, sp
	ldr	r0, .L23+8
	bl	printf
	ldrb	r3, [sp]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L12
	mov	r2, sp
	mvn	r1, #85
.L13:
	eor	r3, r3, r1
	strb	r3, [r2]
	ldrb	r3, [r2, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L13
.L12:
	mov	r1, sp
	ldr	r0, .L23+12
	bl	printf
	mov	r0, #0
	add	sp, sp, #20
	@ sp needed
	ldr	lr, [sp], #4
	bx	lr
.L24:
	.align	2
.L23:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
