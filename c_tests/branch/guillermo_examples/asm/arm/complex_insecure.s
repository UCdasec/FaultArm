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
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Condition is true.\000"
	.align	2
.LC1:
	.ascii	"Condition is false.\000"
	.align	2
.LC2:
	.ascii	"Another condition is true.\000"
	.align	2
.LC3:
	.ascii	"Another condition is false.\000"
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
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-12]
	cmp	r3, #1
	bne	.L2
	ldr	r0, .L7
	bl	puts
	b	.L3
.L2:
	ldr	r0, .L7+4
	bl	puts
.L3:
	mov	r3, #0
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L4
	ldr	r0, .L7+8
	bl	puts
	b	.L5
.L4:
	ldr	r0, .L7+12
	bl	puts
.L5:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L8:
	.align	2
.L7:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.size	basic_comp, .-basic_comp
	.section	.rodata
	.align	2
.LC4:
	.ascii	"Both condition and x < y are true.\000"
	.align	2
.LC5:
	.ascii	"Either condition or x < y is false.\000"
	.align	2
.LC6:
	.ascii	"Either anotherCondition or z > y is true.\000"
	.align	2
.LC7:
	.ascii	"Both anotherCondition and z > y are false.\000"
	.align	2
.LC8:
	.ascii	"x is equal to y.\000"
	.align	2
.LC9:
	.ascii	"x is not equal to y.\000"
	.text
	.align	2
	.global	advanced_comp
	.syntax unified
	.arm
	.fpu softvfp
	.type	advanced_comp, %function
advanced_comp:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	mov	r3, #1
	str	r3, [fp, #-28]
	mov	r3, #5
	str	r3, [fp, #-24]
	mov	r3, #10
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-28]
	cmp	r3, #0
	beq	.L10
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bge	.L10
	ldr	r0, .L18
	bl	puts
	b	.L11
.L10:
	ldr	r0, .L18+4
	bl	puts
.L11:
	mov	r3, #0
	str	r3, [fp, #-16]
	mov	r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L12
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	ble	.L13
.L12:
	ldr	r0, .L18+8
	bl	puts
	b	.L14
.L13:
	ldr	r0, .L18+12
	bl	puts
.L14:
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	moveq	r3, #1
	movne	r3, #0
	and	r3, r3, #255
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L15
	ldr	r0, .L18+16
	bl	puts
	b	.L16
.L15:
	ldr	r0, .L18+20
	bl	puts
.L16:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L19:
	.align	2
.L18:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.size	advanced_comp, .-advanced_comp
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
