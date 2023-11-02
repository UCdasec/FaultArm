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
	.file	"calibration.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Probe Calibration Program\000"
	.align	2
.LC1:
	.ascii	"Do you want to set calibration (S) or load calibrat"
	.ascii	"ion (L)? \000"
	.align	2
.LC2:
	.ascii	" %c\000"
	.align	2
.LC3:
	.ascii	"Enter calibration values for:\000"
	.align	2
.LC4:
	.ascii	"North: \000"
	.align	2
.LC5:
	.ascii	"%f\000"
	.align	2
.LC6:
	.ascii	"South: \000"
	.align	2
.LC7:
	.ascii	"East: \000"
	.align	2
.LC8:
	.ascii	"West: \000"
	.align	2
.LC9:
	.ascii	"Up: \000"
	.align	2
.LC10:
	.ascii	"Down: \000"
	.align	2
.LC11:
	.ascii	"w\000"
	.align	2
.LC12:
	.ascii	"calibration\000"
	.align	2
.LC13:
	.ascii	"Error opening the calibration file for writing.\000"
	.global	__aeabi_f2d
	.align	2
.LC14:
	.ascii	"%.2f %.2f %.2f %.2f %.2f %.2f\000"
	.align	2
.LC15:
	.ascii	"Calibration values have been set and saved to the '"
	.ascii	"calibration' file.\000"
	.align	2
.LC16:
	.ascii	"r\000"
	.align	2
.LC17:
	.ascii	"Error opening the calibration file for reading. Cal"
	.ascii	"ibration values are not set.\000"
	.align	2
.LC18:
	.ascii	"%f %f %f %f %f %f\000"
	.align	2
.LC19:
	.ascii	"Loaded Calibration Values:\000"
	.align	2
.LC20:
	.ascii	"North: %.2f\012\000"
	.align	2
.LC21:
	.ascii	"South: %.2f\012\000"
	.align	2
.LC22:
	.ascii	"East: %.2f\012\000"
	.align	2
.LC23:
	.ascii	"West: %.2f\012\000"
	.align	2
.LC24:
	.ascii	"Up: %.2f\012\000"
	.align	2
.LC25:
	.ascii	"Down: %.2f\012\000"
	.align	2
.LC26:
	.ascii	"Invalid choice. Please enter 'S' to set calibration"
	.ascii	" or 'L' to load calibration.\000"
	.text
	.align	2
	.global	main
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #96
	ldr	r0, .L12
	bl	puts
	ldr	r0, .L12+4
	bl	printf
	sub	r3, fp, #37
	mov	r1, r3
	ldr	r0, .L12+8
	bl	scanf
	ldrb	r3, [fp, #-37]	@ zero_extendqisi2
	cmp	r3, #83
	beq	.L2
	ldrb	r3, [fp, #-37]	@ zero_extendqisi2
	cmp	r3, #115
	bne	.L3
.L2:
	ldr	r0, .L12+12
	bl	puts
	ldr	r0, .L12+16
	bl	printf
	sub	r3, fp, #64
	mov	r1, r3
	ldr	r0, .L12+20
	bl	scanf
	ldr	r0, .L12+24
	bl	printf
	sub	r3, fp, #64
	add	r3, r3, #4
	mov	r1, r3
	ldr	r0, .L12+20
	bl	scanf
	ldr	r0, .L12+28
	bl	printf
	sub	r3, fp, #64
	add	r3, r3, #8
	mov	r1, r3
	ldr	r0, .L12+20
	bl	scanf
	ldr	r0, .L12+32
	bl	printf
	sub	r3, fp, #64
	add	r3, r3, #12
	mov	r1, r3
	ldr	r0, .L12+20
	bl	scanf
	ldr	r0, .L12+36
	bl	printf
	sub	r3, fp, #64
	add	r3, r3, #16
	mov	r1, r3
	ldr	r0, .L12+20
	bl	scanf
	ldr	r0, .L12+40
	bl	printf
	sub	r3, fp, #64
	add	r3, r3, #20
	mov	r1, r3
	ldr	r0, .L12+20
	bl	scanf
	ldr	r1, .L12+44
	ldr	r0, .L12+48
	bl	fopen
	str	r0, [fp, #-36]
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	bne	.L4
	ldr	r0, .L12+52
	bl	puts
	mov	r3, #1
	b	.L11
.L4:
	ldr	r3, [fp, #-64]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	str	r0, [fp, #-76]
	str	r1, [fp, #-72]
	ldr	r3, [fp, #-60]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r4, r0
	mov	r5, r1
	ldr	r3, [fp, #-56]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r6, r0
	mov	r7, r1
	ldr	r3, [fp, #-52]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r8, r0
	mov	r9, r1
	ldr	r3, [fp, #-48]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	str	r0, [fp, #-84]
	str	r1, [fp, #-80]
	ldr	r3, [fp, #-44]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	str	r2, [sp, #32]
	str	r3, [sp, #36]
	sub	r2, fp, #84
	ldmia	r2, {r1-r2}
	str	r1, [sp, #24]
	str	r2, [sp, #28]
	str	r8, [sp, #16]
	str	r9, [sp, #20]
	str	r6, [sp, #8]
	str	r7, [sp, #12]
	stm	sp, {r4-r5}
	sub	r3, fp, #76
	ldmia	r3, {r2-r3}
	ldr	r1, .L12+56
	ldr	r0, [fp, #-36]
	bl	fprintf
	ldr	r0, [fp, #-36]
	bl	fclose
	ldr	r0, .L12+60
	bl	puts
	b	.L6
.L3:
	ldrb	r3, [fp, #-37]	@ zero_extendqisi2
	cmp	r3, #76
	beq	.L7
	ldrb	r3, [fp, #-37]	@ zero_extendqisi2
	cmp	r3, #108
	bne	.L8
.L7:
	ldr	r1, .L12+64
	ldr	r0, .L12+48
	bl	fopen
	str	r0, [fp, #-32]
	ldr	r3, [fp, #-32]
	cmp	r3, #0
	bne	.L9
	ldr	r0, .L12+68
	bl	puts
	b	.L6
.L9:
	sub	r3, fp, #64
	add	r1, r3, #4
	sub	r2, fp, #64
	sub	r3, fp, #64
	add	r3, r3, #20
	str	r3, [sp, #12]
	sub	r3, fp, #64
	add	r3, r3, #16
	str	r3, [sp, #8]
	sub	r3, fp, #64
	add	r3, r3, #12
	str	r3, [sp, #4]
	sub	r3, fp, #64
	add	r3, r3, #8
	str	r3, [sp]
	mov	r3, r1
	ldr	r1, .L12+72
	ldr	r0, [fp, #-32]
	bl	fscanf
	ldr	r0, [fp, #-32]
	bl	fclose
	ldr	r0, .L12+76
	bl	puts
	ldr	r3, [fp, #-64]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+80
	bl	printf
	ldr	r3, [fp, #-60]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+84
	bl	printf
	ldr	r3, [fp, #-56]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+88
	bl	printf
	ldr	r3, [fp, #-52]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+92
	bl	printf
	ldr	r3, [fp, #-48]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+96
	bl	printf
	ldr	r3, [fp, #-44]	@ float
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+100
	bl	printf
	b	.L6
.L8:
	ldr	r0, .L12+104
	bl	puts
.L6:
	mov	r3, #0
.L11:
	mov	r0, r3
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, lr}
	bx	lr
.L13:
	.align	2
.L12:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
