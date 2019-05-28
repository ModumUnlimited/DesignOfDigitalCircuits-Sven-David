### Aanjhan Ranganathan <raanjhan@inf.ethz.ch>
### For Lab 8 Digital Technik 
### 2014

###   I/O addresses Reference
###  compatible to the compact modelling
###  0x00007FF0   LED output

.data
pattern: .word 0x00200000,0x00004000,0x00000080,0x00000001,0x00000002,0x00000004,0x00000008,0x00000400,0x00020000,0x01000000,0x02000000,0x04000000
loopcnt:  .word 0x001e8484

.text
   lw $t3, loopcnt    # initialize a  large loopcounter (so that the snake does not crawl SUPERFAST)
   addi $t5,$0,48       # initialize the length of the display pattern (in bytes)
   addi $s1, $0, -4    # length of minus one pattern

restartPositive:   
   addi $t4,$0,0
   j forward

restartNegative:
   addi $t4,$0,44
   j forward

forward:
   beq $t5,$t4, restartPositive
   lw $t0,0($t4)
   sw  $t0, 0x7ff0($0) # send the value to the display
   lw $s2 , 0x7ff8($0) # load the direction
   add $t4, $t4, $s2 # increment to the next address
   beq $s1, $t4, restartNegative # if t4 -4
   beq $0, $t4, restartNegative # if t4 is zero
   addi $t2, $0, 0 # clear $t2 counter
   lw $s0, 0x7ff4($0) # load the users speed value
   addi $s0, $s0, 1 # add one to the speed
   j wait


wait:
   beq $t2,$t3,forward   # Move snake if counter at loopcnt
   add  $t2, $t2, $s0    # increment counter based on speed selected by the user
   j wait                # Repeat

