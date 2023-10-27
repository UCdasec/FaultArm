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
	.file	"data_integrity_checksum.c"
	.text
	.align	2
	.global	calculate_checksum
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	calculate_checksum, %function
calculate_checksum:
	@ Function supports interworking.
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
	ldr	r3, .L7
	sub	ip, fp, #20
	ldm	r3, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2}
	strh	r3, [ip]	@ movhi
	add	ip, ip, #2
	lsr	r3, r3, #16
	strb	r3, [ip]
	sub	r3, fp, #20
	mov	r0, r3
	bl	calculate_checksum
	mov	r3, r0
	strb	r3, [fp, #-5]
	sub	r3, fp, #20
	mov	r1, r3
	ldr	r0, .L7+4
	bl	printf
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L7+8
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L8:
	.align	2
.L7:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
