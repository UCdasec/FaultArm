	.file	"data_encryption_xor.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	encrypt
	.type	encrypt, @function
encrypt:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	mv	a5,a1
	sb	a5,-25(s0)
	j	.L2
.L3:
	ld	a5,-24(s0)
	lbu	a5,0(a5)
	lbu	a4,-25(s0)
	xor	a5,a5,a4
	andi	a4,a5,0xff
	ld	a5,-24(s0)
	sb	a4,0(a5)
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
.L2:
	ld	a5,-24(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L3
	nop
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	encrypt, .-encrypt
	.section	.rodata
	.align	3
.LC1:
	.string	"Original message: %s\n"
	.align	3
.LC2:
	.string	"Encrypted message: %s\n"
	.align	3
.LC3:
	.string	"Decrypted message: %s\n"
	.align	3
.LC0:
	.string	"SensitiveData"
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
	lhu	a5,12(a5)
	sh	a5,-20(s0)
	li	a5,-86
	sb	a5,-17(s0)
	addi	a5,s0,-32
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	lbu	a4,-17(s0)
	addi	a5,s0,-32
	mv	a1,a4
	mv	a0,a5
	call	encrypt
	addi	a5,s0,-32
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	lbu	a4,-17(s0)
	addi	a5,s0,-32
	mv	a1,a4
	mv	a0,a5
	call	encrypt
	addi	a5,s0,-32
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
