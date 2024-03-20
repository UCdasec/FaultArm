	.file	"guillermo_constant_simple_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.sdata,"aw"
	.align	1
	.type	STATE_INIT, @object
	.size	STATE_INIT, 2
STATE_INIT:
	.half	23100
	.align	1
	.type	STATE_PERSO, @object
	.size	STATE_PERSO, 2
STATE_PERSO:
	.half	-23101
	.align	1
	.type	STATE_ISSUED, @object
	.size	STATE_ISSUED, 2
STATE_ISSUED:
	.half	15450
	.align	1
	.type	STATE_LOCKED, @object
	.size	STATE_LOCKED, 2
STATE_LOCKED:
	.half	-15451
	.align	1
	.type	closeHamming1, @object
	.size	closeHamming1, 2
closeHamming1:
	.half	13107
	.align	1
	.type	closeHamming2, @object
	.size	closeHamming2, 2
closeHamming2:
	.half	13106
	.section	.rodata
	.align	3
.LC0:
	.string	"Constant coding example."
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
	li	a5,1012
	sw	a5,-20(s0)
	li	a5,1000
	sw	a5,-24(s0)
	li	a5,4096
	addi	a5,a5,-1096
	sw	a5,-28(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
