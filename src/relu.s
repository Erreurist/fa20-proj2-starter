.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    li t0, 1
    bge a1, t0, done 

        
    li a1, 78         
    j exit2     

done:
    
    
    # Prologue
    addi sp, sp, -12
    sw s0,0(sp)
    sw s1, 4(sp)
    sw ra, 8(sp)
       
    li t0, 0
    mv s0, a0
    

        
loop_start:
    slli t1, t0, 2
    add s1, s0, t1
    lw a0, 0(s1)
    
    bge a0, x0, loop_continue
    li a0, 0

loop_continue:
    sw a0, 0(s1) 
    addi t0, t0, 1
    beq t0, a1, loop_end
    j loop_start

loop_end:


    # Epilogue
    
    lw s0,0(sp)
    lw s1, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12

    
	ret


    
