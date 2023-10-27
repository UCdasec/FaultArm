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
	.file	"guillermo_constant_simple_secure.c"
	.text
	.data
	.align	1
	.type	STATE_INIT, %object
	.size	STATE_INIT, 2
STATE_INIT:
	.short	23100
	.align	1
	.type	STATE_PERSO, %object
	.size	STATE_PERSO, 2
STATE_PERSO:
	.short	-23101
	.align	1
	.type	STATE_ISSUED, %object
	.size	STATE_ISSUED, 2
STATE_ISSUED:
	.short	15450
	.align	1
	.type	STATE_LOCKED, %object
	.size	STATE_LOCKED, 2
STATE_LOCKED:
	.short	-15451
	.align	1
	.type	closeHamming1, %object
	.size	closeHamming1, 2
closeHamming1:
	.short	13107
	.align	1
	.type	closeHamming2, %object
	.size	closeHamming2, 2
closeHamming2:
	.short	13106
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Constant coding example.\000"
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
	mov	r3, #1012
	str	r3, [fp, #-8]
	mov	r3, #1000
	str	r3, [fp, #-12]
	ldr	r3, .L3
	str	r3, [fp, #-16]
	ldr	r0, .L3+4
	bl	puts
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L4:
	.align	2
.L3:
	.word	3000
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
