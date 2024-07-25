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
    li t0, 1
    bge a1, t0, done1       
    li a1, 72
    j exit2
done1:
    bge a2, t0, done2
    li a1, 72       
    j exit2  
done2:
    bge a4, t0, done3
    li a1, 73
    j exit2  
done3:
    bge a5, t0, done4
    li a1, 73
    j exit2  
done4:
    beq a2, a4, done5
    li a1, 74
    j exit2  
    
    
done5:


    # Prologue
    addi sp, sp, -36
    sw s0,0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw s7, 28(sp)
    sw ra, 32(sp)
    
    # Init
    li s3, 0 # i
    li s1, 0 # j
    mv s0, a1
    
    
    mv s2, a0
    mv s4, a2
    mv s5, a3
    mv s6, a5
    mv s7, a6


outer_loop_start:
    beq s3, s0, outer_loop_end
    li s1, 0



inner_loop_start:
    beq s1, s6, inner_loop_end
    
    # core part
    mul a2, s4, s3
    slli a2, a2, 2
    add a0, s2, a2
    slli a2, s1, 2
    add a1, s5, a2
    mv a2, s4
    li a3, 1
    mv a4, s6
    
    
    jal dot
    
    mul a2, s6, s3
    add a2, a2, s1
    slli a2, a2, 2
    add a2, s7, a2
    sw a0, 0(a2)
    
    
    addi s1, s1, 1
    j inner_loop_start



inner_loop_end:
    addi s3, s3, 1
    j outer_loop_start



outer_loop_end:


    # Epilogue
    lw s0,0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw s7, 28(sp)
    lw ra, 32(sp)
    addi sp, sp, 36
    
    ret
