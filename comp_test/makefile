
PROG_NAME = test2.S
ROM_PATH = ../rom
MC_MACRO = 0
CM = -cm line+tgl+cond+branch
CM_NAME = -cm_name simv
CM_DIR = -cm_dir ./cov_file/simv.vdb

COMP: MODULE_LIST PROGRAM_HEX GEN_TB
	vcs -f module_list tb.sv -top tb -o tb.simv -timescale=1ns/1ns -full64 +v2k -sverilog -l vcomp.log -kdb -lca -debug_acc+all -debug_region+cell+encrypt \
	${CM} ${CM_NAME} ${CM_DIR}

RUNV:
	./tb.simv -verdi -l run.log 

RUN:
	./tb.simv -l run.log ${CM} ${CM_NAME} ${CM_DIR}

COV:
	verdi -cov -covdir ./cov_file/simv.vdb

MODULE_LIST:
	python3 ./load_list.py ${MC_MACRO}

PROGRAM_HEX:
	${ROM_PATH}/gen_hex.sh ${PROG_NAME} ${ROM_PATH}

GEN_TB:
	python3 ./GoldenToTb.py

clean:
	rm -rf csrc *.simv.daidir *.simv  *.log ucli.key
	rm -rf *.fsdb verdiLog 
	rm -rf module_list test_content.sv
	rm -rf ../rom/main*


