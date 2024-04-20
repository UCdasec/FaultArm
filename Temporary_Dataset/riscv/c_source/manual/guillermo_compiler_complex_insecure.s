	.file	"guillermo_compiler_complex_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	foo
	.type	foo, @function
foo:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a5,0(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,0(a5)
	ld	a5,-24(s0)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L2
	li	a5,0
	j	.L3
.L2:
	li	a5,1
.L3:
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	foo, .-foo
	.section	.rodata
	.align	3
.LC0:
	.string	"Access granted."
	.align	3
.LC1:
	.string	"Access denied."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	call	getchar
	mv	a5,a0
	sw	a5,-20(s0)
	addi	a5,s0,-20
	mv	a0,a5
	call	foo
	mv	a5,a0
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	li	a5,0
	j	.L8
.L5:
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
	li	a5,1
.L8:
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
