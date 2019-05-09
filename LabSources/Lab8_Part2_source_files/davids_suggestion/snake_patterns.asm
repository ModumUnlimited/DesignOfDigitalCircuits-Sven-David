### Aanjhan Ranganathan <raanjhan@inf.ethz.ch>
### For Lab 8 Digital Technik 
### 2014

###   I/O addresses Reference
###  compatible to the compact modelling
###  0x00007FF0   LED output

.data
pattern: .word 0x00200000,0x00004000,0x00000080,0x00000001,0x00000002,0x00000004,0x00000008,0x00000400,0x00020000,0x01000000,0x02000000,0x04000000
loopcntSlow: .word 0x000F4242
loopcntNorm: .word 0x001e8484
loopcntFast: .word 0x003D0908
loopcntLight: .word 0x007A1210

.text
   lw $t3, loopcntNorm    # initialize a  large loopcounter (so that the snake does not crawl SUPERFAST)
   addi $t5,$0,48       # initialize the length of the display pattern (in bytes)
   addi $s0,$0,0x00000001 # normal
   addi $s1,$0,0x00000000 # slow
   addi $s2,$0,0x00000010 # fast
   addi $s3,$0,0x00000011 # light


restart:   
   addi $t4,$0,0

forward:
   beq $t5,$t4, restart
   lw $t0,0($t4)
   sw  $t0, 0x7ff0($0) # send the value to the display
   
   addi $t4, $t4, 4 # increment to the next address
   addi $t2, $0, 0 # clear $t2 counter

wait:
   beq $t2,$t3,forward
   addi  $t2, $t2, 1     # increment counter
   j findSpeed

findSpeed:
   lw $t1, 0x7ff4($0) # load the speed from the memory
   beq $t1, $s1, slow # check if speed is slow
   beq $t1, $s2, fast # check if speed is fast
   beq $t1, $s3, light # check if speed is as fast as light
   add $t3, $0, $s0 # hence we are normal speed 
   j wait

slow: 
   lw $t3, loopcntSlow # load slow speed
   j wait

fast: 
   lw $t3, loopcntFast # load fast speed
   j wait

light: 
   lw $t3, loopcntLight # load light speed
   j wait