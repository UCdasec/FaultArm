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
	.ascii	"%x, %x, %x, %x, %x\000"
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
	sub	sp, sp, #16
	ldr	r3, .L3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	and	r1, r3, #3840
	ldr	r3, [fp, #-8]
	and	r3, r3, #240
	ldr	r2, [fp, #-8]
	and	r2, r2, #15
	str	r2, [sp, #4]
	str	r3, [sp]
	mov	r3, r1
	mov	r2, #3840
	ldr	r1, [fp, #-8]
	ldr	r0, .L3+4
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L4:
	.align	2
.L3:
	.word	43981
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
