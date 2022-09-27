.data
orig: .space 100 # In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100
str0: .asciiz "Enter the number of assignments (between 1 and 25): "
str1: .asciiz "Enter score: "
str2: .asciiz "Original scores: "
str3: .asciiz "\nSorted scores (in descending order): "
str4: .asciiz "\nEnter the number of (lowest) scores to drop: "
str5: .asciiz "Average (rounded up) with dropped scores removed: "
.text
# This is the main program.
# It first asks user to enter the number of assignments.
# It then asks user to input the scores, one at a time.
# It then calls selSort to perform selection sort.
# It then calls printArray twice to print out contents of the original and sorted scores.
# It then asks user to enter the number of (lowest) scores to drop.
# It then calls calcSum on the sorted array with the adjusted length (to account for droppedscores).
# It then prints out average score with the specified number of (lowest) scores dropped fromthe calculation.
main:
	addi $sp, $sp -4
	sw $ra, 0($sp)
	li $v0, 4
	la $a0, str0
	syscall
	li $v0, 5 # Read the number of scores from user
	syscall
	move $s0, $v0# $s0 = numScores
	move $t0, $0
	la $s1, orig # $s1 = orig
	la $s2, sorted # $s2 = sorted
loop_in:
	li $v0, 4
	la $a0, str1
	syscall
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5 # Read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	move $a0, $s0
	jal selSort # Call selSort to perform selection sort in original array
	li $v0, 4
	la $a0, str2

	syscall
	move $a0, $s1 # More efficient than la $a0, orig
	move $a1, $s0
	jal printArray # Print original scores
	li $v0, 4
	la $a0, str3
	syscall
	move $a0, $s2 # More efficient than la $a0, sorted
	jal printArray # Print sorted scores
	li $v0, 4
	la $a0, str4
	syscall
	li $v0, 5 # Read the number of (lowest) scores to drop
	syscall
	move $a1, $v0
	sub $a1, $s0, $a1 # numScores - drop
	move $a0, $s2
	jal calcSum # Call calcSum to RECURSIVELY compute the sum of scores that are notdropped
	# Your code here to compute average and print it
	lw $ra, 0($sp)
	addi $sp, $sp 4
	li $v0, 10
	syscall
	# printList takes in an array and its size as arguments.
	# It prints all the elements in one line with a newline at the end.
printArray:
	# Your implementation of printList here
	move $t9,$a1 
	move $t0,$a0
	#li $s0,0
	#la $t0,orig

start:
	#beq $s0,$a1,end
	#addi $s0,$s0,1
	lw $a0,0($t0) #load worth of first value to a0
	beq $a0,$zero,end #once a0 is 0 thats end of array
	
	li $v0,1 #print integer, a0 
	syscall
	
	li $a0,32
	li $v0,11 
	syscall #print space for numbers
	
	addi $t0,$t0,4 #increment t0 by 4
	j start
	
end:
	jr $ra
# selSort takes in the number of scores as argument.
# It performs SELECTION sort in descending order and populates the sorted array
selSort:
	move $s7,$s1 
	move $s6,$s2
	la $t0,orig
	la $t1,sorted
	li $t9,0
	
startg:
	#copy orig to sorted
	lw $t3,0($t0) #load value of array
	
	beq $t3,$zero,endg #once t3 is empty go to endg
	
	addi $t9,$t9,1 #add 1 into t9
	sw $t3, 0($t1) #store first input into address of $t1
	addi $t0,$t0,4 #add 4 into t0 for next address of orig
	addi $t1,$t1,4 #add 4 into t1 for next address of sorted
	j startg

endg:
	li $s1,0

start1:
	la $t0,sorted #set t0 as address for sorted array
	li $s0,0
	beq $s1 $t9,end2 #if s1 and t9 are equal to go to end2
	addi $s1,$s1,1

start2:
	lw $t1,0($t0) #load first num
	lw $t2,4($t0) #load second num

	#if 
	bge $t2,$t1,jump #if 2nd is greater than 1st go to jump
	beq $t2,$zero,end1 #if 2nd is equal to 0 go to end1
	bge $s0,$t9,end1 #if s0 is greater than t9 go to end1
	addi $t0,$t0,4 #else increment t0 for address of next value
	addi $s0,$s0,1 #increment s0 by 1 
	j start2

end1:
	j start1

jump:
	sw $t2,0($t0) #store first val to 2nd spot
	sw $t1,4($t0) #store second val to fist spot
	addi $t0,$t0,4 #increment for next value
	addi $s0,$s0,1 #increment s0
	j start2

end2:
	li $s0,0 #load 0 into s0
	la $t0,sorted #load address of sorted into t0

start5:
#beq $s0,$t9,end5
#addi $s0,$s0,1
	lw $a0,0($t0) #load worth of sorted to a0
	beq $a0,$zero,end5 #if a0 is 0 go to end5
	#li $v0,1 
	#syscall
	addi $t0,$t0,4 
	j start5

end5:
	move $s1,$s7 
	move $s2,$s6
	jr $ra
	

# calcSum takes in an array and its size as arguments.
# It RECURSIVELY computes and returns the sum of elements in the array.
# Note: you MUST NOT use iterative approach in this function.
calcSum:
	#a1 m value ha
	#a0 m wo wal
	li $s1,1

	move $t0,$a0 #store address of sorted into t0
	move $t6,$a0 #store address of sorted into t6
	move $a1,$v0 #store v0 into a1

start7:
	lw $a0,0($t0) #load first value of sorted into a0
	beq $a0,$zero,end7 #if a0 is 0, end of array
	beq $a0,$a1,end7 #if a0 = a1, end
	addi $t0,$t0,4 #increment t0 for next value
	addi $s1,$s1,1 #increment s1
	#li $v0,1
	#syscall
	j start7

end7:
	li $v0,4
	la $a0, str5 #prints our the final string
	syscall
	
	li $t0,2
	div $s1,$t0
	mflo $t3 #store quotient into t3
	mfhi $t4 #store remainder into t4
	li $t2,0
	add $t2,$t3,$t4 #add quotient + remainder
	sub $t2,$t2,1 #subtract by 1
	mul $t2,$t2,4 #mult by 4
	add $t6,$t6,$t2 #add t2 into t6 which is has address of sorted
	lw $a0,0($t6) #load worth of t6 into a0
	
	li $v0,1
	syscall #print
	jr $ra
