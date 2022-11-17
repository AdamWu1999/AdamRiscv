
CASE = ../cases

REGRESS_INTROM = regress -m 
REGRESS_SLV = regress -s 


#-------------------------------------------------------------------------------------------------------
# CASES

rv : \
	J_test\
	JR_test\
	Beq_test\
	Bne_test\
	Blt_test\
	Bltu_test\
	S_test\
	U_test\
	Load_test\
	R_test

J_test :
		${REGRESS_INTROM} -v ${CASE}/riscv_core/introm/J_test
JR_test :
		${REGRESS_INTROM} -v ${CASE}/riscv_core/introm/JR_test
Beq_test :
		${REGRESS_INTROM} -v ${CASE}/riscv_core/introm/Beq_test
Bne_test :
		${REGRESS_INTROM} -v ${CASE}/riscv_core/introm/Bne_test
Blt_test :
		${REGRESS_INTROM} -v ${CASE}/riscv_core/introm/Blt_test
Bltu_test :
		${REGRESS_INTROM} -v ${CASE}/riscv_core/introm/Bltu_test
S_test :
		${REGRESS_INTROM} -v ${CASE}/riscv_core/introm/S_test
Load_test :
		${REGRESS_INTROM} -v ${CASE}/riscv_core/introm/Load_test
U_test :
		${REGRESS_INTROM} -v ${CASE}/riscv_core/introm/U_test
R_test :
		${REGRESS_INTROM} -v ${CASE}/riscv_core/introm/R_test
#-------------------------------------------------------------------------------------------------------
clean  :
	 rm -rf VCS* *.vdb Cov_file


