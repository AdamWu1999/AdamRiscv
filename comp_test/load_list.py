import sys
MC_MACRO=int(sys.argv[1])

path = "../module/CORE/RTL_V1_2/"

if(MC_MACRO==0):
    sram_define = ""
    sram_lib_path= "../libs/REG_ARRAY/SRAM/ram_bfm.v "
else:
    sram_define = "+define+MC_MACRO=1\n"
    sram_lib_path= "../libs/MC_MACRO/DP_SRAM/SRAM_4096_32.v "
sram_lib = "+libext+ " + sram_lib_path + "\n"
inc_def = "+incdir+" + path + "\n"

with open("../module/CORE/RTL_V1_2/file_list","r") as src_list:
    with open("./module_list","w") as new_list:
        line = src_list.readline()
        while line:
            w_line = path + line.strip()+ "\n"
            line = src_list.readline()
            new_list.write(w_line)
        new_list.write(sram_define)
        new_list.write(sram_lib)
        new_list.write(inc_def)