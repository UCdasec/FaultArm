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
	.file	"complex_insecure.c"
	.text
	.align	2
	.global	basic_comp
	.syntax unified
	.arm
	.fpu softvfp
	.type	basic_comp, %function
basic_comp:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	mov	r3, #1
	str	r3, [fp, #-8]
	ldr	r0, [fp, #-8]
	bl	branch_check
	nop
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	basic_comp, .-basic_comp
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Executing critical code... \000"
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #1
	bne	.L3
	ldr	r0, .L6
	bl	puts
	b	.L4
.L3:
	ldr	r0, .L6+4
	bl	puts
.L4:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L7:
	.align	2
.L6:
	.word	.LC0
	.word	.LC1
	.size	branch_check, .-branch_check
	.section	.rodata
	.align	2
.LC2:
	.ascii	"Both x < y and condition are true. \000"
	.align	2
.LC3:
	.ascii	"Both x < y and condition are false. \000"
	.align	2
.LC4:
	.ascii	"Either anothercondition or z > y is true and condit"
	.ascii	"ion is true. \000"
	.align	2
.LC5:
	.ascii	"Either anothercondition or z > y is true but condit"
	.ascii	"ion is false. \000"
	.align	2
.LC6:
	.ascii	"Both anotherCondition and z > y are false.\000"
	.text
	.align	2
	.global	adv_comp
	.syntax unified
	.arm
	.fpu softvfp
	.type	adv_comp, %function
adv_comp:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	mov	r3, #1
	str	r3, [fp, #-24]
	mov	r3, #8
	str	r3, [fp, #-20]
	mov	r3, #10
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bge	.L9
	ldr	r0, [fp, #-24]
	bl	branch_check
	mov	r3, r0
	cmp	r3, #0
	beq	.L9
	ldr	r0, .L16
	bl	puts
	b	.L10
.L9:
	ldr	r0, .L16+4
	bl	puts
.L10:
	mov	r3, #0
	str	r3, [fp, #-12]
	mov	r3, #12
	str	r3, [fp, #-8]
	ldr	r0, [fp, #-12]
	bl	branch_check
	mov	r3, r0
	cmp	r3, #0
	bne	.L11
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	ble	.L12
.L11:
	ldr	r0, [fp, #-24]
	bl	branch_check
	mov	r3, r0
	cmp	r3, #0
	beq	.L13
	ldr	r0, .L16+8
	bl	puts
	b	.L15
.L13:
	ldr	r0, .L16+12
	bl	puts
	b	.L15
.L12:
	ldr	r0, .L16+16
	bl	puts
.L15:
	nop
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L17:
	.align	2
.L16:
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.size	adv_comp, .-adv_comp
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
