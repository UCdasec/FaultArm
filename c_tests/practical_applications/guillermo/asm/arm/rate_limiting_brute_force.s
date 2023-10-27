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
	.file	"rate_limiting_brute_force.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"secure123\000"
	.text
	.align	2
	.global	check_password
	.syntax unified
	.arm
	.fpu softvfp
	.type	check_password, %function
check_password:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	ldr	r3, .L3
	str	r3, [fp, #-8]
	ldr	r1, [fp, #-8]
	ldr	r0, [fp, #-16]
	bl	strcmp
	mov	r3, r0
	cmp	r3, #0
	moveq	r3, #1
	movne	r3, #0
	and	r3, r3, #255
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L4:
	.align	2
.L3:
	.word	.LC0
	.size	check_password, .-check_password
	.section	.rodata
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
	.align	2
.LC5:
	.ascii	"Too many incorrect attempts.\000"
	.align	2
.LC6:
	.word	__stack_chk_guard
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #64
	ldr	r3, .L12
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3,#0
	mov	r3, #0
	str	r3, [fp, #-64]
	b	.L6
.L9:
	ldr	r0, .L12+4
	bl	printf
	sub	r3, fp, #60
	mov	r1, r3
	ldr	r0, .L12+8
	bl	__isoc99_scanf
	sub	r3, fp, #60
	mov	r0, r3
	bl	check_password
	mov	r3, r0
	cmp	r3, #0
	beq	.L7
	ldr	r0, .L12+12
	bl	puts
	mov	r3, #0
	b	.L10
.L7:
	ldr	r0, .L12+16
	bl	puts
	ldr	r3, [fp, #-64]
	add	r3, r3, #1
	str	r3, [fp, #-64]
	mov	r0, #1
	bl	sleep
.L6:
	ldr	r3, [fp, #-64]
	cmp	r3, #2
	ble	.L9
	ldr	r0, .L12+20
	bl	puts
	mov	r3, #1
.L10:
	ldr	r2, .L12
	ldr	r1, [r2]
	ldr	r2, [fp, #-8]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L11
	bl	__stack_chk_fail
.L11:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L13:
	.align	2
.L12:
	.word	.LC6
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
