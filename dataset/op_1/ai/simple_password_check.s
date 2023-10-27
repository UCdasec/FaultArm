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
	.file	"simple_password_check.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"secure123\000"
	.text
	.align	2
	.global	check_password
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	check_password, %function
check_password:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r1, .L3
	bl	strcmp
	rsbs	r0, r0, #1
	movcc	r0, #0
	pop	{r4, lr}
	bx	lr
.L4:
	.align	2
.L3:
	.word	.LC0
	.size	check_password, .-check_password
	.section	.rodata.str1.4
	.align	2
.LC1:
	.ascii	"Enter password: \000"
	.align	2
.LC2:
	.ascii	"%49s\000"
	.align	2
.LC3:
	.ascii	"Access granted.\000"
	.align	2
.LC4:
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
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #60
	ldr	r0, .L9
	bl	printf
	add	r1, sp, #4
	ldr	r0, .L9+4
	bl	scanf
	add	r0, sp, #4
	bl	check_password
	cmp	r0, #0
	ldrne	r0, .L9+8
	ldreq	r0, .L9+12
	bl	puts
	mov	r0, #0
	add	sp, sp, #60
	@ sp needed
	ldr	lr, [sp], #4
	bx	lr
.L10:
	.align	2
.L9:
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
