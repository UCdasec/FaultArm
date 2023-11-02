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
	.file	"guillermo_practical_pin_check.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Failed to import data\000"
	.align	2
.LC1:
	.ascii	"%5s\000"
	.align	2
.LC2:
	.ascii	"Bad input...\000"
	.align	2
.LC3:
	.ascii	"Incorrect PIN\000"
	.text
	.align	2
	.global	main
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	sub	r3, fp, #20
	mov	r0, r3
	bl	import_data
	mov	r3, r0
	cmp	r3, #1
	bne	.L2
	ldr	r0, .L7
	bl	puts
	mov	r3, #1
	b	.L6
.L2:
	sub	r3, fp, #12
	mov	r1, r3
	ldr	r0, .L7+4
	bl	scanf
	mov	r3, r0
	cmp	r3, #4
	bgt	.L4
	ldr	r0, .L7+8
	bl	puts
	mov	r3, #1
	b	.L6
.L4:
	sub	r2, fp, #20
	sub	r3, fp, #12
	mov	r1, r2
	mov	r0, r3
	bl	verify_pin
	mov	r3, r0
	cmp	r3, #1
	bne	.L5
	ldr	r0, .L7+12
	bl	puts
	mov	r3, #1
	b	.L6
.L5:
	mov	r3, #0
.L6:
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
	.word	.LC3
	.size	main, .-main
	.section	.rodata
	.align	2
.LC4:
	.ascii	"r\000"
	.align	2
.LC5:
	.ascii	"/path/to/saved/pins\000"
	.text
	.align	2
	.global	import_data
	.syntax unified
	.arm
	.fpu softvfp
	.type	import_data, %function
import_data:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	ldr	r1, .L13
	ldr	r0, .L13+4
	bl	fopen
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bne	.L10
	mov	r3, #1
	b	.L11
.L10:
	ldr	r2, [fp, #-16]
	ldr	r1, .L13+8
	ldr	r0, [fp, #-8]
	bl	fscanf
	mov	r3, r0
	cmp	r3, #3
	bgt	.L12
	mov	r3, #1
	b	.L11
.L12:
	mov	r3, #0
.L11:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L14:
	.align	2
.L13:
	.word	.LC4
	.word	.LC5
	.word	.LC1
	.size	import_data, .-import_data
	.align	2
	.global	verify_pin
	.syntax unified
	.arm
	.fpu softvfp
	.type	verify_pin, %function
verify_pin:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	b	.L16
.L20:
	ldr	r3, [fp, #-8]
	ldrb	r2, [r3]	@ zero_extendqisi2
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r2, r3
	beq	.L17
	mov	r3, #0
	b	.L18
.L17:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L16:
	ldr	r3, [fp, #-8]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L19
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L20
.L19:
	ldr	r3, [fp, #-8]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L21
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L21
	mov	r3, #1
	b	.L18
.L21:
	mov	r3, #0
.L18:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	verify_pin, .-verify_pin
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
