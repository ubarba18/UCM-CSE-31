        .data
x:      .word 2
y:      .word 3
z:      .word 4

m:      .word 0
n:      .word 0
o:      .word 0

p:      .word 0
q:      .word 0


        .text
main:
	la $t0, x #x= $s0
	lw $s0, 0($t0)
	
	la $t0, y #y = $s1
	lw $s1, 0($t0)
	
	la $t0, z #z = $s2
	lw $s2, 0($t0)
	

	#foo argument mapping
	add $a0, $0, $s0 	#Set a0 argument x for foo	| m = 2
	add $a1, $0, $s1 	#Set a1 argument y for foo	| n = 3
	add $a2, $0, $s2 	#Set a2 argument z for foo	| o = 4
	jal foo
	
	add $t0, $s1, $s0 	#t0 = x+y
	add $t0, $t0, $s2	#t0 = t0 + z = 9
	add $s2, $t0, $v1	#t0 = t0 + v1(p+q) = 9 + 144
	addi $a0, $s2, 0 
	
	li $v0, 1		 
	syscall	#print int
	j finish
	
	
foo:
	addi $sp, $sp, -4	#-4, allocate for a word on the stack
	sw $ra, 8($sp)		# save ra to main
	
	#bar argument mapping	
	add $a0, $s0, $s1	# m + n, argument for bar | a = 5 
	add $a1, $s1, $s2	# n + o, argument for bar | b = 7
	add $a2, $s2, $s0	# o + m, argument for bar | c = 6
	jal bar
	
	add $t0, $0, $v0	#save p = 128
	
	sub $a0, $s0, $s2	# m - o, argument for bar | a = -2
	sub $a1, $s1, $s0	# n - m, argument for bar | b = 1
	mul $a2, $s1, 2 	# 2 * n, argument for bar | c = 6
	
	jal bar
	
	add $t1, $0, $v0	#save q = 16
	add $v1, $t0, $t1	#p + q = 144
	
	lw $ra, 8($sp)		#restore RA to main
 	addi $sp, $sp, 4
 	jr $ra		#jump to register $ra, to the address in main
	
	


bar:
	
	sub $v0, $a2, $a0	# c - a first, then bit shift, p = 6-5=1 | q = 6 - (-2) = 8
	sllv  $v0, $v0, $a1 	#bit shift c-a by b, p = 1 << 7 = 128 | q = 8 << 1 = 16
	jr $ra

finish:
	li $v0, 10
	syscall
	
