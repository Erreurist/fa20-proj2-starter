.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    li t0, 1
    bge a2, t0, done1       
    li a1, 75
    j exit2
done1:
    bge a3, t0, done2
    li a1, 76         
    j exit2  
done2:
    bge a4, t0, done3
    li a1, 76    
    j exit2  
done3:
    # Prologue
    addi sp, sp, -12
    sw s0,0(sp)
    sw s1, 4(sp)
    sw ra, 8(sp)
    
    li t0, 0  # cnt 0
    mv s0, a0
    mv s1, a1
    li t5 0  # sum
 

loop_start:
    slli t1, t0, 2
    mul t2, t1, a3
    mul t3, t1, a4
    add t4, s0, t2
    lw a0, 0(t4)
    
    add t4, s1, t3
    lw a1, 0(t4)
    mul a1, a1, a0
    add t5, t5, a1
    addi t0, t0, 1
    beq t0, a2, loop_end
    j loop_start

loop_end:

    mv a0, t5
    # Epilogue
    lw s0,0(sp)
    lw s1, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    
    ret
