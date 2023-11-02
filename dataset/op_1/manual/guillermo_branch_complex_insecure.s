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
	.file	"guillermo_branch_complex_insecure.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Condition is true.\000"
	.align	2
.LC1:
	.ascii	"Another condition is false.\000"
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
	ldr	r0, .L3
	bl	puts
	ldr	r0, .L3+4
	bl	puts
	mov	r0, #0
	pop	{r4, lr}
	bx	lr
.L4:
	.align	2
.L3:
	.word	.LC0
	.word	.LC1
	.size	basic_comp, .-basic_comp
	.section	.rodata.str1.4
	.align	2
.LC2:
	.ascii	"Both condition and x < y are true.\000"
	.align	2
.LC3:
	.ascii	"Either anotherCondition or z > y is true.\000"
	.align	2
.LC4:
	.ascii	"x is not equal to y.\000"
	.text
	.align	2
	.global	advanced_comp
	.syntax unified
	.arm
	.fpu softvfp
	.type	advanced_comp, %function
advanced_comp:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L7
	bl	puts
	ldr	r0, .L7+4
	bl	puts
	ldr	r0, .L7+8
	bl	puts
	mov	r0, #0
	pop	{r4, lr}
	bx	lr
.L8:
	.align	2
.L7:
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.size	advanced_comp, .-advanced_comp
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
