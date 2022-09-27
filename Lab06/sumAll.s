.data

input: .asciiz "Please enter a number:  "
sumOfEven: .asciiz "\nSum of even numbers: "
sumOfOdd: .asciiz "\nSum of odd numbers is: "

.text
main: 
	li $v0, 4	#load 4 into v0 for an upcoming string print
	la $a0, input   #load address of label input into $a0
	syscall		#print "Enter a number: "

	li $v0, 5	# Take in user input, read int - system command 5
        syscall 	#call syscall to do action 5
        move $t0, $v0	# Store the user input into temporary register %t0
        
        beq $t0, $0, finish 		#if $t0 = 0 branch to finish
        #check if input is odd or even
 
        #sra $t5, $t5, 2
        rem $t5, $t0, 2			# If 0, even, else odd.
        bne $t5, $zero, addOdd		#if $t1 != 0 branch to addOdd
        j addEven 			#Jump to addEven if $t1 = 0
	
 	
addEven:	
	add $t1, $t1, $t0 	#add $t0 to $t1 to store sum into $t1
 	j main 			#jump to main to continue
 	
addOdd:	
	add $t2, $t2, $t0	 #add $t0 to $t2 to store sum into $t2
 	j main			 #Jump to main to continue
        
finish:
	li $v0, 4
 	la $a0, sumOfEven
	syscall 	#print "Sum of even numbers: "
	
	li $v0, 1	 #load 1 into v0 for incoming integer print
	la $a0, ($t1) 	#load address of even numbers stores at $t2
	syscall 	#print
	
	li $v0, 4	#load 4 into v0 for an upcoming string print
 	la $a0, sumOfOdd
	syscall 	#print "Sum of negative numbers: "
	
	li $v0, 1	#load 1 into v0 for incoming integer print
 	la $a0, ($t2)	#load address of negative numbers stores at $t1 into $a0
	syscall 	#print
