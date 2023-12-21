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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0]
	add	r3, r3, #1
	str	r3, [r0]
	subs	r0, r3, #1
	movne	r0, #1
	bx	lr
	.size	foo, .-foo
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Access denied.\000"
	.align	2
.LC1:
	.ascii	"Access granted.\000"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	bl	getchar
	cmp	r0, #0
	beq	.L7
	ldr	r0, .L8
	bl	puts
	mov	r0, #0
.L3:
	pop	{r4, lr}
	bx	lr
.L7:
	ldr	r0, .L8+4
	bl	puts
	mov	r0, #1
	b	.L3
.L9:
	.align	2
.L8:
	.word	.LC1
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
