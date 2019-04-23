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
	     addi   $t0, $0, 5	# left_image[0]	
	     sw      $t0, 0($s0)
	     addi   $t0, $0, 16	# left_image[1]		
	     sw      $t0, 4($s0)
	     addi   $t0, $0, 7	# left_image[2]		
	     sw      $t0, 8($s0)
	     addi   $t0, $0, 1  # left_image[3]
	     sw      $t0, 12($s0)
	     sw      $t0, 16($s0) # left_image[4] is also 1	     
	     addi   $t0, $0, 13  # left_image[5]	     
	     sw      $t0, 20($s0)	     
	     addi   $t0, $0, 2  # left_image[5]	     
	     sw      $t0, 24($s0)	  	     
	     addi   $t0, $0, 8  # left_image[6]	     
	     sw      $t0, 28($s0)	  	     	     
	     addi   $t0, $0, 10  # left_image[7]	     
	     sw      $t0, 32($s0)	 	     	     	     	     

	# we can increase the base register to load the next array:
	     addi $s0, $s0, 36
	# now we can read in the right_image
	     addi   $t0, $0, 4	# right_image[0]	
	     sw      $t0, 0($s0)
	     addi   $t0, $0, 15	# right_image[1]		
	     sw      $t0, 4($s0)
	     addi   $t0, $0, 8	# right_image[2]		
	     sw      $t0, 8($s0)
	     addi   $t0, $0, 0  # right_image[3]
	     sw      $t0, 12($s0)
	     addi   $t0, $0, 2  # right_image[4]
	     sw      $t0, 16($s0)
	     addi   $t0, $0, 12  # right_image[5]	     
	     sw      $t0, 20($s0)	     
	     addi   $t0, $0, 3  # right_image[5]	     
	     sw      $t0, 24($s0)	  	     
	     addi   $t0, $0, 7  # right_image[6]	     
	     sw      $t0, 28($s0)	  	     	     
	     addi   $t0, $0, 11  # right_image[7]	     
	     sw      $t0, 32($s0)	 	     	     	     	     
	
	# we now set the base address for the disparity map:
	     
	
	addi $s1, $0, 0 # $s1 = i = 0
	addi $s2, $0, 9	# $s2 = image_size = 9
	
	addi $s3, $0, 0 # is used to access the left image data
	addi $s4, $0, 36 # is used to access the right image data
	addi $s5, $0, 72 # is used to store the disparity
	
loop:

	# Check if we have traverse all the elements 
	# of the loop. If so, jump to end_loop:
	
	beq $s1, $s2, end_loop
	
	
	# Load left_image{i} and put the value in the corresponding register
	# before doing the function call

	lw $a0, ($s3)
	addi $s3, $s3, 4
	
	# Load right_image{i} and put the value in the corresponding register
	
	lw $a1, ($s4)
	addi $s4, $s4, 4
	
	# Call abs_diff
	
	jal abs_diff
	
	#Store the returned value in sad_array[i]
	
	sw $v0, ($s5)
	addi $s5, $s5, 4
	
	
	# Increment variable i and repeat loop:
	
	addi $s1, $s1, 1
	
	j loop
	
end_loop:

	#Calculate the base address of sad_array (first argument
	#of the function call)and store in the corresponding register   
	
	addi $a0, $0, 72
	
	# Prepare the second argument of the function call: the size of the array
	
	addi $a1, $0, 9
	
	# Call to funtion
	
	jal recursive_sum
	
	#Store the returned value in $t2
	
	add $t2, $0, $v0
	
	j end


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
	
	


# $a0 is the address of first array element
# $a1 is the length of the array
# $v0 is the sum of all the elements in the array
recursive_sum:
	# if the remaining length is zero, we return 
	bne $a1, $0, recursive_sum_recursion
	# return to caller
	addi $v0, $zero,0
	jr $ra
recursive_sum_recursion:
	# we have not returned, hence we can still sum
	# we will first store the current $ra on the stack
	# we will decrease stack pointer by 4 (since the stack pointer grows from top to bottom)
	subi $sp, $sp , 4
	# store the old return address on the stack
	sw $ra, ($sp)
	# now we can recursively call ourselves
	subi $a1, $a1, 1
	jal recursive_sum
	# calculate the memory location
	addi $a1, $a1, 1
	sll $t1, $a1, 4
	# add the content of the memory location to our sum
	add $v0, $v0, $t0
	# load the old return address from the stack again
	lw $ra, ($sp)		
	# increment stack pointer again
	addi $sp, $sp, 4
	# return 
	jr $ra
	


end:	# j end 


