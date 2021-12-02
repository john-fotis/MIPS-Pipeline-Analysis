.data
swap: .space 2048
arr1: # 198 integers
.word 6,2,4,24,36,12,3,30,60,41,87,90,46,81,33,47,53,68,47,62,43,20
.word 81,11,84,4,16,97,13,96,66,2,2,43,79,27,92,67,21,56,26,18,64,40
.word 30,37,32,87,94,39,16,73,55,34,72,76,73,31,91,5,96,86,10,97,81,94
.word 60,74,85,30,29,81,52,18,53,97,84,71,36,86,15,70,59,32,93,46,51,45
.word 82,64,46,52,51,13,96,78,88,45,85,7,48,99,94,32,13,50,20,37,18,19
.word 11,34,5,45,5,58,69,76,21,96,65,64,95,42,31,7,73,14,80,23,17,22
.word 29,33,48,7,66,3,18,40,28,88,77,43,38,14,85,76,73,47,60,86,14,32
.word 42,55,6,88,59,27,62,56,50,82,17,65,24,2,46,89,52,74,75,14,96,50
.word 57,31,35,72,75,26,15,58,25,32,77,55,32,75,44,38,33,21,65,16,14,43
arr2: .space 264 # 66 integers
arr3: .space 264 # 66 integers

.org 0x80020000  
.text
.globl main
.set noat
.set reorder

main:
	li	$t1,	0		# loop counter
	li	$t2,	198		# total integers
	la	$t0,	arr1		# t0 = arr1Ptr
	li	$t8,	arr2		# t8 = arr2Ptr
	li	$t9,	arr3		# t9 = arr3Ptr
while:
	beq	$t1,	$t2,	exit	# if (t1 == 198) exit
	lw	$t3,	0($t0)		# t3 = a
	lw	$t4,	4($t0)		# t4 = b
	lw	$t5,	8($t0)		# t5 = c
gcd:
	add	$a0,	$t3,	$zero	# a0 = a
	add	$a1,	$t4,	$zero	# a1 = b
	jal	gcdRec
	add	$t6,	$v0,	$zero	# t6 = gcd(a,b)
	add	$a0,	$t5,	$zero	# a0 = c
	add	$a1,	$v0,	$zero	# a1 = gcd(a,b)
	jal	gcdRec
	sw	$v0,	0($t8)		# save gcd(c, gcd(a,b)) in t8
lcm:
	mul	$t7,	$t3,	$t4	# t7 = a * b
	div	$t7,	$t6
	mflo	$t7			# save lcm(a,b) in t7
	add	$a0,	$t5,	$zero	# a0 = c
	add	$a1,	$t7,	$zero	# a1 = lcm(a,b)
	jal	gcdRec
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
exit:
	break

gcdRec:
	addi	$sp,	$sp,	-12	# push back the stack
	sw	$a0,	0($sp)		# save current a
	sw	$a1,	4($sp)		# save current b
	sw	$ra,	8($sp)		# save return address
	beq	$a0,	$zero,	base	# if (a == 0) go to base-case
	div	$a1,	$a0
	add	$a1,	$a0,	$zero	# else a1 = a
	mfhi	$a0			# and a0 = b % a
	jal	gcdRec			# call gcd(b % a, a))
return:
	lw	$ra,	8($sp)		# retrieve current a
	lw	$a1,	4($sp)		# retrieve current b
	lw	$a0,	0($sp)		# retrieve return address
	addi	$sp,	$sp,	12	# pull up the stack
	jr	$ra
base:
	add	$v0,	$a1,	$zero	# result = b
	j	return

.org 0x10000000