	.file	"calibration.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Probe Calibration Program"
	.align	3
.LC1:
	.string	"Do you want to set calibration (S) or load calibration (L)? "
	.align	3
.LC2:
	.string	" %c"
	.align	3
.LC3:
	.string	"Enter calibration values for:"
	.align	3
.LC4:
	.string	"North: "
	.align	3
.LC5:
	.string	"%f"
	.align	3
.LC6:
	.string	"South: "
	.align	3
.LC7:
	.string	"East: "
	.align	3
.LC8:
	.string	"West: "
	.align	3
.LC9:
	.string	"Up: "
	.align	3
.LC10:
	.string	"Down: "
	.align	3
.LC11:
	.string	"w"
	.align	3
.LC12:
	.string	"calibration"
	.align	3
.LC13:
	.string	"Error opening the calibration file for writing."
	.align	3
.LC14:
	.string	"%.2f %.2f %.2f %.2f %.2f %.2f"
	.align	3
.LC15:
	.string	"Calibration values have been set and saved to the 'calibration' file."
	.align	3
.LC16:
	.string	"r"
	.align	3
.LC17:
	.string	"Error opening the calibration file for reading. Calibration values are not set."
	.align	3
.LC18:
	.string	"%f %f %f %f %f %f"
	.align	3
.LC19:
	.string	"Loaded Calibration Values:"
	.align	3
.LC20:
	.string	"North: %.2f\n"
	.align	3
.LC21:
	.string	"South: %.2f\n"
	.align	3
.LC22:
	.string	"East: %.2f\n"
	.align	3
.LC23:
	.string	"West: %.2f\n"
	.align	3
.LC24:
	.string	"Up: %.2f\n"
	.align	3
.LC25:
	.string	"Down: %.2f\n"
	.align	3
.LC26:
	.string	"Invalid choice. Please enter 'S' to set calibration or 'L' to load calibration."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	addi	a5,s0,-33
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	scanf
	lbu	a5,-33(s0)
	mv	a4,a5
	li	a5,83
	beq	a4,a5,.L2
	lbu	a5,-33(s0)
	mv	a4,a5
	li	a5,115
	bne	a4,a5,.L3
.L2:
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
	addi	a5,s0,-64
	mv	a1,a5
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	scanf
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	printf
	addi	a5,s0,-64
	addi	a5,a5,4
	mv	a1,a5
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	scanf
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	printf
	addi	a5,s0,-64
	addi	a5,a5,8
	mv	a1,a5
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	scanf
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	printf
	addi	a5,s0,-64
	addi	a5,a5,12
	mv	a1,a5
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	scanf
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	printf
	addi	a5,s0,-64
	addi	a5,a5,16
	mv	a1,a5
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	scanf
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	printf
	addi	a5,s0,-64
	addi	a5,a5,20
	mv	a1,a5
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	scanf
	lui	a5,%hi(.LC11)
	addi	a1,a5,%lo(.LC11)
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	fopen
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L4
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	puts
	li	a5,1
	j	.L11
.L4:
	flw	fa5,-64(s0)
	fcvt.d.s	fa4,fa5
	flw	fa5,-60(s0)
	fcvt.d.s	fa3,fa5
	flw	fa5,-56(s0)
	fcvt.d.s	fa2,fa5
	flw	fa5,-52(s0)
	fcvt.d.s	fa1,fa5
	flw	fa5,-48(s0)
	fcvt.d.s	fa0,fa5
	flw	fa5,-44(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a7,fa5
	fmv.x.d	a6,fa0
	fmv.x.d	a5,fa1
	fmv.x.d	a4,fa2
	fmv.x.d	a3,fa3
	fmv.x.d	a2,fa4
	lui	a1,%hi(.LC14)
	addi	a1,a1,%lo(.LC14)
	ld	a0,-32(s0)
	call	fprintf
	ld	a0,-32(s0)
	call	fclose
	lui	a5,%hi(.LC15)
	addi	a0,a5,%lo(.LC15)
	call	puts
	j	.L6
.L3:
	lbu	a5,-33(s0)
	mv	a4,a5
	li	a5,76
	beq	a4,a5,.L7
	lbu	a5,-33(s0)
	mv	a4,a5
	li	a5,108
	bne	a4,a5,.L8
.L7:
	lui	a5,%hi(.LC16)
	addi	a1,a5,%lo(.LC16)
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	fopen
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L9
	lui	a5,%hi(.LC17)
	addi	a0,a5,%lo(.LC17)
	call	puts
	j	.L6
.L9:
	addi	a5,s0,-64
	addi	a6,a5,20
	addi	a5,s0,-64
	addi	a0,a5,16
	addi	a5,s0,-64
	addi	a1,a5,12
	addi	a5,s0,-64
	addi	a4,a5,8
	addi	a5,s0,-64
	addi	a3,a5,4
	addi	a2,s0,-64
	mv	a7,a6
	mv	a6,a0
	mv	a5,a1
	lui	a1,%hi(.LC18)
	addi	a1,a1,%lo(.LC18)
	ld	a0,-24(s0)
	call	fscanf
	ld	a0,-24(s0)
	call	fclose
	lui	a5,%hi(.LC19)
	addi	a0,a5,%lo(.LC19)
	call	puts
	flw	fa5,-64(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC20)
	addi	a0,a5,%lo(.LC20)
	call	printf
	flw	fa5,-60(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC21)
	addi	a0,a5,%lo(.LC21)
	call	printf
	flw	fa5,-56(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC22)
	addi	a0,a5,%lo(.LC22)
	call	printf
	flw	fa5,-52(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC23)
	addi	a0,a5,%lo(.LC23)
	call	printf
	flw	fa5,-48(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC24)
	addi	a0,a5,%lo(.LC24)
	call	printf
	flw	fa5,-44(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC25)
	addi	a0,a5,%lo(.LC25)
	call	printf
	j	.L6
.L8:
	lui	a5,%hi(.LC26)
	addi	a0,a5,%lo(.LC26)
	call	puts
.L6:
	li	a5,0
.L11:
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
