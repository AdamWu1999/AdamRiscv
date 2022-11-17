import re
tb_content_path = "./test_content.sv"
golden_path = "../rom/golden.txt"

reg_pattern = re.compile(r"(.*reg\s*)(x)(\d*)(\s*=\s*)(\w*)")
mem_pattern = re.compile(r"(.*)(mem)(\s*)(\w*)(\s*=\s*)(\w*)")

tb_template = r'''
integer pass;

initial begin
    #10us;
    pass = 1//test_content here;
    if (pass)
    TEST_PASS;
    else
    TEST_FAIL;

end

//Timeout Error
initial begin
    #100us;
    $display("\n----------------------------------------\n");
    $display("\t Timeout Error !!!!\n");
    TEST_FAIL;
end
'''

tb_content      = ""
tb_content_line = ""

with open(golden_path,"r",encoding='UTF-8') as gd_handler:
    gd_lines = gd_handler.readlines()
    for i in gd_lines:
        if (i[0] == "#"):
            continue
        else:
            reg_temp = reg_pattern.match(i)
            mem_temp = mem_pattern.match(i)
            if ((mem_temp == None) and (reg_temp != None)):
                if reg_temp.group(5)[0:2] == "0x":
                    value = reg_temp.group(5)[2:]
                else:
                    value = reg_temp.group(5)
                tb_content_line = "&&(`TB_REGS.reg_bank[{reg}] === 32'h{value})\n" .format(reg = reg_temp.group(3), value = value)
                tb_content = tb_content + tb_content_line
                #print(reg_temp.group(2),reg_temp.group(3),": \n",reg_temp.group(5))
            if ((mem_temp != None) and (reg_temp == None)):
                mem_addr = int(mem_temp.group(4),16)
                mem_value = mem_temp.group(6)[2:]
                if (mem_addr % 4 != 0) :
                    print("mem_addr error!")
                    break
                else:
                    mem_addr = mem_addr//4
                    tb_content_line = "&&(`TB_DRAM.mem[{addr}] === 32'h{value})\n" .format(addr = mem_addr, value = mem_value)
                    tb_content = tb_content + tb_content_line
                #print(mem_temp.group(4),",dec:",int(mem_temp.group(4),16))
                #print(mem_temp.group(6))

print(tb_content)
tb_template = tb_template.replace("//test_content here",tb_content)

with open (tb_content_path, "w") as tb_handler:
    tb_handler.write(tb_template)