	.arch armv5t
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"data_encryption_xor.c"
	.text
	.align	2
	.global	encrypt
	.syntax unified
	.arm
	.fpu softvfp
	.type	encrypt, %function
encrypt:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	mov	r3, r1
	strb	r3, [fp, #-9]
	b	.L2
.L3:
	ldr	r3, [fp, #-8]
	ldrb	r2, [r3]	@ zero_extendqisi2
	ldrb	r3, [fp, #-9]
	eor	r3, r3, r2
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	strb	r2, [r3]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L2:
	ldr	r3, [fp, #-8]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L3
	nop
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	encrypt, .-encrypt
	.section	.rodata
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
	.align	2
.LC4:
	.word	__stack_chk_guard
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	ldr	r3, .L7
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3,#0
	ldr	r3, .L7+4
	sub	ip, fp, #24
	ldm	r3, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2}
	strh	r3, [ip]	@ movhi
	mvn	r3, #85
	strb	r3, [fp, #-25]
	sub	r3, fp, #24
	mov	r1, r3
	ldr	r0, .L7+8
	bl	printf
	ldrb	r2, [fp, #-25]	@ zero_extendqisi2
	sub	r3, fp, #24
	mov	r1, r2
	mov	r0, r3
	bl	encrypt
	sub	r3, fp, #24
	mov	r1, r3
	ldr	r0, .L7+12
	bl	printf
	ldrb	r2, [fp, #-25]	@ zero_extendqisi2
	sub	r3, fp, #24
	mov	r1, r2
	mov	r0, r3
	bl	encrypt
	sub	r3, fp, #24
	mov	r1, r3
	ldr	r0, .L7+16
	bl	printf
	mov	r3, #0
	ldr	r2, .L7
	ldr	r1, [r2]
	ldr	r2, [fp, #-8]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L6
	bl	__stack_chk_fail
.L6:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L8:
	.align	2
.L7:
	.word	.LC4
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
