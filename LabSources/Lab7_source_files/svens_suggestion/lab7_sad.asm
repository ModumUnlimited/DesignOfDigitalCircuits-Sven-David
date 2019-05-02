#
# Sum of Absolute Differences Algorithm
#

.text


main:


# Initializing data in memory... 
# Store in $s0 the address of the first element in memory
	# lui sets the upper 16 bits of the specified register
	# ori the lower ones
	# (to be precise, lui also sets the lower 16 bits to 0, ori ORs it with the given immediate)
	     lui     $s0, 0x0000 # Address of first element in the vector
	     ori     $s0, 0x0000
	     
	     #Store the array of left_image
	     addi     $t0, $0, 5	# left_image[0]	
	     sw       $t0, 0($s0)
	     addi     $t0, $0, 16	# left_image[1]		
	     sw       $t0, 4($s0)
	     addi     $t0, $0, 7	# left_image[2]		
	     sw       $t0, 8($s0)
	     addi     $t0, $0, 1	# left_image[3]
	     sw       $t0, 12($s0)
	     addi     $t0, $0, 1	# left_image[4]
	     sw       $t0, 16($s0)
	     addi     $t0, $0, 13	# left_image[5]	     
	     sw       $t0, 20($s0)	     
	     addi     $t0, $0, 2	# left_image[6]	     
	     sw       $t0, 24($s0)	  	     
	     addi     $t0, $0, 8	# left_image[7]	     
	     sw       $t0, 28($s0)	  	     	     
	     addi     $t0, $0, 10	# left_image[8]	     
	     sw       $t0, 32($s0)
	     
	     #Do the same for the right
	     addi     $s0, $s0, 36	#Base register offset
	     addi     $t0, $0, 5	# right_image[0]	
	     sw       $t0, 0($s0)
	     addi     $t0, $0, 16	# right_image[1]		
	     sw       $t0, 4($s0)
	     addi     $t0, $0, 7	# right_image[2]		
	     sw       $t0, 8($s0)
	     addi     $t0, $0, 1	# right_image[3]
	     sw       $t0, 12($s0)
	     addi     $t0, $0, 1	# right_image[4]
	     sw       $t0, 16($s0)
	     addi     $t0, $0, 13	# right_image[5]	     
	     sw       $t0, 20($s0)	     
	     addi     $t0, $0, 2	# right_image[6]	     
	     sw       $t0, 24($s0)	  	     
	     addi     $t0, $0, 8	# right_image[7]	     
	     sw       $t0, 28($s0)	  	     	     
	     addi     $t0, $0, 10	# right_image[8]	     
	     sw       $t0, 32($s0)
	     
	addi $s1, $0, 0 # $s1 = i = 0
	addi $s2, $0, 9	# $s2 = image_size = 9
	
	# We use these adresses to access/store data
	addi $s3, $0, 0 
	addi $s4, $0, 36 
	addi $s5, $0, 72 

loop:

	# Check if we have traverse all the elements 
	# of the loop. If so, jump to end_loop:
	# This is the case if the adresses s1 and s2 match up
	beq $s1,$s2, end_loop
	
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
	
end:	
	j	end	# Infinite loop at the end of the program. 




#Provided abs_diff function
abs_diff:
	sub $t1, $a0, $a1
	sra $t2,$t1,31   
	xor $t1,$t1,$t2   
	sub $v0,$t1,$t2    

	jr $ra

#Provided recursive_sum function
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
	add  $a1, $t0, $0	 #update the second argument
        jal   recursive_sum 
        lw    $t0, 0($sp)       # Restore size - 1 from stack
        sll  $t1, $t0, 2        # Multiply size by 4
        add   $t1, $t1, $a0     # Compute & arr[ size - 1 ]
        lw    $t2, 0($t1)       # t2 = arr[ size - 1 ]
        add   $v0, $v0, $t2     # retval = $v0 + arr[size - 1]
        lw    $ra, 4($sp)       # restore return address from stack         
        addi $sp, $sp, 8        # Adjust sp
        jr $ra                  # Return
