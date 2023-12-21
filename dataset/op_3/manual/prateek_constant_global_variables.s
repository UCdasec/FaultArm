	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"prateek_constant_global_variables.c"
	.text
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r0, #0
	bx	lr
	.size	main, .-main
	.global	local_arr
	.global	local_var
	.global	global_var
	.data
	.align	2
	.type	local_arr, %object
	.size	local_arr, 20
local_arr:
	.word	1
	.word	2
	.word	4
	.word	8
	.word	16
	.type	local_var, %object
	.size	local_var, 4
local_var:
	.word	15
	.type	global_var, %object
	.size	global_var, 4
global_var:
	.word	255
	.ident	"GCC: (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
