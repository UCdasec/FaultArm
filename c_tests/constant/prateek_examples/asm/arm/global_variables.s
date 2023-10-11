	.arch armv5t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"global_variables.c"
	.text
	.global	global_var
	.data
	.align	2
	.type	global_var, %object
	.size	global_var, 4
global_var:
	.word	255
	.global	local_var
	.align	2
	.type	local_var, %object
	.size	local_var, 4
local_var:
	.word	15
	.global	local_arr
	.align	2
	.type	local_arr, %object
	.size	local_arr, 20
local_arr:
	.word	1
	.word	2
	.word	4
	.word	8
	.word	16
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	mov	r3, #0
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",%progbits
