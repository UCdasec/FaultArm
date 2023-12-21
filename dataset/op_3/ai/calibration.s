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
	.file	"calibration.c"
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
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
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r6, r7, lr}
	ldr	r0, .L12
	sub	sp, sp, #72
	bl	puts
	ldr	r0, .L12+4
	bl	printf
	ldr	r0, .L12+8
	add	r1, sp, #47
	bl	scanf
	ldrb	r3, [sp, #47]	@ zero_extendqisi2
	and	r3, r3, #223
	cmp	r3, #83
	beq	.L9
	cmp	r3, #76
	bne	.L5
	ldr	r1, .L12+12
	ldr	r0, .L12+16
	bl	fopen
	subs	r4, r0, #0
	beq	.L10
	add	ip, sp, #68
	add	r1, sp, #64
	add	r2, sp, #60
	add	r3, sp, #56
	str	ip, [sp, #12]
	str	r1, [sp, #8]
	str	r2, [sp, #4]
	ldr	r1, .L12+20
	add	r2, sp, #48
	str	r3, [sp]
	add	r3, sp, #52
	bl	fscanf
	mov	r0, r4
	bl	fclose
	ldr	r0, .L12+24
	bl	puts
	ldr	r0, [sp, #48]	@ float
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+28
	bl	printf
	ldr	r0, [sp, #52]	@ float
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+32
	bl	printf
	ldr	r0, [sp, #56]	@ float
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+36
	bl	printf
	ldr	r0, [sp, #60]	@ float
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+40
	bl	printf
	ldr	r0, [sp, #64]	@ float
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+44
	bl	printf
	ldr	r0, [sp, #68]	@ float
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L12+48
	bl	printf
	mov	r0, #0
	b	.L1
.L5:
	ldr	r0, .L12+52
	bl	puts
	mov	r0, #0
.L1:
	add	sp, sp, #72
	@ sp needed
	pop	{r4, r6, r7, lr}
	bx	lr
.L9:
	ldr	r0, .L12+56
	bl	puts
	ldr	r0, .L12+60
	bl	printf
	add	r1, sp, #48
	ldr	r0, .L12+64
	bl	scanf
	ldr	r0, .L12+68
	bl	printf
	add	r1, sp, #52
	ldr	r0, .L12+64
	bl	scanf
	ldr	r0, .L12+72
	bl	printf
	add	r1, sp, #56
	ldr	r0, .L12+64
	bl	scanf
	ldr	r0, .L12+76
	bl	printf
	add	r1, sp, #60
	ldr	r0, .L12+64
	bl	scanf
	ldr	r0, .L12+80
	bl	printf
	add	r1, sp, #64
	ldr	r0, .L12+64
	bl	scanf
	ldr	r0, .L12+84
	bl	printf
	add	r1, sp, #68
	ldr	r0, .L12+64
	bl	scanf
	ldr	r1, .L12+88
	ldr	r0, .L12+16
	bl	fopen
	subs	r4, r0, #0
	beq	.L11
	ldr	r0, [sp, #48]	@ float
	bl	__aeabi_f2d
	mov	r6, r0
	ldr	r0, [sp, #68]	@ float
	mov	r7, r1
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, [sp, #64]	@ float
	str	r2, [sp, #32]
	str	r3, [sp, #36]
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, [sp, #60]	@ float
	str	r2, [sp, #24]
	str	r3, [sp, #28]
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, [sp, #56]	@ float
	str	r2, [sp, #16]
	str	r3, [sp, #20]
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, [sp, #52]	@ float
	str	r2, [sp, #8]
	str	r3, [sp, #12]
	bl	__aeabi_f2d
	mov	r2, r6
	mov	r3, r7
	stm	sp, {r0-r1}
	ldr	r1, .L12+92
	mov	r0, r4
	bl	fprintf
	mov	r0, r4
	bl	fclose
	ldr	r0, .L12+96
	bl	puts
	mov	r0, #0
	b	.L1
.L10:
	ldr	r0, .L12+100
	bl	puts
	mov	r0, r4
	b	.L1
.L11:
	ldr	r0, .L12+104
	bl	puts
	mov	r0, #1
	b	.L1
.L13:
	.align	2
.L12:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC16
	.word	.LC12
	.word	.LC18
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC14
	.word	.LC15
	.word	.LC17
	.word	.LC13
	.size	main, .-main
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
