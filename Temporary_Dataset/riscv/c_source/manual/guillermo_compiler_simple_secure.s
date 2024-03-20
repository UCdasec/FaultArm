	.file	"guillermo_compiler_simple_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	foo
	.type	foo, @function
foo:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	li	a5,16384
	addi	a5,a5,-861
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,2
	sext.w	a4,a5
	ld	a5,-40(s0)
	sw	a4,0(a5)
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	foo, .-foo
	.section	.rodata
	.align	3
.LC0:
	.string	"Executing critical code..."
	.align	3
.LC1:
	.string	"Exiting out..."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	addi	a5,s0,-20
	mv	a0,a5
	call	foo
	lw	a5,-20(s0)
	mv	a4,a5
	li	a5,16384
	addi	a5,a5,-859
	bne	a4,a5,.L3
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	li	a5,0
	j	.L6
.L3:
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
	li	a5,1
.L6:
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
