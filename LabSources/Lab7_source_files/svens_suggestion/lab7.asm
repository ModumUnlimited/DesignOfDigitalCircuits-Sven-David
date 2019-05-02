#
# Calculate sum from A to B.
#
# Authors: 
#	X Y, Z Q 
#
#

.text
main:
	# Register initialization
	add $t0, $zero, $zero #The first input
	addi $t1, $zero, 1000 #The second input
	add $t2, $zero, $zero #Result register
	
loop:	add $t2, $t2, $t0 #Add first number to result
	beq $t0, $t1, end #If all numbers where added, jump to end
	addi $t0, $t0, 1 #Increase first number by one
	j loop #Jump back to loop head
	
end:	
	j	end	# Infinite loop at the end of the program. 


