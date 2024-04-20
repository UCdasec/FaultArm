	.file	"caesarCipher.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	caesarCipher
	.type	caesarCipher, @function
caesarCipher:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	sw	zero,-20(s0)
	j	.L2
.L4:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,64
	bleu	a4,a5,.L3
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,90
	bgtu	a4,a5,.L3
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sext.w	a5,a5
	addiw	a5,a5,-65
	sext.w	a5,a5
	lw	a4,-44(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a4,a5
	li	a5,26
	remw	a5,a4,a5
	sext.w	a5,a5
	andi	a4,a5,0xff
	lw	a5,-20(s0)
	ld	a3,-40(s0)
	add	a5,a3,a5
	addiw	a4,a4,65
	andi	a4,a4,0xff
	sb	a4,0(a5)
.L3:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L4
	nop
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	caesarCipher, .-caesarCipher
	.section	.rodata
	.align	3
.LC0:
	.string	"r"
	.align	3
.LC1:
	.string	"text.txt"
	.align	3
.LC2:
	.string	"Unable to open the file."
	.align	3
.LC3:
	.string	"Unable to read from the file."
	.align	3
.LC4:
	.string	"Enter the Caesar cipher shift value: "
	.align	3
.LC5:
	.string	"%d"
	.align	3
.LC6:
	.string	"Caesar Cipher: %s\n"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-1840
	sd	ra,1832(sp)
	sd	s0,1824(sp)
	addi	s0,sp,1840
	li	t0,-8192
	add	sp,sp,t0
	lui	a5,%hi(.LC0)
	addi	a1,a5,%lo(.LC0)
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	fopen
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L6
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	li	a5,1
	j	.L9
.L6:
	li	a5,-8192
	addi	a5,a5,-1824
	addi	a5,a5,-16
	add	a4,a5,s0
	ld	a2,-24(s0)
	li	a5,8192
	addi	a1,a5,1808
	mv	a0,a4
	call	fgets
	mv	a5,a0
	bne	a5,zero,.L8
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
	ld	a0,-24(s0)
	call	fclose
	li	a5,1
	j	.L9
.L8:
	ld	a0,-24(s0)
	call	fclose
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
	addi	a5,s0,-28
	mv	a1,a5
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	scanf
	lw	a4,-28(s0)
	li	a5,-8192
	addi	a5,a5,-1824
	addi	a5,a5,-16
	add	a5,a5,s0
	mv	a1,a4
	mv	a0,a5
	call	caesarCipher
	li	a5,-8192
	addi	a5,a5,-1824
	addi	a5,a5,-16
	add	a5,a5,s0
	mv	a1,a5
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	printf
	li	a5,0
.L9:
	mv	a0,a5
	li	t0,8192
	add	sp,sp,t0
	ld	ra,1832(sp)
	ld	s0,1824(sp)
	addi	sp,sp,1840
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
