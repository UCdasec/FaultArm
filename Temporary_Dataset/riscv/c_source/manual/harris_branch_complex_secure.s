	.file	"harris_branch_complex_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"%x, %x, %x, %x, %x"
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
	sext.w	a3,a5
	lw	a5,-20(s0)
	andi	a5,a5,240
	sext.w	a4,a5
	lw	a5,-20(s0)
	andi	a5,a5,15
	sext.w	a5,a5
	lw	a1,-20(s0)
	li	a2,4096
	addi	a2,a2,-256
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	printf
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
