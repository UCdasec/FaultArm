	.file	"harris_constant_simple_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.sdata,"aw"
	.align	1
	.type	num1, @object
	.size	num1, 2
num1:
	.half	23100
	.align	1
	.type	num2, @object
	.size	num2, 2
num2:
	.half	-23101
	.section	.rodata
	.align	3
.LC0:
	.string	"Constant example"
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
	sw	zero,-20(s0)
	li	a5,1
	sw	a5,-24(s0)
	li	a5,4
	sw	a5,-28(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
