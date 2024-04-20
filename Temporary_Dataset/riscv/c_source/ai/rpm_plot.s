	.file	"rpm_plot.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"a"
	.align	3
.LC1:
	.string	"plot_data.dat"
	.align	3
.LC2:
	.string	"Error opening the plot data file."
	.align	3
.LC3:
	.string	"%.2lf %.2lf\n"
	.text
	.align	1
	.globl	updatePlotFile
	.type	updatePlotFile, @function
updatePlotFile:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	fsd	fa0,-40(s0)
	fsd	fa1,-48(s0)
	lui	a5,%hi(.LC0)
	addi	a1,a5,%lo(.LC0)
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	fopen
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L2
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	li	a0,1
	call	exit
.L2:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	lui	a5,%hi(.LC3)
	addi	a1,a5,%lo(.LC3)
	ld	a0,-24(s0)
	call	fprintf
	ld	a0,-24(s0)
	call	fclose
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	updatePlotFile, .-updatePlotFile
	.section	.rodata
	.align	3
.LC4:
	.string	"w"
	.align	3
.LC5:
	.string	"Continuous X-Y Plot Generator"
	.align	3
.LC6:
	.string	"Enter a value (or 'q' to quit): "
	.align	3
.LC7:
	.string	"%lf"
	.align	3
.LC8:
	.string	"%c"
	.align	3
.LC9:
	.string	"Invalid input. Please enter a numeric value."
	.align	3
.LC10:
	.string	"Time: %.2lf seconds, Value: %.2lf\n"
	.align	3
.LC11:
	.string	"Exiting the program."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	lui	a5,%hi(.LC4)
	addi	a1,a5,%lo(.LC4)
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	fopen
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L4
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	li	a5,1
	j	.L11
.L4:
	ld	a0,-32(s0)
	call	fclose
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	puts
.L10:
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	printf
	addi	a5,s0,-56
	mv	a1,a5
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	scanf
	mv	a5,a0
	mv	a4,a5
	li	a5,1
	beq	a4,a5,.L6
	addi	a5,s0,-57
	mv	a1,a5
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	scanf
	lbu	a5,-57(s0)
	mv	a4,a5
	li	a5,113
	beq	a4,a5,.L7
	lbu	a5,-57(s0)
	mv	a4,a5
	li	a5,81
	beq	a4,a5,.L7
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	puts
	j	.L8
.L6:
	li	a0,0
	call	time
	sd	a0,-40(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L9
	ld	a5,-40(s0)
	sd	a5,-24(s0)
.L9:
	ld	a1,-24(s0)
	ld	a0,-40(s0)
	call	difftime
	fsd	fa0,-48(s0)
	fld	fa5,-56(s0)
	fmv.d	fa1,fa5
	fld	fa0,-48(s0)
	call	updatePlotFile
	fld	fa5,-56(s0)
	fmv.x.d	a2,fa5
	ld	a1,-48(s0)
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	printf
.L8:
	j	.L10
.L7:
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	puts
	li	a5,0
.L11:
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
