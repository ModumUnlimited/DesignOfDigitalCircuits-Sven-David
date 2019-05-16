#
# Sum of Absolute Differences Algorithm (Color support)
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
	     
	     # Store the data of right_image
	     addi    $t0, $0, 5     # left_image[0]	
	     sw      $t0, 0($s0)
	     addi    $t0, $0, 16		
	     sw      $t0, 4($s0)
	     addi    $t0, $0, 7		
	     sw      $t0, 8($s0)
	     addi    $t0, $0, 1     # left_image[1]  
	     sw      $t0, 12($s0)
	     addi    $t0, $0, 1
	     sw      $t0, 16($s0) 
	     addi    $t0, $0, 13    
	     sw      $t0, 20($s0)	     
	     addi    $t0, $0, 2     # left_image[2]	     
	     sw      $t0, 24($s0)	  	     
	     addi    $t0, $0, 8	     
	     sw      $t0, 28($s0)	  	     	     
	     addi    $t0, $0, 10     
	     sw      $t0, 32($s0)	 	     	     	     	     

	# Prepare register for further data
	     addi $s0, $s0, 36
	# Store the data of right_image
	     addi    $t0, $0, 4     # right_image[0]	
	     sw      $t0, 0($s0)
	     addi    $t0, $0, 15    		
	     sw      $t0, 4($s0)
	     addi    $t0, $0, 8     	
	     sw      $t0, 8($s0)
	     addi    $t0, $0, 0     # right_image[1]
	     sw      $t0, 12($s0)
	     addi    $t0, $0, 2     
	     sw      $t0, 16($s0)
	     addi    $t0, $0, 12    	     
	     sw      $t0, 20($s0)	     
	     addi    $t0, $0, 3     # right_image[2]	     
	     sw      $t0, 24($s0)	  	     
	     addi    $t0, $0, 7     	     
	     sw      $t0, 28($s0)	  	     	     
	     addi    $t0, $0, 11    	     
	     sw      $t0, 32($s0)	 	     	     	
	     
	addi $s1, $0, 0 # $s1 = i = 0
	addi $s2, $0, 3	# $s2 = image_size = 9
	
	# We use these adresses to access/store data
	addi $s3, $0, 0 
	addi $s4, $0, 36 
	addi $s5, $0, 72 

loop:

	# Check if we have traversed all the elements 
	# of the loop. If so, jump to end_loop:
	# This is the case if the adresses s1 and s2 match up
	beq $s1,$s2, end_loop
	
	#Prepare stack space
	subi $sp, $sp, 24
	
	#Load and store red value left
	lw $t0, ($s3)
	sw $t0, ($sp)
	#Load and store red value right
	lw $t0, ($s4)
	sw $t0, 4($sp)
	
	#Load and store green value left
	lw $t0, 4($s3)
	sw $t0, 8($sp)
	#Load and store green value right
	lw $t0, 4($s4)
	sw $t0, 12($sp)
	
	#Load and store blue value left
	lw $t0, 8($s3)
	sw $t0, 16($sp)
	#Load and store blue value right
	lw $t0, 8($s4)
	sw $t0, 20($sp)
	
	#Move ahead in memory
	addi $s3, $s3, 12
	addi $s4, $s4, 12
	
	#Store stack pointer
	add $a0, $zero, $sp
	
	jal abs_diff_color
	
	sw $v0, ($s5)
	addi $s5, $s5, 4
	addi $sp, $sp, 24
	addi $s1, $s1, 1
	j loop
	
abs_diff_color:

	#Retrieve stack pointer
	add $sp, $zero, $a0
	
	#Load
	lw $a0, ($sp)
	lw $a1, 4($sp)
	sw $ra, ($sp)
	#Compute
	jal abs_diff
	#Store
	sw $v0, 4($sp)
	
	#Load
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	#Compute
	jal abs_diff
	lw $t1, 4($sp)
	add $t1, $t1, $v0
	sw $t1, 4($sp)
	
	#Load
	lw $a0, 16($sp)
	lw $a1, 20($sp)
	#Compute
	jal abs_diff
	#Store
	lw $t1, 4($sp)
	add $t1, $t1, $v0
	sw $t1, 4($sp)
	
	lw $v0, 4($sp)
	lw $ra, ($sp)
	jr $ra

		
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
	
end:	
	j	end	# Infinite loop at the end of the program. 



#Provided abs_diff function modified to support color
abs_diff:
	slt $t0, $a0, $a1 #Check if first is smaller than second
	beq $t0, $0, abs_diff_2max #If so, branch to 2max logic
	j abs_diff_1max #Else, jump to 1max logic

#Handles the case that a1 is bigger
abs_diff_1max:
	sub $v0, $a1, $a0
	jr $ra	

#Handles the case that a2 is bigger
abs_diff_2max:
	sub $v0, $a0, $a1
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
