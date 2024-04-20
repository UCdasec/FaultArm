	.file	"prateek_loop_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Fault Detected\n"
	.text
	.align	1
	.globl	faultDetect
	.type	faultDetect, @function
faultDetect:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(_impure_ptr)
	ld	a5,%lo(_impure_ptr)(a5)
	ld	a5,24(a5)
	mv	a3,a5
	li	a2,15
	li	a1,1
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	fwrite
	li	a0,1
	call	exit
	.size	faultDetect, .-faultDetect
	.section	.rodata
	.align	3
.LC1:
	.string	"Enter the number of iterations: "
	.align	3
.LC2:
	.string	"%d"
	.align	3
.LC3:
	.string	"Task %d completed\n"
	.align	3
.LC4:
	.string	"End of program"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	addi	a5,s0,-24
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	scanf
	sw	zero,-20(s0)
	j	.L3
.L4:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L3:
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L4
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	puts
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
