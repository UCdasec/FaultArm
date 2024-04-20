	.file	"secure_data_wipe.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	secure_wipe
	.type	secure_wipe, @function
secure_wipe:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	zero,-24(s0)
	j	.L2
.L3:
	ld	a4,-40(s0)
	ld	a5,-24(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
.L2:
	ld	a4,-24(s0)
	ld	a5,-48(s0)
	bltu	a4,a5,.L3
	nop
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	secure_wipe, .-secure_wipe
	.section	.rodata
	.align	3
.LC1:
	.string	"Before wipe: %s\n"
	.align	3
.LC2:
	.string	"After wipe: %s\n"
	.align	3
.LC0:
	.string	"VerySecret"
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
	lhu	a4,8(a5)
	sh	a4,-24(s0)
	lbu	a5,10(a5)
	sb	a5,-22(s0)
	addi	a5,s0,-32
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	addi	a5,s0,-32
	mv	a0,a5
	call	strlen
	mv	a4,a0
	addi	a5,s0,-32
	mv	a1,a4
	mv	a0,a5
	call	secure_wipe
	addi	a5,s0,-32
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
