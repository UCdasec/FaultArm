	.file	"prateek_constant_global_variables.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	global_var
	.section	.sdata,"aw"
	.align	2
	.type	global_var, @object
	.size	global_var, 4
global_var:
	.word	255
	.globl	local_var
	.align	2
	.type	local_var, @object
	.size	local_var, 4
local_var:
	.word	15
	.globl	local_arr
	.data
	.align	3
	.type	local_arr, @object
	.size	local_arr, 20
local_arr:
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
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,0
	mv	a0,a5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
