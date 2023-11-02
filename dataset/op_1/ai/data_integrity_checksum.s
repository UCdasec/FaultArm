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
	mov	r2, r0
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L4
	mov	r0, #0
.L3:
	add	r0, r3, r0
	and	r0, r0, #255
	ldrb	r3, [r2, #1]!	@ zero_extendqisi2
	cmp	r3, #0
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
	push	{r4, lr}
	sub	sp, sp, #16
	ldr	r3, .L9
	mov	ip, sp
	ldm	r3, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2}
	strh	r3, [ip], #2	@ movhi
	lsr	r3, r3, #16
	strb	r3, [ip]
	mov	r0, sp
	bl	calculate_checksum
	mov	r4, r0
	mov	r1, sp
	ldr	r0, .L9+4
	bl	printf
	mov	r1, r4
	ldr	r0, .L9+8
	bl	printf
	mov	r0, #0
	add	sp, sp, #16
	@ sp needed
	pop	{r4, lr}
	bx	lr
.L10:
	.align	2
.L9:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
