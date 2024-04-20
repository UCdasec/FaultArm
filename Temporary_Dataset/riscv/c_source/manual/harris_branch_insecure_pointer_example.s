	.file	"harris_branch_insecure_pointer_example.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Execute critcal code"
	.align	3
.LC1:
	.string	"Do not excute critical code"
	.align	3
.LC2:
	.string	"Both x < z and *p are true"
	.align	3
.LC3:
	.string	"Neither x < z and *p are true"
	.align	3
.LC4:
	.string	"Either x < z or *p > x are true"
	.align	3
.LC5:
	.string	"Neither x < z or *p > x are true"
	.align	3
.LC6:
	.string	"x * z is greater than *p"
	.align	3
.LC7:
	.string	"x * z is less than *p"
	.align	3
.LC9:
	.string	"y is less than x"
	.align	3
.LC10:
	.string	"y is greater than x"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	li	a5,1
	sw	a5,-40(s0)
	addi	a5,s0,-40
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	lw	a4,0(a5)
	lw	a5,-40(s0)
	ble	a4,a5,.L2
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	j	.L3
.L2:
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
.L3:
	ld	a5,-24(s0)
	lw	a5,0(a5)
	sw	a5,-28(s0)
	lw	a4,-40(s0)
	lw	a5,-28(s0)
	sext.w	a5,a5
	ble	a5,a4,.L4
	ld	a5,-24(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L4
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	j	.L5
.L4:
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
.L5:
	lw	a4,-40(s0)
	lw	a5,-28(s0)
	sext.w	a5,a5
	bgt	a5,a4,.L6
	ld	a5,-24(s0)
	lw	a4,0(a5)
	lw	a5,-40(s0)
	ble	a4,a5,.L7
.L6:
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
	j	.L8
.L7:
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	printf
.L8:
	lw	a5,-40(s0)
	lw	a4,-28(s0)
	mulw	a5,a4,a5
	sext.w	a4,a5
	ld	a5,-24(s0)
	lw	a5,0(a5)
	sgt	a5,a4,a5
	andi	a5,a5,0xff
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	sext.w	a5,a5
	beq	a5,zero,.L9
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	printf
	j	.L10
.L9:
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	printf
.L10:
	ld	a5,-24(s0)
	lw	a5,0(a5)
	fcvt.d.w	fa5,a5
	lui	a5,%hi(.LC8)
	fld	fa4,%lo(.LC8)(a5)
	fmv.d	fa1,fa4
	fmv.d	fa0,fa5
	call	pow
	fmv.d	fa5,fa0
	fcvt.w.d a5,fa5,rtz
	sw	a5,-36(s0)
	lw	a4,-40(s0)
	lw	a5,-36(s0)
	sext.w	a5,a5
	bge	a5,a4,.L11
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	printf
	j	.L12
.L11:
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	printf
.L12:
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	3
.LC8:
	.word	0
	.word	1073741824
	.ident	"GCC: () 13.2.0"
