
initial begin
    #10ns;
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[1] == 32'hFFFF_8000);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[2] == 32'ha000);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[3] == 32'h2000);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[2] == 32'ha);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[3] == 32'h2);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[4] == 32'h8);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[5] == 32'h20);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[6] == 32'h1);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[7] == 32'h0);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[8] == 32'ha);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[9] == 32'h2);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[10] == 32'h2);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[11] == 32'h2);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[12] == 32'h1);
    wait(tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[13] == 32'hc);
    TEST_PASS;

end

initial begin
    #100us;
    $display("\n----------------------------------------\n");
    $display("\t Timeout Error !!!!\n");
    TEST_FAIL;
end

