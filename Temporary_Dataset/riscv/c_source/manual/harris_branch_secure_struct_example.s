	.file	"harris_branch_secure_struct_example.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Execute critical code"
	.align	3
.LC1:
	.string	"Do not execute critical code"
	.align	3
.LC2:
	.string	"both conditions are true"
	.align	3
.LC3:
	.string	"neither conditions are true"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,16384
	addi	a5,a5,-183
	sw	a5,-24(s0)
	li	a5,16384
	addi	a5,a5,-173
	sw	a5,-20(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	bge	a4,a5,.L2
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	j	.L3
.L2:
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
.L3:
	li	a5,16384
	addi	a5,a5,-136
	sw	a5,-32(s0)
	li	a5,16384
	addi	a5,a5,-177
	sw	a5,-28(s0)
	lw	a4,-24(s0)
	lw	a5,-28(s0)
	bge	a4,a5,.L4
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	ble	a4,a5,.L4
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	j	.L5
.L4:
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
.L5:
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
