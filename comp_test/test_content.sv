
integer pass;

initial begin
    #10us;
    pass = 1&&(`TB_REGS.reg_bank[0] === 32'h0)
&&(`TB_REGS.reg_bank[1] === 32'h210)
&&(`TB_REGS.reg_bank[2] === 32'h231)
&&(`TB_REGS.reg_bank[3] === 32'h462)
&&(`TB_REGS.reg_bank[4] === 32'h460)
&&(`TB_REGS.reg_bank[5] === 32'h343)
&&(`TB_REGS.reg_bank[6] === 32'h7a3)
&&(`TB_REGS.reg_bank[7] === 32'h1)
&&(`TB_REGS.reg_bank[8] === 32'h1)
&&(`TB_REGS.reg_bank[9] === 32'h460)
&&(`TB_REGS.reg_bank[10] === 32'h45b27000)
&&(`TB_REGS.reg_bank[11] === 32'h21c43064)
&&(`TB_REGS.reg_bank[12] === 32'h3ff)
&&(`TB_REGS.reg_bank[13] === 32'h123)
&&(`TB_REGS.reg_bank[14] === 32'h64ef)
&&(`TB_REGS.reg_bank[15] === 32'h034364ef)
&&(`TB_REGS.reg_bank[16] === 32'h21c43064)
&&(`TB_REGS.reg_bank[17] === 32'h034364f1)
&&(`TB_REGS.reg_bank[18] === 32'h80)
&&(`TB_REGS.reg_bank[19] === 32'hfffff001)
&&(`TB_REGS.reg_bank[20] === 32'hffffffef)
&&(`TB_REGS.reg_bank[21] === 32'h7)
&&(`TB_REGS.reg_bank[22] === 32'hef)
&&(`TB_REGS.reg_bank[23] === 32'hffef)
&&(`TB_REGS.reg_bank[24] === 32'h1)
&&(`TB_REGS.reg_bank[25] === 32'hfffffffd)
&&(`TB_DRAM.mem[0] === 32'hXXXXffef)
&&(`TB_DRAM.mem[25] === 32'h5ef)
&&(`TB_DRAM.mem[74] === 32'h21c43064)
&&(`TB_DRAM.mem[73] === 32'h034364ef)
&&(`TB_DRAM.mem[256] === 32'hXXXX0007)
;
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
