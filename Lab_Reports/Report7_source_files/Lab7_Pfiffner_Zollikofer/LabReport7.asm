#
# Sum of Absolute Differences Algorithm
#
# Authors: Sven Pfiffner and David Zollikofer
#
#

.text


main:


# Initializing data in memory... 
# Store in $s0 the address of the first element in memory
	# lui sets the upper 16 bits of thte specified register
	# ori the lower ones
	# (to be precise, lui also sets the lower 16 bits to 0, ori ORs it with the given immediate)
	     lui     $s0, 0x0000 # Address of first element in the vector
	     ori     $s0, 0x0000
	     addi   $t0, $0, 5	# left_image[0]	R
	     sw      $t0, 0($s0)
	     addi   $t0, $0, 16	# left_image[0]	 G	
	     sw      $t0, 4($s0)
	     addi   $t0, $0, 7	# left_image[0]	B	
	     sw      $t0, 8($s0)
	     addi   $t0, $0, 1  # left_image[1] R
	     sw      $t0, 12($s0)
	     sw      $t0, 16($s0) # left_image[1] is also 1	 G     
	     addi   $t0, $0, 13  # left_image[1] 	     B
	     sw      $t0, 20($s0)	     
	     addi   $t0, $0, 2  # left_image[2]  R
	     sw      $t0, 24($s0)	  	     
	     addi   $t0, $0, 8  # left_image[2]  G
	     sw      $t0, 28($s0)	  	     	     
	     addi   $t0, $0, 10  # left_image[2] B     
	     sw      $t0, 32($s0)	 	     	     	     	     

	# we can increase the base register to load the next array:
	     addi $s0, $s0, 36
	# now we can read in the right_image
	     addi   $t0, $0, 4	# right_image[0]	
	     sw      $t0, 0($s0)
	     addi   $t0, $0, 15	# right_image[0]		
	     sw      $t0, 4($s0)
	     addi   $t0, $0, 8	# right_image[0]		
	     sw      $t0, 8($s0)
	     addi   $t0, $0, 0  # right_image[1]
	     sw      $t0, 12($s0)
	     addi   $t0, $0, 2  # right_image[1]
	     sw      $t0, 16($s0)
	     addi   $t0, $0, 12  # right_image[1]	     
	     sw      $t0, 20($s0)	     
	     addi   $t0, $0, 3  # right_image[2]	     
	     sw      $t0, 24($s0)	  	     
	     addi   $t0, $0, 7  # right_image[2]	     
	     sw      $t0, 28($s0)	  	     	     
	     addi   $t0, $0, 11  # right_image[2]	     
	     sw      $t0, 32($s0)	 	     	     	     	     
	
	# we now set the base address for the disparity map:
	
	
	addi $s1, $0, 0 # $s1 = i = 0
	addi $s2, $0, 3	# $s2 = image_size = 3 -> we have three pixels
	
	addi $s3, $0, 0 # is used to access the left image data
	addi $s4, $0, 36 # is used to access the right image data
	addi $s5, $0, 72 # is used to store the disparity
	
loop:

	# Check if we have traverse all the elements 
	# of the loop. If so, jump to end_loop:
	
	beq $s1, $s2, end_loop
	
	# we first make some space on the stack -> recall that stack in MIPS grows from top to bottom
	subi $sp, $sp , 24 # 2 * 3 * 4
	#now we can start storing our data:
	# load the red value of the pixel to temp reg 0. - left image
	lw $t0, ($s3)
	# store the red value of the pixel on the stack
	sw $t0, ($sp)
	
	# load the red value of the pixel to temp reg 0. - right image
	lw $t0, ($s4)
	# store the red value of the pixel on the stack
	sw $t0, 4($sp)
	
	
	
	# load the green value of the pixel to temp reg 0. - left image
	lw $t0, 4($s3)
	# store the green value of the pixel on the stack
	sw $t0, 8($sp)
	
	# load the green value of the pixel to temp reg 0. - right image
	lw $t0, 4($s4)
	# store the green value of the pixel on the stack
	sw $t0, 12($sp)
	
	
	
	# load the blue value of the pixel to temp reg 0. - left image
	lw $t0, 8($s3)
	# store the blue value of the pixel on the stack
	sw $t0, 16($sp)
	
	# load the blue value of the pixel to temp reg 0. - right image
	lw $t0, 8($s4)
	# store the blue value of the pixel on the stack
	sw $t0, 20($sp)
	
	addi $s3, $s3, 12
	addi $s4, $s4, 12
	
	# store stack pointer in $a0 register
	add $a0, $zero, $sp
	
	jal abs_diff_color
	
	
	#Store the returned value in sad_array[i]
	
	sw $v0, ($s5)
	addi $s5, $s5, 4
	
	# reset the stack pointer again
	addi $sp, $sp , 24 # 2 * 3 * 4
	
	# Increment variable i and repeat loop:
	
	addi $s1, $s1, 1
	
	j loop
	
end_loop:

	#Calculate the base address of sad_array (first argument
	#of the function call)and store in the corresponding register   
	
	addi $a0, $0, 72
	
	# Prepare the second argument of the function call: the size of the array
	
	addi $a1, $0, 3
	
	# Call to funtion
	
	jal recursive_sum
	
	#Store the returned value in $t2
	
	add $t2, $0, $v0
	
	j end




abs_diff_color:
	# load stackpointer from argument
	add $sp, $zero, $a0

	# now we can calculate the difference for every color
	
	lw $a0, ($sp)
	lw $a1, 4($sp)

	# now we store the return address
	sw $ra, ($sp)
	# call the subroutine
	jal abs_diff
	#store the result on the stack
	sw $v0, 4($sp)
	
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	# call the subroutine
	jal abs_diff
	# add the result to the already stored one on the stack
	lw $t1, 4($sp)
	add $t1, $t1, $v0
	sw $t1, 4($sp)
	
	
	lw $a0, 16($sp)
	lw $a1, 20($sp)
	# call the subroutine
	jal abs_diff
	# add the result to the already stored one on the stack
	lw $t1, 4($sp)
	add $t1, $t1, $v0
	sw $t1, 4($sp)
	
	#store result in $v0
	lw $v0, 4($sp)
	
	# restore $ra register
	lw $ra, ($sp)
	# go back to caller
	jr $ra


# a0 is the pixel from the first image
# a1 is the pixel from the second image
# v0 will be the absolute difference between the two
abs_diff:
	# find out which one is bigger
	slt $t0, $a0,$a1
	# if the second one is bigger we jump
	beq $t0,$0, abs_diff_a1_smaller
	# we know $a1 is bigger
	sub $v0, $a1,$a0
	# jump back to caller
	jr $ra
abs_diff_a1_smaller:
	# now $a2 is bigger
	sub $v0, $a0,$a1
	# jump back to caller
	jr $ra
	

# ------- opted for the provided implementation instead of our implementation since this one is shorter --------------
# $a0 is the address of first array element
# $a1 is the length of the array
# $v0 is the sum of all the elements in the array
recursive_sum:    
	addi $sp, $sp, -8       # Adjust sp
        addi $t0, $a1, -1       # Compute size - 1
        sw   $t0, 0($sp)        # Save size - 1 to stack
        sw   $ra, 4($sp)        # Save return address
        bne  $a1, $zero, else   # size == 0 ?
        addi  $v0, $0, 0        # If size == 0, set return value to 0
        addi $sp, $sp, 8        # Adjust sp
        jr $ra                  # Return

else:     
	add  $a1, $t0, $0	#update the second argument
        jal   recursive_sum 
        lw    $t0, 0($sp)       # Restore size - 1 from stack
        sll  $t1, $t0, 2        # Multiply size by 4
        add   $t1, $t1, $a0     # Compute & arr[ size - 1 ]
        lw    $t2, 0($t1)       # t2 = arr[ size - 1 ]
        add   $v0, $v0, $t2     # retval = $v0 + arr[size - 1]
        lw    $ra, 4($sp)       # restore return address from stack         
        addi $sp, $sp, 8        # Adjust sp
        jr $ra                  # Return


end:	
	j end 
