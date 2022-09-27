                .data

# TPS 2 #3 (input prompt to be displayed)

input: .asciiz "Please enter an integer: "

        .text
main: 		
		addi $sp, $sp, -4	# Moving stack pointer to make room for storing local variables (push the stack frame)
		# TPS 2 #3 (display input prompt)
		
		la $a0, input
		li $v0, 4	#print string input
		syscall
		
		
		# TPS 2 #4 (read user input)
		
		li $v0, 5
		syscall		#take in user input, move to $v0
		move $a0, $v0

		
		jal recursion	# Call recursion(x)
		
		# TPS 2 #6 (print out returned value)
		
		add $a0, $0, $v0	#load $v0 into $a0
      		li $v0, 1		#load 1, print integer into $v0, prints $a0 returned value
       		syscall
		
		j end		# Jump to end of program


# Implementing recursion
recursion:	addi $sp, $sp, -12	# Push stack frame for local storage

		# TPS 2 #7 
		
		sw $ra, 0($sp)	#save return adress back to main
				
		
		addi $t0, $a0, 1	#if m = -1, $t0 will  be 0, if not 0 it wasnt -1.
		bne $t0, $zero, not_minus_one #if m/$a0 is -1
		
		# TPS 2 #8 (update returned value)
		
		li $v0, 1	#return value 1
		
		j end_recur
			
not_minus_one:	bne $a0, $zero, not_zero	#if m/$a0 is 0 

		# TPS 2 #9 (update returned value)
		
		li $v0, 3 #return value 3
		
		j end_recur		

not_zero:	sw $a0, 4($sp) 	
		# TPS 2 #11 (Prepare new input argument, i.e. m - 2)
		
		addi  $a0, $a0, -2 #subtract 2 from m
		
		
		jal recursion	# Call recursion(m - 2)
		
		# TPS 2 #12 
		
		sw $v0, 8($sp) #Restore to original value from this iteration

		
		
		# TPS 2 #13 (Prepare new input argument, i.e. m - 1)
		
		lw $a0, 4($sp)	#load original m, then subtract -1
		addi $a0, $a0, -1
		
		
		jal recursion	# Call recursion(m - 1)
		
		# TPS 2 #14 (update returned value)
		
		lw $t0, 8($sp)
        	add $v0, $t0, $v0
		
		j end_recur
		

# End of recursion function	
end_recur:	# TPS 2 #15 

		
		lw $ra, 0($sp)		#load return address to main
		addi $sp, $sp, 12	# Pop stack frame 
		jr $ra

# Terminating the program
end:	addi $sp, $sp 4	# Moving stack pointer back (pop the stack frame)
		li $v0, 10 
		syscall
