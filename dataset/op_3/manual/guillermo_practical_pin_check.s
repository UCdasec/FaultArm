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
	.file	"guillermo_practical_pin_check.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"r\000"
	.align	2
.LC1:
	.ascii	"/path/to/saved/pins\000"
	.align	2
.LC2:
	.ascii	"%5s\000"
	.text
	.align	2
	.global	import_data
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	import_data, %function
import_data:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r1, .L6
	mov	r4, r0
	ldr	r0, .L6+4
	bl	fopen
	cmp	r0, #0
	moveq	r0, #1
	beq	.L1
	mov	r2, r4
	ldr	r1, .L6+8
	bl	fscanf
	cmp	r0, #3
	movgt	r0, #0
	movle	r0, #1
.L1:
	pop	{r4, lr}
	bx	lr
.L7:
	.align	2
.L6:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	import_data, .-import_data
	.section	.rodata.str1.4
	.align	2
.LC3:
	.ascii	"Failed to import data\000"
	.align	2
.LC4:
	.ascii	"Bad input...\000"
	.align	2
.LC5:
	.ascii	"Incorrect PIN\000"
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
	add	r0, sp, #8
	bl	import_data
	cmp	r0, #1
	beq	.L24
	mov	r1, sp
	ldr	r0, .L25
	bl	scanf
	cmp	r0, #4
	ble	.L11
	ldrb	r3, [sp]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L18
	mov	r0, sp
	add	r2, sp, #8
	b	.L13
.L22:
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	mov	r1, r2
	beq	.L12
.L13:
	ldrb	r1, [r2], #1	@ zero_extendqisi2
	subs	r3, r1, r3
	movne	r3, #1
	cmp	r1, #0
	moveq	r3, #1
	cmp	r3, #0
	beq	.L22
.L14:
	mov	r0, #0
.L8:
	add	sp, sp, #20
	@ sp needed
	ldr	lr, [sp], #4
	bx	lr
.L18:
	add	r1, sp, #8
.L12:
	ldrb	r3, [r1]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L14
	ldr	r0, .L25+4
	bl	puts
	b	.L10
.L24:
	ldr	r0, .L25+8
	bl	puts
.L10:
	mov	r0, #1
	b	.L8
.L11:
	ldr	r0, .L25+12
	bl	puts
	b	.L10
.L26:
	.align	2
.L25:
	.word	.LC2
	.word	.LC5
	.word	.LC3
	.word	.LC4
	.size	main, .-main
	.text
	.align	2
	.global	verify_pin
	.syntax unified
	.arm
	.fpu softvfp
	.type	verify_pin, %function
verify_pin:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L28
	mov	r2, r1
	b	.L29
.L30:
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	mov	r1, r2
	beq	.L28
.L29:
	ldrb	r1, [r2], #1	@ zero_extendqisi2
	subs	r3, r1, r3
	movne	r3, #1
	cmp	r1, #0
	moveq	r3, #1
	cmp	r3, #0
	beq	.L30
	mov	r0, #0
	bx	lr
.L28:
	ldrb	r0, [r1]	@ zero_extendqisi2
	rsbs	r0, r0, #1
	movcc	r0, #0
	bx	lr
	.size	verify_pin, .-verify_pin
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
