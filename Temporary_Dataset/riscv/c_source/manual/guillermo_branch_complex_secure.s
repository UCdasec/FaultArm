	.file	"guillermo_branch_complex_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Flag 1 is set."
	.align	3
.LC1:
	.string	"Flag 1 is not set."
	.align	3
.LC2:
	.string	"Flag 2 is set."
	.align	3
.LC3:
	.string	"Flag 2 is not set."
	.align	3
.LC4:
	.string	"Flag 3 is set."
	.align	3
.LC5:
	.string	"Flag 3 is not set."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,45056
	addi	a5,a5,-1075
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a4,a5
	li	a5,4096
	addi	a5,a5,-256
	and	a5,a4,a5
	sext.w	a5,a5
	mv	a4,a5
	li	a5,256
	bne	a4,a5,.L2
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	j	.L3
.L2:
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
.L3:
	lw	a5,-20(s0)
	andi	a5,a5,240
	sext.w	a5,a5
	mv	a4,a5
	li	a5,160
	bne	a4,a5,.L4
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	j	.L5
.L4:
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
.L5:
	lw	a5,-20(s0)
	andi	a5,a5,15
	sext.w	a5,a5
	mv	a4,a5
	li	a5,13
	bne	a4,a5,.L6
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	puts
	j	.L7
.L6:
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	puts
.L7:
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
