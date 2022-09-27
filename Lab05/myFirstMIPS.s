.data
.text
   add $t0,$s0,$zero #we set $t0=0
   sub $t1,$t0,1     #we subtract $to-1 into register t1 = -1
   add $t2,$t1,$t0   # we add t0 to t1 into register t2 = 0 + -1 = -1
   sub $t3,$t2,3     #subtract 3 to -1 so $t3 = -4
   add $t4,$t3,$t2   #add -4 + -1 into $t4 = -5
   sub $t5,$t4,5     #subtract 5 to -5 into $t5 = -10
   add $t6,$t5,$t4   #add t4 = -5 to $t5= -10 so $t6 = -15
   sub $t7,$t6, 7    #subtract 7 to t6 = -15 so $t7 = -22
