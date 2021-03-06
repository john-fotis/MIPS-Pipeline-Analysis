# ========================================== Description ========================================== #
# This program calculates the gcd and lcm of 3 random numbers in a 198 positive, < 99 integer, array.
# The calculation is made on consequtive pairs of the array and is using a recursive implementation:
# gcd(a, b, c) = gcd(gcd(a, b), c)
# lcm(a, b ,c) = lcm(a, b) * c) / gcd(lcm(a,b), c)

.data
swap: .space 2048			# to avoid reading program memory
arr1:					# 198-integer array for input data
.word ############ PASTE DATASET HERE ####################################
arr2: .space 264			# 66-integer array for gcd results
arr3: .space 264			# 66-integer array for lcm results

.org 0x80020000
.text
.globl main
.set noreorder

main:
	li	$t1,	0		# loop counter
	li	$t2,	198		# total integers
	la	$t0,	arr1		# t0 = arr1Ptr
	li	$t8,	arr2		# t8 = arr2Ptr
	li	$t9,	arr3		# t9 = arr3Ptr
while:
	beq	$t1,	$t2,	exit	# if (t1 == 198) exit
	//nop				# for delay slot - Branch resolution @ ID or EX
	//nop				# for delay slot - Branch resolution @ EX ONLY
	lw	$t3,	0($t0)		# t3 = a
	lw	$t4,	4($t0)		# t4 = b
	lw	$t5,	8($t0)		# t5 = c
gcd:
	add	$a0,	$t3,	$zero	# a0 = a
	add	$a1,	$t4,	$zero	# a1 = b
	jal	gcdRec
	//nop				# for delay slot - Branch resolution @ ID or EX
	add	$t6,	$v0,	$zero	# t6 = gcd(a,b)
	add	$a0,	$t5,	$zero	# a0 = c
	add	$a1,	$v0,	$zero	# a1 = gcd(a,b)
	jal	gcdRec
	//nop				# for delay slot - Branch resolution @ ID or EX
	sw	$v0,	0($t8)		# save gcd(c, gcd(a,b)) in t8
lcm:
	mul	$t7,	$t3,	$t4	# t7 = a * b
	div	$t7,	$t6		# t7 = (a * b) / gcd(a, b)
	mflo	$t7			# save lcm(a,b) in t7
	add	$a0,	$t5,	$zero	# a0 = c
	add	$a1,	$t7,	$zero	# a1 = lcm(a,b)
	jal	gcdRec
	//nop				# for delay slot - Branch resolution @ ID or EX
	mul	$t7,	$t5,	$t7	# t7 = c * lcm(a,b)
	div	$t7,	$v0
	mflo	$t7			# t7 = (c * lcm(a,b)) / gcd(c, lcm(a,b))
	sw	$t7,	0($t9)		# save lcm (c, lcm(a,b)) in t9
nextLoop:
	addi	$t0,	$t0,	12	# arr1Ptr += 12 bytes
	addi	$t1,	$t1,	3	# loop counter += 3 integers
	addi	$t8,	$t8,	4	# arr2Ptr += 4 bytes
	addi	$t9,	$t9,	4	# arr3Ptr += 4 bytes
	j	while
	//nop				# for delay slot - Branch resolution @ ID or EX
exit:
	break

gcdRec:
	addi	$sp,	$sp,	-12	# push back the stack
	sw	$a0,	0($sp)		# save current a
	sw	$a1,	4($sp)		# save current b
	sw	$ra,	8($sp)		# save return address
	beq	$a0,	$zero,	base	# if (a == 0) go to base-case
	//nop				# for delay slot - Branch resolution @ ID or EX
	//nop				# for delay slot - Branch resolution @ EX ONLY
	div	$a1,	$a0		# else b = b % a,
	add	$a1,	$a0,	$zero	# a1 = a
	mfhi	$a0			# a0 = b
	jal	gcdRec			# call gcd(b % a, a))
	//nop				# for delay slot - Branch resolution @ ID or EX
return:
	lw	$ra,	8($sp)		# retrieve return address
	lw	$a1,	4($sp)		# retrieve current b
	lw	$a0,	0($sp)		# retrieve current a
	addi	$sp,	$sp,	12	# pull up the stack
	jr	$ra
	//nop				# for delay slot - Branch resolution @ ID or EX
base:
	add	$v0,	$a1,	$zero	# result = b
	j	return
	//nop				# for delay slot - Branch resolution @ ID or EX

.org 0x10000000
