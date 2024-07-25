.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:
    li t0, 1
    bge a1, t0, done 

        
    li a1, 77     
    j exit2     

done:
    # Prologue
    addi sp, sp, -12
    sw s0,0(sp)
    sw s1, 4(sp)
    sw ra, 8(sp)
    
    li t0, 0
    mv s0, a0
    li t2, 0    ## ret val
    li t3, 0    ##max val
    slli t1, t0, 2
    add s1, s0, t1
    lw t3, 0(s1)

loop_start:
    slli t1, t0, 2
    add s1, s0, t1
    lw a0, 0(s1)

    bge t3, a0, loop_continue
    mv t2, t0
    mv t3, a0
loop_continue:
    
    addi t0, t0, 1
    beq t0, a1, loop_end
    j loop_start

loop_end:
    mv a0, t2
    # Epilogue
    lw s0,0(sp)
    lw s1, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12


    ret
