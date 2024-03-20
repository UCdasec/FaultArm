	.file	"data_integrity_checksum.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	calculate_checksum
	.type	calculate_checksum, @function
calculate_checksum:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sb	zero,-17(s0)
	j	.L2
.L3:
	ld	a5,-40(s0)
	lbu	a5,0(a5)
	lbu	a4,-17(s0)
	addw	a5,a4,a5
	sb	a5,-17(s0)
	ld	a5,-40(s0)
	addi	a5,a5,1
	sd	a5,-40(s0)
.L2:
	ld	a5,-40(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L3
	lbu	a5,-17(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	calculate_checksum, .-calculate_checksum
	.section	.rodata
	.align	3
.LC1:
	.string	"Data: %s\n"
	.align	3
.LC2:
	.string	"Checksum: %u\n"
	.align	3
.LC0:
	.string	"IntegrityCheck"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a4,0(a5)
	sd	a4,-32(s0)
	lw	a4,8(a5)
	sw	a4,-24(s0)
	lhu	a4,12(a5)
	sh	a4,-20(s0)
	lbu	a5,14(a5)
	sb	a5,-18(s0)
	addi	a5,s0,-32
	mv	a0,a5
	call	calculate_checksum
	mv	a5,a0
	sb	a5,-17(s0)
	addi	a5,s0,-32
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	lbu	a5,-17(s0)
	sext.w	a5,a5
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
