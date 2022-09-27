		.data
x:		.word 5
y:		.word 10
m:		.word 15
b:		.word 2

		.text
MAIN:	la $t0, x
		lw $s0, 0($t0)		# s0 = x
		la $t0, y
		lw $s1, 0($t0)		# s1 = y
		
		# Prepare to call sum(x)
		add $a0, $zero, $s0	# Set a0 as input argument for SUM
		jal SUM
		#s0 is back to 5 coming back from sum
		add $t0, $s1, $s0  #add x + y = 15
		add $s1, $t0, $v0	#(x+y) + 23 = 38
		addi $a0, $s1, 0  #save 38 into a0 to print int
		li $v0, 1		 
		syscall	
		j END

		
SUM: 	
		addi $sp, $sp -4 #-4, allocate for a word on the stack
		sw $s0, 0($sp) #Need to save $s0 from main, value of x, into stack frame.
		
		la $t0, m
		lw $s0, 0($t0)		# s0 = m
	
		addi $sp, $sp, -4 #-4, allocate again for another word on the stack
        	sw $a0, 0($sp)      # save argument from sum
        
		add $a0, $s0, $a0	# Update a0 as new argument for SUB, which is m + n, 5 + 18 = 23
		
		addi $sp, $sp, -4 	#-4, allocate again for another word on the stack
        	sw $ra, 0($sp)      # save ra to main
		
		jal SUB
		
		lw $a0, 4($sp) #restore 5 from main
		lw $s0, 8($sp) #restore argument for sum, 5
		add $v0, $a0, $v0 #x + sub(20) = 5 + 18 = 23
		
		lw $ra, 0($sp) #restore ra to main
		jr $ra		
		
SUB:	la $t0, b
		addi $sp, $sp -4
		sw $s0, 0($sp)		# Backup s0 from SUM
		lw $s0, 0($t0)		# s0 = b
		sub $v0, $a0, $s0	#  20 - 2
		lw $s0, 0($sp)		# Restore s0 from SUM,
		addi $sp, $sp 4
		jr $ra

		
END:
