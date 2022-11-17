
initial begin
    #10ns;
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[1] == 32'hFFFF_F000);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[2] == 32'hFF);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[3] == 32'hFFF);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[4] == 32'hFFFF_FFFF);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[5] == 32'hFF_F014);

    TEST_PASS;

end

initial begin
    #100us;
    $display("\n----------------------------------------\n");
    $display("\t Timeout Error !!!!\n");
    TEST_FAIL;
end

