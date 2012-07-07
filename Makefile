#============================================================================
#  BigInt class makefile
#
#===========================================================================
TEST_PROG_DIR = ../../cs33001_shared/BigInt/Test_Progs/
OUT_DIR       = ./

#-------------------------------------------------------------------------------
GXX           = g++
COMPILE_OPT   = -g 
COMPILE_OPT   = -g -O -Wall -W -Wunused -Wuninitialized -Wshadow 
#COMPILE_OPT   = -g -O -Wall -W -Wunused -Wuninitialized -Wshadow -Wreorder -Weffc++ -pedantic 

INCLUDE_OPT   = -I .
#INCLUDE_OPT   = -I. -I-

ECHO = /bin/echo

#-------------------------------------------------------------------------------
TEST_PROG_01 = test_ctor_to_string
TEST_PROG_02 = test_string_ctor
TEST_PROG_03 = test_output
TEST_PROG_04 = test_add_assign
TEST_PROG_05 = test_add
TEST_PROG_06 = test_preinc
TEST_PROG_07 = test_postinc
TEST_PROG_08 = testp_times_10
TEST_PROG_09 = testp_times_single_digit
TEST_PROG_10 = test_mult_assign
TEST_PROG_11 = test_mult
TEST_PROG_12 = test_input
TEST_PROG_13 = test_size
TEST_PROG_14 = test_subscript

#===========================================================================
msg:
	@${ECHO} 'Targets for running (and compiling) tests are:'
	@${ECHO} '   t1  or ${TEST_PROG_01}'
	@${ECHO} '   t2  or ${TEST_PROG_02}'
	@${ECHO} '   t3  or ${TEST_PROG_03}'
	@${ECHO} '   t4  or ${TEST_PROG_04}'
	@${ECHO} '   t5  or ${TEST_PROG_05}'
	@${ECHO} '   t6  or ${TEST_PROG_06}'
	@${ECHO} '   t7  or ${TEST_PROG_07}'
	@${ECHO} '   t8  or ${TEST_PROG_08}'
	@${ECHO} '   t9  or ${TEST_PROG_09}'
	@${ECHO} '   t10 or ${TEST_PROG_10}'
	@${ECHO} '   t11 or ${TEST_PROG_11}'
	@${ECHO} '   t12 or ${TEST_PROG_12}'
	@${ECHO} '   t13 or ${TEST_PROG_13}'
	@${ECHO} '   t14 or ${TEST_PROG_14}'
	@${ECHO} '   tests  - runs t1, t2, ...'
	@${ECHO} 'Note: each test depends on the previous tests.'
	@${ECHO} 'Targets for compiling individual test programs:'
	@${ECHO} '   p1, p2, etc.'
	@${ECHO} 'Other Targets:'
	@${ECHO} '   driver (driver.cpp in the current directory)'
	@${ECHO} '   clean'
	@${ECHO} 'Note: To have make ignore errors use the options "-ik", ex:'
	@${ECHO} '   make -ik t6'

#===========================================================================
# Compile bigint.o

bigint.o:	bigint.h  bigint.cpp
	${GXX} ${COMPILE_OPT} -c bigint.cpp ${COMPILER_OUT_2}

err: COMPILER_OUTFILE = compiler_output.txt
err: COMPILER_OUT_1 = >& ${COMPILER_OUTFILE}
err: COMPILER_OUT_2 = >> ${COMPILER_OUTFILE} 2>&1
err: compiler_note bigint.o
	@${ECHO} ''

#===========================================================================
# Compile local driver file
driver.o:	bigint.h  driver.cpp
	${GXX} ${COMPILE_OPT} ${DEF} ${INCLUDE_OPT} -c driver.cpp

driver:	driver.o  bigint.o
	${GXX} ${COMPILE_OPT} ${DEF} ${INCLUDE_OPT}  -Dprivate=public driver.o bigint.o -o driver

#===========================================================================
# Compile local factorial file
factorial.o:	bigint.h  factorial.cpp
	${GXX} ${COMPILE_OPT} ${DEF} ${INCLUDE_OPT} -c factorial.cpp

factorial:	factorial.o  bigint.o
	${GXX} ${COMPILE_OPT} ${DEF} ${INCLUDE_OPT}  factorial.o bigint.o -o factorial

#===========================================================================
# Compile test programs

#----------------------------------------------------------------------------
test_%: bigint.o test_%.o
	${GXX} bigint.o test_$*.o -o test_$*  ${COMPILER_OUT_2}

test_%.o:	bigint.h  ${TEST_PROG_DIR}test_%.cpp
	${GXX} ${COMPILE_OPT} ${DEF} ${INCLUDE_OPT} -c ${TEST_PROG_DIR}test_$*.cpp  ${COMPILER_OUT_2}

testp_%: bigint.o testp_%.o
	${GXX} bigint.o testp_$*.o -o testp_$* ${COMPILER_OUT_2}

testp_%.o:	bigint.h  ${TEST_PROG_DIR}testp_%.cpp
	${GXX} ${COMPILE_OPT} ${DEF} ${INCLUDE_OPT} -Dprivate=public -c ${TEST_PROG_DIR}testp_$*.cpp  ${COMPILER_OUT_2}

#===========================================================================
.PRECIOUS: test_%.o  testp_%.o driver%.o

#===========================================================================
# Compile test programs

p1:  ${TEST_PROG_01}
p2:  ${TEST_PROG_02} p1
p3:  ${TEST_PROG_03} p2
p4:  ${TEST_PROG_04} p3
p5:  ${TEST_PROG_05} p4
p6:  ${TEST_PROG_06} p5
p7:  ${TEST_PROG_07} p6
p8:  ${TEST_PROG_08} p7
p9:  ${TEST_PROG_09} p8
p10: ${TEST_PROG_10} p9
p11: ${TEST_PROG_11} p10
p12: ${TEST_PROG_12} p11
p13: ${TEST_PROG_13} p12
p14: ${TEST_PROG_14} p13

progs: COMPILER_OUTFILE = compiler_output.txt
progs: COMPILER_OUT_1 = >& ${COMPILER_OUTFILE}
progs: COMPILER_OUT_2 = >> ${COMPILER_OUTFILE} 2>&1
progs: compiler_note p14
	@${ECHO} '-----------------------------------------------------------------' ${COMPILER_OUT_2}
	@${ECHO} 'Done compiling.'

compiler_note:
	@${ECHO} 'Any output from the compiler is between the dashed lines.'         ${COMPILER_OUT_1}
	@${ECHO} 'There should not be any output from the compiler.'                 ${COMPILER_OUT_2}
	@${ECHO} 'Warnings should not be ignored, they indicate potential problems.' ${COMPILER_OUT_2}
	@${ECHO} '-----------------------------------------------------------------' ${COMPILER_OUT_2}

testprogs:  p14
	@${ECHO} "Test programs done compiling."

#===========================================================================
# Run test programs

tests: t14
	@${ECHO} "Test programs done running."

t0: 
	@${ECHO} "Test programs running ..."

t1: ${TEST_PROG_01}
	./${TEST_PROG_01}      ${PROG_OUT_2}

t2: t1 ${TEST_PROG_02}
	./${TEST_PROG_02}      ${PROG_OUT_2}

t3: t2 ${TEST_PROG_03}
	./${TEST_PROG_03}      ${PROG_OUT_2}

t4: t3 ${TEST_PROG_04}
	./${TEST_PROG_04}      ${PROG_OUT_2}

t5: t4 ${TEST_PROG_05}
	./${TEST_PROG_05}      ${PROG_OUT_2}

t6: t5 ${TEST_PROG_06}
	./${TEST_PROG_06}      ${PROG_OUT_2}

t7: t6 ${TEST_PROG_07}
	./${TEST_PROG_07}      ${PROG_OUT_2}

t8: t7 ${TEST_PROG_08}
	./${TEST_PROG_08}      ${PROG_OUT_2}

t9: t8 ${TEST_PROG_09}
	./${TEST_PROG_09}      ${PROG_OUT_2}

t10: t9 ${TEST_PROG_10}
	./${TEST_PROG_10}      ${PROG_OUT_2}

t11: t10 ${TEST_PROG_11}
	./${TEST_PROG_11}      ${PROG_OUT_2}

t12: t11 ${TEST_PROG_12}
	./${TEST_PROG_12}      ${PROG_OUT_2}

t13: t12 ${TEST_PROG_13}
	./${TEST_PROG_13}      ${PROG_OUT_2}

t14: t13 ${TEST_PROG_14}
	./${TEST_PROG_14}      ${PROG_OUT_2}

#===========================================================================
# Run, output to a file

runo: PROGRAM_OUTFILE  = program_output.txt
runo: PROG_OUT_1 = >& ${PROGRAM_OUTFILE}
runo: PROG_OUT_2 = >> ${PROGRAM_OUTFILE} 2>&1
runo: run
	@${ECHO} ''

run: runmsg t14
	@${ECHO} ''

runmsg:
	@${ECHO} '===============================================================' ${PROG_OUT_1}
	@${ECHO} Program: BigInt                                                   ${PROG_OUT_2}
	@${ECHO} '---------------------------------------------------------------' ${PROG_OUT_2}
	@${ECHO} 'This file contains the output from running your programs.'       ${PROG_OUT_2}
	@${ECHO} 'There will be an error message if a program did not compile.'    ${PROG_OUT_2}
	@${ECHO} 'There will not be any output from tests that pass.'              ${PROG_OUT_2}
	@${ECHO} '---------------------------------------------------------------' ${PROG_OUT_2}
	@${ECHO} ''                                                                ${PROG_OUT_2}

#============================================================================
clean:
	rm -f test_*
	rm -f testp_*
	rm -f driver
	rm -f factorial
	rm -f *.o a.out
	rm -f core*

veryclean: clean
	rm -f *out.txt
	rm -f $(PROGRAM_OUTFILE)
	rm -f $(COMPILER_OUTFILE)

