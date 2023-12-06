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
	ldr	r1, .L4
	bl	strcmp
	rsbs	r0, r0, #1
	movcc	r0, #0
	pop	{r4, lr}
	bx	lr
.L5:
	.align	2
.L4:
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
	.section	.text.startup,"ax",%progbits
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
	ldr	r0, .L13
	sub	sp, sp, #60
	bl	printf
	ldr	r0, .L13+4
	add	r1, sp, #4
	bl	scanf
	ldr	r3, .L13+8
	ldr	r2, [sp, #4]
	cmp	r2, r3
	beq	.L12
.L7:
	ldr	r0, .L13+12
	bl	puts
.L10:
	mov	r0, #0
	add	sp, sp, #60
	@ sp needed
	ldr	lr, [sp], #4
	bx	lr
.L12:
	add	r3, r3, #-1124073472
	ldr	r2, [sp, #8]
	sub	r3, r3, #3276800
	sub	r3, r3, #1
	cmp	r2, r3
	bne	.L7
	ldrh	r3, [sp, #12]
	cmp	r3, #51
	bne	.L7
	ldr	r0, .L13+16
	bl	puts
	b	.L10
.L14:
	.align	2
.L13:
	.word	.LC1
	.word	.LC2
	.word	1969448307
	.word	.LC4
	.word	.LC3
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
