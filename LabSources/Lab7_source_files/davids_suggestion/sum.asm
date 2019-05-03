#
# Calculate sum from A to B.
#
# Authors: 
#	X Y, Z Q 
#
#

.text
main:
	# initialize the two registers
	add $t0, $zero, $zero
	addi $t1, $zero, 1000
	add $t2, $zero, $zero
	
loop:	add $t2, $t2, $t0
	beq $t0, $t1, end
	addi $t0, $t0, 1
	j loop
	
end:	
	j	end	# Infinite loop at the end of the program. 


# alternative syscall instead of j end -> simulation will only work this way
