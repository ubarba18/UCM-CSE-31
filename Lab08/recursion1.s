                .data

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
		
		add $a0, $0, $v0	#load $v0 into $a0
      		li $v0, 1		#load 1, print integer into $v0, prints $a0 returned value
       		syscall
		
		j end		# Jump to end of program
		
recursion:
		addi $sp, $sp, -12	# Push stack frame for local storage

		# TPS 2 #7 
		
		sw $ra, 0($sp)	#save return adress back to main
				
		
		bne $a0, 10, not_ten #if m/$a0 is 10 continue, iif not goto not_ten
		
		# TPS 2 #8 (update returned value)
		
		li $v0, 2	#return value 2
		
		j end_recur

not_ten:
		addi $t0, $zero, 10
		bne $a0, 11, not_eleven	#if m/$a0 is 11, continue. if not go to not_eleven

		# TPS 2 #9 (update returned value)
		
		li $v0, 1 #return value 1
		
		j end_recur

not_eleven:
		sw $a0, 4($sp)	#store m
		addi $a0, $a0, 2
		add $v0, $a0, $0
		
		jal recursion	# Call recursion(m + 2)
		
       		# TPS 2 #12 
		
		sw $v0, 8($sp) #Restore to original value from this iteration
		
		# TPS 2 #13 (Prepare new input argument, i.e. m + 1)
		
		lw $a0, 4($sp)	#load original m, then ADD 1
		addi $a0, $a0, 1
		
		jal recursion	# Call recursion(m + 1)
		
		lw $t0, 4($sp)	#load this iterations m
		lw $t1, 8($sp)	#load this iterations $v0
		
        	add $v0, $t0, $v0	#add m from this iteration
        	add $v0, $t1, $v0	#add return values	recursion(m+2) + recursion(m+1)
		
		j end_recur



end_recur:
		lw $ra, 0($sp)
		addi $sp, $sp, 12	# Pop stack frame 
		jr $ra

end:
		addi $sp, $sp 4	# Moving stack pointer back (pop the stack frame)
		li $v0, 10 
		syscall
