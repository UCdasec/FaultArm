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
	.file	"rpm_plot.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"a\000"
	.align	2
.LC1:
	.ascii	"plot_data.dat\000"
	.align	2
.LC2:
	.ascii	"Error opening the plot data file.\000"
	.align	2
.LC3:
	.ascii	"%.2lf %.2lf\012\000"
	.text
	.align	2
	.global	updatePlotFile
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	updatePlotFile, %function
updatePlotFile:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	str	r0, [fp, #-20]
	str	r1, [fp, #-16]
	str	r2, [fp, #-28]
	str	r3, [fp, #-24]
	ldr	r1, .L3
	ldr	r0, .L3+4
	bl	fopen
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bne	.L2
	ldr	r0, .L3+8
	bl	puts
	mov	r0, #1
	bl	exit
.L2:
	sub	r3, fp, #28
	ldmia	r3, {r2-r3}
	stm	sp, {r2-r3}
	sub	r3, fp, #20
	ldmia	r3, {r2-r3}
	ldr	r1, .L3+12
	ldr	r0, [fp, #-8]
	bl	fprintf
	ldr	r0, [fp, #-8]
	bl	fclose
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L4:
	.align	2
.L3:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.size	updatePlotFile, .-updatePlotFile
	.section	.rodata
	.align	2
.LC4:
	.ascii	"w\000"
	.align	2
.LC5:
	.ascii	"Continuous X-Y Plot Generator\000"
	.align	2
.LC6:
	.ascii	"Enter a value (or 'q' to quit): \000"
	.align	2
.LC7:
	.ascii	"%lf\000"
	.align	2
.LC8:
	.ascii	"%c\000"
	.align	2
.LC9:
	.ascii	"Invalid input. Please enter a numeric value.\000"
	.align	2
.LC10:
	.ascii	"Time: %.2lf seconds, Value: %.2lf\012\000"
	.align	2
.LC11:
	.ascii	"Exiting the program.\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #56
	ldr	r1, .L14
	ldr	r0, .L14+4
	bl	fopen
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L6
	ldr	r0, .L14+8
	bl	puts
	mov	r3, #1
	b	.L13
.L6:
	ldr	r0, [fp, #-16]
	bl	fclose
	ldr	r0, .L14+12
	bl	puts
.L12:
	ldr	r0, .L14+16
	bl	printf
	sub	r3, fp, #44
	mov	r1, r3
	ldr	r0, .L14+20
	bl	scanf
	mov	r3, r0
	cmp	r3, #1
	beq	.L8
	sub	r3, fp, #45
	mov	r1, r3
	ldr	r0, .L14+24
	bl	scanf
	ldrb	r3, [fp, #-45]	@ zero_extendqisi2
	cmp	r3, #113
	beq	.L9
	ldrb	r3, [fp, #-45]	@ zero_extendqisi2
	cmp	r3, #81
	beq	.L9
	ldr	r0, .L14+28
	bl	puts
	b	.L10
.L8:
	mov	r0, #0
	bl	time
	str	r0, [fp, #-28]
	str	r1, [fp, #-24]
	sub	r3, fp, #12
	ldmia	r3, {r2-r3}
	orrs	r3, r2, r3
	bne	.L11
	sub	r3, fp, #28
	ldmia	r3, {r2-r3}
	str	r2, [fp, #-12]
	str	r3, [fp, #-8]
.L11:
	sub	r3, fp, #12
	ldmia	r3, {r2-r3}
	sub	r1, fp, #28
	ldmia	r1, {r0-r1}
	bl	difftime
	str	r0, [fp, #-36]
	str	r1, [fp, #-32]
	sub	r3, fp, #44
	ldmia	r3, {r2-r3}
	sub	r1, fp, #36
	ldmia	r1, {r0-r1}
	bl	updatePlotFile
	sub	r3, fp, #44
	ldmia	r3, {r2-r3}
	stm	sp, {r2-r3}
	sub	r3, fp, #36
	ldmia	r3, {r2-r3}
	ldr	r0, .L14+32
	bl	printf
.L10:
	b	.L12
.L9:
	ldr	r0, .L14+36
	bl	puts
	mov	r3, #0
.L13:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L15:
	.align	2
.L14:
	.word	.LC4
	.word	.LC1
	.word	.LC2
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
