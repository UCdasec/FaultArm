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
	.file	"guillermo_branch_complex_secure.c"
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
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
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
	pop	{fp, lr}
	bx	lr
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
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
