.data 

n: .word 25

str1: .asciiz "Less than\n"
str2: .asciiz "Less than or equal to \n"
str3: .asciiz "Greater than\n"
str4: .asciiz "Greater than or equal to\n"
input: .asciiz "Enter a number: "

.text
main:   
	la $s0, n	# Store n adress in $s0
        lw $s0, 0($s0)	#load word of n from $s0 where its saved then saves whats at the address of n, so 25 into %s0
        
        li $v0, 4	#load 4 into v0 for an upcoming string print
	la $a0, input   #load address of label input into $a0
	syscall		#print "Enter a number: "
	
	#Then
	
	li $v0, 5	# Take in user input, read int - system command 5
        syscall 	#call syscall to do action 5
        move $t0, $v0	# Store the user input into temporary register %t0
        
        #slt sets the destination register's content to the value 1 if the first source register's contents are. less than the second source register's contents. Otherwise, it is set to the value 0.
        
        #slt $t1, $t0, $s0   # Check if $t0 < $s0, stores 1 if true into $t1 else 0
        #beq $t1, $0, greq  #Check if $t1 is 0, branch to its greater than or equal to
        #j less              #Jump to less if $t1 = 1, since it was less than
        
        slt $t1, $s0, $t0    #Check if $s0 < $t0, $t1 will be 0 when false else $t1 is 1 for true.
        beq $t1, $0, leq 	#Check if $t1 is 0, branch to its less than or equal to
        j great                # Jump to great if $t1 = 1

less:   
	la $a0, str1	#load address of label str1 input into $a0
        j finish	#Jump to finish

leq:  
	  la $a0, str2	#load address of label str2 input into $a0
        j finish

great:  
	la $a0, str3	#load address of label str3 input into $a0
        j finish

greq:   
	la $a0, str4	#load address of label str4 input into $a0
        j finish

finish: 
	li $v0, 4 #load 4 into $v0 to print whats stored in $a0.
        syscall