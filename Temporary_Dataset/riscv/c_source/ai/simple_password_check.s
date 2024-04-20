	.file	"simple_password_check.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"secure123"
	.text
	.align	1
	.globl	check_password
	.type	check_password, @function
check_password:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	sd	a5,-24(s0)
	ld	a1,-24(s0)
	ld	a0,-40(s0)
	call	strcmp
	mv	a5,a0
	seqz	a5,a5
	andi	a5,a5,0xff
	sext.w	a5,a5
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	check_password, .-check_password
	.section	.rodata
	.align	3
.LC1:
	.string	"Enter password: "
	.align	3
.LC2:
	.string	"%49s"
	.align	3
.LC3:
	.string	"Access granted."
	.align	3
.LC4:
	.string	"Access denied."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	addi	a5,s0,-72
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	scanf
	addi	a5,s0,-72
	mv	a0,a5
	call	check_password
	mv	a5,a0
	beq	a5,zero,.L4
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
	j	.L5
.L4:
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	puts
.L5:
	li	a5,0
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
