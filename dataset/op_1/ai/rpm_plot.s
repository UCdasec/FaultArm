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
	push	{r4, r5, r6, r7, r8, lr}
	sub	sp, sp, #8
	mov	r4, r0
	mov	r5, r1
	mov	r6, r2
	mov	r7, r3
	ldr	r1, .L5
	ldr	r0, .L5+4
	bl	fopen
	subs	r8, r0, #0
	beq	.L4
	stm	sp, {r6-r7}
	mov	r2, r4
	mov	r3, r5
	ldr	r1, .L5+8
	mov	r0, r8
	bl	fprintf
	mov	r0, r8
	bl	fclose
	add	sp, sp, #8
	@ sp needed
	pop	{r4, r5, r6, r7, r8, lr}
	bx	lr
.L4:
	ldr	r0, .L5+12
	bl	puts
	mov	r0, #1
	bl	exit
.L6:
	.align	2
.L5:
	.word	.LC0
	.word	.LC1
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
	.text
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
	sub	sp, sp, #24
	ldr	r1, .L18
	ldr	r0, .L18+4
	bl	fopen
	cmp	r0, #0
	beq	.L16
	bl	fclose
	ldr	r0, .L18+8
	bl	puts
	ldr	r7, .L18+12
	ldr	r6, .L18+16
	ldr	r10, .L18+20
.L10:
	mov	r0, r7
	bl	printf
	add	r1, sp, #16
	mov	r0, r6
	bl	scanf
	cmp	r0, #1
	beq	.L11
	add	r1, sp, #15
	mov	r0, r10
	bl	scanf
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	and	r3, r3, #223
	cmp	r3, #81
	bne	.L17
	ldr	r0, .L18+24
	bl	puts
	mov	r0, #0
.L7:
	add	sp, sp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, lr}
	bx	lr
.L16:
	ldr	r0, .L18+28
	bl	puts
	mov	r0, #1
	b	.L7
.L17:
	ldr	r0, .L18+32
	bl	puts
	b	.L10
.L11:
	mov	r0, #0
	bl	time
	orrs	r3, r4, r5
	moveq	r4, r0
	moveq	r5, r1
.L14:
	mov	r2, r4
	mov	r3, r5
	bl	difftime
	mov	r8, r0
	mov	r9, r1
	add	r3, sp, #16
	ldmia	r3, {r2-r3}
	bl	updatePlotFile
	add	r3, sp, #16
	ldmia	r3, {r2-r3}
	stm	sp, {r2-r3}
	mov	r2, r8
	mov	r3, r9
	ldr	r0, .L18+36
	bl	printf
	b	.L10
.L19:
	.align	2
.L18:
	.word	.LC4
	.word	.LC1
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC11
	.word	.LC2
	.word	.LC9
	.word	.LC10
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
