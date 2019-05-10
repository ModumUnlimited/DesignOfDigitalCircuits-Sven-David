### Aanjhan Ranganathan <raanjhan@inf.ethz.ch>
### For Lab 8 Digital Technik 
### 2014

###   I/O addresses Reference
###  compatible to the compact modelling
###  0x00007FF0   LED output

.data
pattern: .word 0x0,0x0,0x200000,0x4200000,0x6200000,0x7200000,0x7300000,0x7340000,0x7360000,0x7370000,0x7372000,0x7372800,0x7372C00,0x7372E00,0x7372E20,0x7372E30,0x7372E38,0x7372E38

loopcnt:  .word 0x001e8484

.text
   lw $t3, loopcnt    # initialize a  large loopcounter (so that the snake does not crawl SUPERFAST)
   addi $t5,$0,72       # initialize the length of the display pattern (in bytes)


restart:   
   addi $t4,$0,0

forward:
   beq $t5,$t4, restart
   lw $t0,0($t4)
   sw  $t0, 0x7ff0($0) # send the value to the display
   
   addi $t4, $t4, 4 # increment to the next address
   addi $t2, $0, 0 # clear $t2 counter
   lw $s0, 0x7ff4($0) # load the users speed value
   addi $s0, $s0, 1 # add one to the speed
   j wait


wait:
   beq $t2,$t3,forward   # Move snake if counter at loopcnt
   add  $t2, $t2, $s0    # increment counter based on speed selected by the user
   j wait                # Repeat


