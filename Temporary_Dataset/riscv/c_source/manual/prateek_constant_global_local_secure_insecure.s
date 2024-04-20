	.file	"prateek_constant_global_local_secure_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	global_secure
	.section	.sdata,"aw"
	.align	2
	.type	global_secure, @object
	.size	global_secure, 4
global_secure:
	.word	255
	.globl	global_insecure
	.align	2
	.type	global_insecure, @object
	.size	global_insecure, 4
global_insecure:
	.word	1
	.section	.rodata
	.align	3
.LC0:
	.word	1
	.word	2
	.word	4
	.word	8
	.word	16
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	li	a5,16
	sw	a5,-20(s0)
	li	a5,-1
	sh	a5,-22(s0)
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a4,0(a5)
	sd	a4,-48(s0)
	ld	a4,8(a5)
	sd	a4,-40(s0)
	lw	a5,16(a5)
	sw	a5,-32(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	printNumber
	lui	a5,%hi(global_insecure)
	lw	a5,%lo(global_insecure)(a5)
	mv	a0,a5
	call	printNumber
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	3
.LC1:
	.string	"%d"
	.text
	.align	1
	.globl	printNumber
	.type	printNumber, @function
printNumber:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	printNumber, .-printNumber
	.ident	"GCC: () 13.2.0"
