	.file	"guillermo_branch_complex_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Condition is true."
	.align	3
.LC1:
	.string	"Condition is false."
	.align	3
.LC2:
	.string	"Another condition is true."
	.align	3
.LC3:
	.string	"Another condition is false."
	.text
	.align	1
	.globl	basic_comp
	.type	basic_comp, @function
basic_comp:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1
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
	sw	zero,-24(s0)
	lw	a5,-24(s0)
	sext.w	a5,a5
	beq	a5,zero,.L4
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	j	.L5
.L4:
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
.L5:
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	basic_comp, .-basic_comp
	.section	.rodata
	.align	3
.LC4:
	.string	"Both condition and x < y are true."
	.align	3
.LC5:
	.string	"Either condition or x < y is false."
	.align	3
.LC6:
	.string	"Either anotherCondition or z > y is true."
	.align	3
.LC7:
	.string	"Both anotherCondition and z > y are false."
	.align	3
.LC8:
	.string	"x is equal to y."
	.align	3
.LC9:
	.string	"x is not equal to y."
	.text
	.align	1
	.globl	advanced_comp
	.type	advanced_comp, @function
advanced_comp:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	li	a5,1
	sw	a5,-20(s0)
	li	a5,5
	sw	a5,-24(s0)
	li	a5,10
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	sext.w	a5,a5
	beq	a5,zero,.L8
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L8
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	puts
	j	.L9
.L8:
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	puts
.L9:
	sw	zero,-32(s0)
	li	a5,15
	sw	a5,-36(s0)
	lw	a5,-32(s0)
	sext.w	a5,a5
	bne	a5,zero,.L10
	lw	a5,-36(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	ble	a4,a5,.L11
.L10:
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	puts
	j	.L12
.L11:
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	puts
.L12:
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	sub	a5,a4,a5
	seqz	a5,a5
	andi	a5,a5,0xff
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	sext.w	a5,a5
	beq	a5,zero,.L13
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	puts
	j	.L14
.L13:
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	puts
.L14:
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	advanced_comp, .-advanced_comp
	.ident	"GCC: () 13.2.0"
