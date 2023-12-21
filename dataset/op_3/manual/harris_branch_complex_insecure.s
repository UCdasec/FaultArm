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
	.file	"harris_branch_complex_insecure.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Executing critical code... \000"
	.text
	.align	2
	.global	basic_comp
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	basic_comp, %function
basic_comp:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L4
	bl	puts
	pop	{r4, lr}
	bx	lr
.L5:
	.align	2
.L4:
	.word	.LC0
	.size	basic_comp, .-basic_comp
	.section	.rodata.str1.4
	.align	2
.LC1:
	.ascii	"Exiting out... \000"
	.text
	.align	2
	.global	branch_check
	.syntax unified
	.arm
	.fpu softvfp
	.type	branch_check, %function
branch_check:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	cmp	r0, #1
	ldreq	r0, .L10
	ldrne	r0, .L10+4
	bl	puts
	mov	r0, #0
	pop	{r4, lr}
	bx	lr
.L11:
	.align	2
.L10:
	.word	.LC0
	.word	.LC1
	.size	branch_check, .-branch_check
	.section	.rodata.str1.4
	.align	2
.LC2:
	.ascii	"Both x < y and condition are false. \000"
	.align	2
.LC3:
	.ascii	"Either anothercondition or z > y is true but condit"
	.ascii	"ion is false. \000"
	.text
	.align	2
	.global	adv_comp
	.syntax unified
	.arm
	.fpu softvfp
	.type	adv_comp, %function
adv_comp:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r4, .L14
	mov	r0, r4
	bl	puts
	ldr	r0, .L14+4
	bl	puts
	ldr	r0, .L14+8
	bl	puts
	mov	r0, r4
	bl	puts
	ldr	r0, .L14+12
	bl	puts
	pop	{r4, lr}
	bx	lr
.L15:
	.align	2
.L14:
	.word	.LC0
	.word	.LC2
	.word	.LC1
	.word	.LC3
	.size	adv_comp, .-adv_comp
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
