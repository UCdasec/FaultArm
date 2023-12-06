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
	.file	"rpm_plot.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r6, r7, r8, r9, lr}
	mov	r8, r0
	mov	r9, r1
	ldr	r0, .L6
	ldr	r1, .L6+4
	sub	sp, sp, #8
	mov	r6, r2
	mov	r7, r3
	bl	fopen
	subs	r4, r0, #0
	beq	.L5
	mov	r2, r8
	mov	r3, r9
	ldr	r1, .L6+8
	stm	sp, {r6-r7}
	bl	fprintf
	mov	r0, r4
	bl	fclose
	add	sp, sp, #8
	@ sp needed
	pop	{r4, r6, r7, r8, r9, lr}
	bx	lr
.L5:
	ldr	r0, .L6+12
	bl	puts
	mov	r0, #1
	bl	exit
.L7:
	.align	2
.L6:
	.word	.LC1
	.word	.LC0
	.word	.LC3
	.word	.LC2
	.size	updatePlotFile, .-updatePlotFile
	.section	.rodata.str1.4
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
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	ldr	r1, .L19
	ldr	r0, .L19+4
	sub	sp, sp, #24
	bl	fopen
	cmp	r0, #0
	beq	.L17
	bl	fclose
	ldr	r0, .L19+8
	bl	puts
	ldr	r5, .L19+12
	ldr	r4, .L19+16
	ldr	r10, .L19+20
.L11:
	mov	r0, r5
	bl	printf
	mov	r0, r4
	add	r1, sp, #16
	bl	scanf
	cmp	r0, #1
	beq	.L12
	mov	r0, r10
	add	r1, sp, #15
	bl	scanf
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	and	r3, r3, #223
	cmp	r3, #81
	bne	.L18
	ldr	r0, .L19+24
	bl	puts
	mov	r0, #0
.L8:
	add	sp, sp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, lr}
	bx	lr
.L12:
	mov	r0, #0
	bl	time
	orrs	r3, r6, r7
	moveq	r6, r0
	moveq	r7, r1
.L15:
	mov	r2, r6
	mov	r3, r7
	bl	difftime
	mov	r8, r0
	mov	r9, r1
	add	r3, sp, #16
	ldmia	r3, {r2-r3}
	bl	updatePlotFile
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	mov	r2, r8
	stm	sp, {r0-r1}
	mov	r3, r9
	ldr	r0, .L19+28
	bl	printf
	b	.L11
.L18:
	ldr	r0, .L19+32
	bl	puts
	b	.L11
.L17:
	ldr	r0, .L19+36
	bl	puts
	mov	r0, #1
	b	.L8
.L20:
	.align	2
.L19:
	.word	.LC4
	.word	.LC1
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC11
	.word	.LC10
	.word	.LC9
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
