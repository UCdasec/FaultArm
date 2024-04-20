	.file	"guillermo_practical_pin_check.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Failed to import data"
	.align	3
.LC1:
	.string	"%5s"
	.align	3
.LC2:
	.string	"Bad input..."
	.align	3
.LC3:
	.string	"Incorrect PIN"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	sd	a1,-48(s0)
	sw	a5,-36(s0)
	addi	a5,s0,-32
	mv	a0,a5
	call	import_data
	mv	a5,a0
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L2
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	li	a5,1
	j	.L6
.L2:
	addi	a5,s0,-24
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	scanf
	mv	a5,a0
	mv	a4,a5
	li	a5,4
	bgt	a4,a5,.L4
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	li	a5,1
	j	.L6
.L4:
	addi	a4,s0,-32
	addi	a5,s0,-24
	mv	a1,a4
	mv	a0,a5
	call	verify_pin
	mv	a5,a0
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
	li	a5,1
	j	.L6
.L5:
	li	a5,0
.L6:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	3
.LC4:
	.string	"r"
	.align	3
.LC5:
	.string	"/path/to/saved/pins"
	.text
	.align	1
	.globl	import_data
	.type	import_data, @function
import_data:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	lui	a5,%hi(.LC4)
	addi	a1,a5,%lo(.LC4)
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	fopen
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L8
	li	a5,1
	j	.L9
.L8:
	ld	a2,-40(s0)
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-24(s0)
	call	fscanf
	mv	a5,a0
	mv	a4,a5
	li	a5,3
	bgt	a4,a5,.L10
	li	a5,1
	j	.L9
.L10:
	li	a5,0
.L9:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	import_data, .-import_data
	.align	1
	.globl	verify_pin
	.type	verify_pin, @function
verify_pin:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	j	.L12
.L16:
	ld	a5,-24(s0)
	lbu	a4,0(a5)
	ld	a5,-32(s0)
	lbu	a5,0(a5)
	beq	a4,a5,.L13
	li	a5,0
	j	.L14
.L13:
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
	ld	a5,-32(s0)
	addi	a5,a5,1
	sd	a5,-32(s0)
.L12:
	ld	a5,-24(s0)
	lbu	a5,0(a5)
	beq	a5,zero,.L15
	ld	a5,-32(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L16
.L15:
	ld	a5,-24(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L17
	ld	a5,-32(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L17
	li	a5,1
	j	.L14
.L17:
	li	a5,0
.L14:
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	verify_pin, .-verify_pin
	.ident	"GCC: () 13.2.0"
