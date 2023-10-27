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
	.file	"data_integrity_checksum.c"
	.text
	.align	2
	.global	calculate_checksum
	.syntax unified
	.arm
	.fpu softvfp
	.type	calculate_checksum, %function
calculate_checksum:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	mov	r3, #0
	strb	r3, [fp, #-5]
	b	.L2
.L3:
	ldr	r3, [fp, #-16]
	ldrb	r2, [r3]	@ zero_extendqisi2
	ldrb	r3, [fp, #-5]
	add	r3, r2, r3
	strb	r3, [fp, #-5]
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L2:
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L3
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	calculate_checksum, .-calculate_checksum
	.section	.rodata
	.align	2
.LC1:
	.ascii	"Data: %s\012\000"
	.align	2
.LC2:
	.ascii	"Checksum: %u\012\000"
	.align	2
.LC0:
	.ascii	"IntegrityCheck\000"
	.align	2
.LC3:
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
	ldr	r3, .L8
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3,#0
	ldr	r3, .L8+4
	sub	ip, fp, #24
	ldm	r3, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2}
	strh	r3, [ip]	@ movhi
	add	ip, ip, #2
	lsr	r3, r3, #16
	strb	r3, [ip]
	sub	r3, fp, #24
	mov	r0, r3
	bl	calculate_checksum
	mov	r3, r0
	strb	r3, [fp, #-25]
	sub	r3, fp, #24
	mov	r1, r3
	ldr	r0, .L8+8
	bl	printf
	ldrb	r3, [fp, #-25]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L8+12
	bl	printf
	mov	r3, #0
	ldr	r2, .L8
	ldr	r1, [r2]
	ldr	r2, [fp, #-8]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L7
	bl	__stack_chk_fail
.L7:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L9:
	.align	2
.L8:
	.word	.LC3
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
