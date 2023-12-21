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
	.file	"rate_limiting_brute_force.c"
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
	.align	2
.LC5:
	.ascii	"Too many incorrect attempts.\000"
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
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r4, #3
	ldr	r7, .L16
	ldr	r6, .L16+4
	ldr	r5, .L16+8
	ldr	r9, .L16+12
	ldr	r8, .L16+16
	sub	sp, sp, #60
.L11:
	mov	r0, r7
	bl	printf
	mov	r0, r6
	add	r1, sp, #4
	bl	scanf
	ldr	r3, [sp, #4]
	cmp	r3, r5
	beq	.L15
.L12:
	mov	r0, r8
	bl	puts
	mov	r0, #1
	bl	sleep
	subs	r4, r4, #1
	bne	.L11
	ldr	r0, .L16+20
	bl	puts
	mov	r4, #1
.L6:
	mov	r0, r4
	add	sp, sp, #60
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, lr}
	bx	lr
.L15:
	ldr	r3, [sp, #8]
	cmp	r3, r9
	bne	.L12
	ldrh	r3, [sp, #12]
	cmp	r3, #51
	bne	.L12
	ldr	r0, .L16+24
	mov	r4, #0
	bl	puts
	b	.L6
.L17:
	.align	2
.L16:
	.word	.LC1
	.word	.LC2
	.word	1969448307
	.word	842098034
	.word	.LC4
	.word	.LC5
	.word	.LC3
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
