
initial begin
    #10ns;
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[1] == 32'h40000);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[2] == 32'h40000);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[3] == 32'h50000);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[4] == 32'h00000);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[5] == 32'h70000);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[6] == 32'h80000);
    TEST_PASS;

end

initial begin
    #100us;
    $display("\n----------------------------------------\n");
    $display("\t Timeout Error !!!!\n");
    TEST_FAIL;
end

