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
	.file	"complex_secure.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Flag 1 is set.\000"
	.align	2
.LC1:
	.ascii	"Flag 1 is not set.\000"
	.align	2
.LC2:
	.ascii	"Flag 2 is set.\000"
	.align	2
.LC3:
	.ascii	"Flag 2 is not set.\000"
	.align	2
.LC4:
	.ascii	"Flag 3 is set.\000"
	.align	2
.LC5:
	.ascii	"Flag 3 is not set.\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r3, .L9
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	and	r3, r3, #3840
	cmp	r3, #256
	bne	.L2
	ldr	r0, .L9+4
	bl	puts
	b	.L3
.L2:
	ldr	r0, .L9+8
	bl	puts
.L3:
	ldr	r3, [fp, #-8]
	and	r3, r3, #240
	cmp	r3, #160
	bne	.L4
	ldr	r0, .L9+12
	bl	puts
	b	.L5
.L4:
	ldr	r0, .L9+16
	bl	puts
.L5:
	ldr	r3, [fp, #-8]
	and	r3, r3, #15
	cmp	r3, #13
	bne	.L6
	ldr	r0, .L9+20
	bl	puts
	b	.L7
.L6:
	ldr	r0, .L9+24
	bl	puts
.L7:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L10:
	.align	2
.L9:
	.word	43981
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
