.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks
    li t3, 1
    bge a1, t3, done1       
    li a1, 72
    j exit2
done1:
    bge a2, t3, done2
    li a1, 72       
    j exit2  
done2:
    bge a4, t3, done3
    li a1, 73
    j exit2  
done3:
    bge a5, t3, done4
    li a1, 73
    j exit2  
done4:
    beq a2, a4, done5
    li a1, 74
    j exit2  
    
    
done5:


    # Prologue
    addi sp, sp, -12
    sw s0,0(sp)
    sw s1, 4(sp)
    sw ra, 8(sp)
    
    # Init
    li t3, 0 # i
    li s1, 0 # j
    mv s0, a1
    
    
    mv t2, a0
    mv t4, a2
    mv t5, a3
    mv t6, a4

outer_loop_start:
    beq t3, s0, outer_loop_end
    li s1, 0



inner_loop_start:
    beq s1, a5, inner_loop_end
    
    # core part
    mul a2, t4, t3
    slli a2, a2, 2
    add a0, t2, a2
    slli a2, s1, 2
    add a1, t5, a2
    mv a2, t4
    li a3, 1
    mv a4, a5
    
    
    jal dot
    
    mul a2, a5, t3
    add a2, a2, s1
    slli a2, a2, 2
    add a2, a6, a2
    sw a0, 0(a2)
    
    
    addi s1, s1, 1
    j inner_loop_start



inner_loop_end:
    addi t3, t3, 1
    j outer_loop_start



outer_loop_end:


    # Epilogue
    lw s0,0(sp)
    lw s1, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    
    ret
