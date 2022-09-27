.data
orig: .space 100 # In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100
str0: .asciiz "\nEnter the number of assignments (between 1 and 25): "
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
lw $a0,0($t0)
beq $a0,$zero,end
li $v0,1
syscall
li $a0,32
li $v0,11

syscall #print the original score
addi $t0,$t0,4
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
lw $t3,0($t0)
beq $t3,$zero,endg
addi $t9,$t9,1
sw $t3,0($t1)
addi $t0,$t0,4
addi $t1,$t1,4
j startg
endg:

li $s1,0
start1:
la $t0,sorted
li $s0,0
beq $s1 $t9,end2
addi $s1,$s1,1
start2:
lw $t1,0($t0)
lw $t2,4($t0)

bge $t2,$t1,jump
beq $t2,$zero,end1
bge $s0,$t9,end1
addi $t0,$t0,4

addi $s0,$s0,1
j start2
end1:
j start1
jump:
sw $t2,0($t0)
sw $t1,4($t0)
addi $t0,$t0,4
addi $s0,$s0,1
j start2
end2:
li $s0,0
la $t0,sorted

start5:
#beq $s0,$t9,end5
#addi $s0,$s0,1
lw $a0,0($t0)
beq $a0,$zero,end5
li $v0,1
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

move $t0,$a0
move $t6,$a0
move $a1,$v0

start7:
lw $a0,0($t0)
beq $a0,$zero,end7
beq $a0,$a1,end7
addi $t0,$t0,4
addi $s1,$s1,1
#li $v0,1
#syscall
j start7


end7:
li $v0,4
la $a0, str5 #prints our the final string
syscall

li $t0,2
div $s1,$t0
mflo $t3 #quotient
mfhi $t4 #reminder
li $t2,0
add $t2,$t3,$t4
sub $t2,$t2,1
mul $t2,$t2,4
add $t6,$t6,$t2
lw $a0,0($t6)
li $v0,1
syscall
jr $ra
