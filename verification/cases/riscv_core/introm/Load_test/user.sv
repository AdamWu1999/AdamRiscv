
wire ram_clk = tbtop.u_adam_riscv.u_stage_mem.u_data_memory.u_ram_data.clk;
wire reg_clk = tbtop.u_adam_riscv.u_stage_id.u_regs.clk;
wire ram_cs = tbtop.u_adam_riscv.u_stage_mem.u_data_memory.u_ram_data.cs;
wire reg_en = tbtop.u_adam_riscv.u_stage_id.u_regs.w_regs_en;
reg ram_cs_dly1 ;
reg reg_en_dly1 ;
always @(posedge ram_clk) begin
    ram_cs_dly1 <= ram_cs;
    reg_en_dly1 <= reg_en;
end


initial begin
    #1ns;
    @(posedge ram_cs_dly1 );
    #5ns;
    //while(1)begin
        #1ns;

            DRAM_DATA_CHECK(10'd0,32'h00ff_f014);
            DRAM_DATA_CHECK(10'd1,32'h00ff_f014);
            DRAM_DATA_CHECK(10'd2,32'h00ff_f014);
            DRAM_DATA_CHECK(10'd3,32'h00ff_f014);
            DRAM_DATA_CHECK(10'd4,32'h00ff_f014);

            DRAM_DATA_CHECK(10'd0,32'h00ff_1414);
            DRAM_DATA_CHECK(10'd1,32'h0014_f014);
            DRAM_DATA_CHECK(10'd2,32'h14FF_f014);
            DRAM_DATA_CHECK(10'd3,32'h00ff_f014);
            DRAM_DATA_CHECK(10'd4,32'hf014_f014);
    @(posedge reg_en_dly1 );
            REGFILE_CHECK(6'd6,32'h00ff_1414);
            REGFILE_CHECK(6'd7,32'hffff_f014);
            REGFILE_CHECK(6'd8,32'hffff_ffff);
            REGFILE_CHECK(6'd9,32'h0000_f014);
            REGFILE_CHECK(6'd10,32'h0000_00ff);
    #10us;
    TEST_PASS;
end

task DRAM_DATA_CHECK;
    input   [9:0]   addr    ;
    input   [31:0]  edata   ;

    logic   [31:0]  ram_data;

    @(posedge ram_clk );
    if(ram_cs_dly1) begin
        ram_data = `TB_DRAM.mem[addr];
        if(ram_data !== edata) begin
            $display("* RAM_DATA[%x]: %x | EXP_DATA: %x => Error!!!",addr,ram_data, edata);
            #1us;
            TEST_FAIL;
        end
        $display("* RAM_DATA[%x]: %x | EXP_DATA: %x => OK!!!",addr, ram_data, edata);
    end
    else begin
            $display("* DRAM CS is High => Error!!!");
            TEST_FAIL;
    end
endtask

task REGFILE_CHECK;
    input   [4:0]   addr    ;
    input   [31:0]  edata   ;

    logic   [31:0]  reg_data;

    @(posedge reg_clk);
    if(reg_en_dly1)begin
        reg_data = tbtop.u_adam_riscv.u_stage_id.u_regs.reg_bank[addr];
        if(reg_data !== edata) begin
            $display("* REG_DATA[%x]: %x | EXP_DATA: %x => Error!!!",addr,reg_data, edata);
            #1us;
            TEST_FAIL;
        end
        $display("* REG_DATA[%x]: %x | EXP_DATA: %x => OK!!!",addr, reg_data, edata);
    end
    else begin
            $display("* REG WR EN is High => Error!!!");
            TEST_FAIL;
    end

endtask

initial begin
    #100us;
    $display("\n----------------------------------------\n");
    $display("\t Timeout Error !!!!\n");
    TEST_FAIL;
end

