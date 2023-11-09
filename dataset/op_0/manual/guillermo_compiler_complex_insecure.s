36-37
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
	.file	"guillermo_compiler_complex_insecure.c"
	.text
	.align	2
	.global	foo
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	foo, %function
foo:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	add	r2, r3, #1
	ldr	r3, [fp, #-8]
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	cmp	r3, #1
	bne	.L2
	mov	r3, #0
	b	.L3
.L2:
	mov	r3, #1
.L3:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	foo, .-foo
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Access granted.\000"
	.align	2
.LC1:
	.ascii	"Access denied.\000"
	.text
	.align	2
	.global	main
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
	bl	getchar
	mov	r3, r0
	str	r3, [fp, #-8]
	sub	r3, fp, #8
	mov	r0, r3
	bl	foo
	mov	r3, r0
	cmp	r3, #1
	bne	.L5
	ldr	r0, .L9
	bl	puts
	mov	r3, #0
	b	.L8
.L5:
	ldr	r0, .L9+4
	bl	puts
	mov	r3, #1
.L8:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L10:
	.align	2
.L9:
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
