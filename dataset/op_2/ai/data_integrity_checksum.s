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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	mov	r2, r0
	beq	.L4
	mov	r0, #0
.L3:
	add	r0, r3, r0
	ldrb	r3, [r2, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	and	r0, r0, #255
	bne	.L3
	bx	lr
.L4:
	mov	r0, r3
	bx	lr
	.size	calculate_checksum, .-calculate_checksum
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"Data: %s\012\000"
	.align	2
.LC2:
	.ascii	"Checksum: %u\012\000"
	.align	2
.LC0:
	.ascii	"IntegrityCheck\000"
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
	push	{r4, r5, lr}
	sub	sp, sp, #20
	mov	lr, sp
	ldr	r3, .L13
	ldm	r3, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2}
	strh	r3, [lr], #2	@ movhi
	lsr	r3, r3, #16
	strb	r3, [lr]
	mov	r5, #110
	mov	r4, #0
	mov	ip, #73
	add	r3, sp, #2
	b	.L10
.L12:
	mov	ip, r5
	ldrb	r5, [r3], #1	@ zero_extendqisi2
.L10:
	add	r4, ip, r4
	cmp	r5, #0
	and	r4, r4, #255
	bne	.L12
	mov	r1, sp
	ldr	r0, .L13+4
	bl	printf
	mov	r1, r4
	ldr	r0, .L13+8
	bl	printf
	mov	r0, r5
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, lr}
	bx	lr
.L14:
	.align	2
.L13:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
