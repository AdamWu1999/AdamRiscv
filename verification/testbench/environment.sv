
`define TB  tbtop
`define TB_IRAM `TB.u_adam_riscv.u_stage_if.u_inst_memory.u_ram_data
`define TB_DRAM `TB.u_adam_riscv.u_stage_mem.u_data_memory.u_ram_data

`define RAM_DEEP            4096
// Declare PAD
//------------------------------------------------------------------------------------------------
//wire        sys_clk         ;
//wire        sys_rst_n       ;

//------------------------------------------------------------------------------------------------
// Gen clock & reset
//------------------------------------------------------------------------------------------------
reg     d_sys_clk   ;
reg     d_sys_rst_n ;

initial begin
    d_sys_clk    = 0;      
    d_sys_rst_n  = 0;
    #100ns;
    d_sys_rst_n = 1;
end

always #20ns  d_sys_clk= ! d_sys_clk;

assign sys_clk   = d_sys_clk   ;
assign sys_rst_n = d_sys_rst_n ;

//------------------------------------------------------------------------------------------------
// coverage
//------------------------------------------------------------------------------------------------

initial begin
    $vcdpluson;
end

//------------------------------------------------------------------------------------------------
// Gen FSDB
//------------------------------------------------------------------------------------------------

initial	begin
	    $fsdbDumpfile("tb.fsdb");//这个是产生名为tb.fsdb的文件
	    $fsdbDumpvars(0,tbtop);
        $fsdbDumpMDA();
end


//------------------------------------------------------------------------------------------------
// Initial Instruction RAM
//------------------------------------------------------------------------------------------------



reg [7:0] imem [0:(`RAM_DEEP*8)-1];

initial begin :Init_IRAM
    for (int i=0;i<(`RAM_DEEP*8);i=i+1) begin
        imem[i] = 32'd0;
    end
    //$readmemh( "main.verilog", imem);
    $readmemh( "main_s.verilog", imem);
    for (int i=0;i<(`RAM_DEEP);i=i+1) begin
        `TB_IRAM.mem[i][00+7:00] = imem[i*4+0];
        `TB_IRAM.mem[i][08+7:08] = imem[i*4+1];
        `TB_IRAM.mem[i][16+7:16] = imem[i*4+2];
        `TB_IRAM.mem[i][24+7:24] = imem[i*4+3];
    end
        $display("\n");
        $display("*\tIDATA: 0x00: %h", `TB_IRAM.mem[8'h00]);
        $display("*\tIDATA: 0x04: %h", `TB_IRAM.mem[8'h01]);
        $display("*\tIDATA: 0x08: %h", `TB_IRAM.mem[8'h02]);
        $display("*\tIDATA: 0x0C: %h", `TB_IRAM.mem[8'h03]);
        $display("*\tIDATA: 0x10: %h", `TB_IRAM.mem[8'h04]);
        $display("*\tIDATA: 0x14: %h", `TB_IRAM.mem[8'h05]);
        $display("*\tIDATA: 0x18: %h", `TB_IRAM.mem[8'h06]);
        $display("*\tIDATA: 0x1C: %h", `TB_IRAM.mem[8'h07]);
        $display("*\tIDATA: 0x20: %h", `TB_IRAM.mem[8'h08]);
        $display("*\tIDATA: 0x24: %h", `TB_IRAM.mem[8'h09]);
        $display("*\tIDATA: 0x28: %h", `TB_IRAM.mem[8'h0A]);
        $display("*\tIDATA: 0x2C: %h", `TB_IRAM.mem[8'h0B]);
end
//initial begin :Init_DRAM
//    for (int i=0;i<(`RAM_DEEP);i=i+1) begin
//      `TB_DRAM.ram[i] = 32'd0;
//    end
//end


