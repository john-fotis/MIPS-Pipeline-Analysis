.data
swap: .space 2048
arr1: # 198 integers
.word 31,91,58,27,77,56,3,90,58,57,6,33,20,9,2,57,29,38,6,68,8,56,5,33,24,55,90,59,23,82,64,51,24,46,54,65,43,71,24,99,97,61,76,37,84,12,33,79,6,61,54,77,69,10,37,22,21,45,37,5,11,29,66,20,90,16,88,9,13,38,78,84,64,93,22,6,45,40,84,74,16,20,35,43,87,21,78,97,41,94,13,92,53,34,87,21,85,25,87,13,59,36,47,5,29,36,6,2,88,3,59,71,44,3,29,30,48,79,35,43,20,95,40,40,64,36,26,25,39,37,41,99,1,84,66,19,38,85,7,55,70,34,86,40,50,94,51,27,55,29,92,97,81,72,34,35,88,38,82,47,32,80,41,72,24,88,40,6,75,7,71,89,9,9,41,69,55,90,99,85,42,28,7,32,53,55,79,47,8,81,37,31,35,9,23,63,86,66
arr2: .space 264 # 66 integers for gcd
arr3: .space 264 # 66 integers for lcm

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
	beq	$t1,	$t2,	exit	# if (counter == 198) exit
	nop				# needed for delay slot
	lw	$t3,	0($t0)		# t3 = a
	lw	$t4,	4($t0)		# t4 = b
	lw	$t5,	8($t0)		# t5 = c
gcd:
	add	$a0,	$t3,	$zero	# a0 = a
	add	$a1,	$t4,	$zero	# a1 = b
	jal	gcdRec
	nop				# needed for delay slot
	add	$t6,	$v0,	$zero	# t6 = gcd(a,b)
	add	$a0,	$t5,	$zero	# a0 = c
	add	$a1,	$v0,	$zero	# a1 = gcd(a,b)
	jal	gcdRec
	nop				# needed for delay slot
	sw	$v0,	0($t8)		# save gcd(c, gcd(a,b)) in t8
lcm:
	mul	$t7,	$t3,	$t4	# t7 = a * b
	div	$t7,	$t6
	mflo	$t7			# save lcm(a,b) in t7
	add	$a0,	$t5,	$zero	# a0 = c
	add	$a1,	$t7,	$zero	# a1 = lcm(a,b)
	jal	gcdRec
	nop				# needed for delay slot
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
	nop				# needed for delay slot
exit:
	break

gcdRec:
	addi	$sp,	$sp,	-12	# push back the stack
	sw	$a0,	0($sp)		# save current a
	sw	$a1,	4($sp)		# save current b
	sw	$ra,	8($sp)		# save return address
	beq	$a0,	$zero,	base	# if (a == 0) go to base-case
	nop				# needed for delay slot
	div	$a1,	$a0		# else b = b % a,
	add	$a1,	$a0,	$zero	# a1 = a
	mfhi	$a0			# a0 = b
	jal	gcdRec			# call gcd(b % a, a))
	nop				# needed for delay slot
return:
	lw	$ra,	8($sp)		# retrieve current a
	lw	$a1,	4($sp)		# retrieve current b
	lw	$a0,	0($sp)		# retrieve return address
	addi	$sp,	$sp,	12	# pull up the stack
	jr	$ra
	nop				# needed for delay slot
base:
	add	$v0,	$a1,	$zero	# result = b
	j	return
	nop				# needed for delay slot

.org 0x10000000