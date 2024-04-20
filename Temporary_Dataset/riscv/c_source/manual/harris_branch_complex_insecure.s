	.file	"harris_branch_complex_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
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
	mv	a0,a5
	call	branch_check
	nop
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	basic_comp, .-basic_comp
	.section	.rodata
	.align	3
.LC0:
	.string	"Executing critical code... "
	.align	3
.LC1:
	.string	"Exiting out... "
	.text
	.align	1
	.globl	branch_check
	.type	branch_check, @function
branch_check:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L3
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	j	.L4
.L3:
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
.L4:
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	branch_check, .-branch_check
	.section	.rodata
	.align	3
.LC2:
	.string	"Both x < y and condition are true. "
	.align	3
.LC3:
	.string	"Both x < y and condition are false. "
	.align	3
.LC4:
	.string	"Either anothercondition or z > y is true and condition is true. "
	.align	3
.LC5:
	.string	"Either anothercondition or z > y is true but condition is false. "
	.align	3
.LC6:
	.string	"Both anotherCondition and z > y are false."
	.text
	.align	1
	.globl	adv_comp
	.type	adv_comp, @function
adv_comp:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	li	a5,1
	sw	a5,-20(s0)
	li	a5,8
	sw	a5,-24(s0)
	li	a5,10
	sw	a5,-28(s0)
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L7
	lw	a5,-20(s0)
	mv	a0,a5
	call	branch_check
	mv	a5,a0
	beq	a5,zero,.L7
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	j	.L8
.L7:
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
.L8:
	sw	zero,-32(s0)
	li	a5,12
	sw	a5,-36(s0)
	lw	a5,-32(s0)
	mv	a0,a5
	call	branch_check
	mv	a5,a0
	bne	a5,zero,.L9
	lw	a5,-36(s0)
	mv	a4,a5
	lw	a5,-28(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	ble	a4,a5,.L10
.L9:
	lw	a5,-20(s0)
	mv	a0,a5
	call	branch_check
	mv	a5,a0
	beq	a5,zero,.L11
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	puts
	j	.L13
.L11:
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	puts
	j	.L13
.L10:
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	puts
.L13:
	nop
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	adv_comp, .-adv_comp
	.ident	"GCC: () 13.2.0"
