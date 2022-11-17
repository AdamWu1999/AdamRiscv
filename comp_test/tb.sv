`timescale 1ns/1ns
`define TB_IROM tb.u_adam_riscv.u_stage_if.u_inst_memory.u_ram_data
`define TB_REGS tb.u_adam_riscv.u_stage_id.u_regs
`define TB_DRAM tb.u_adam_riscv.u_stage_mem.u_data_memory.u_ram_data
`define RAM_DEEP 4096


module tb;

reg clk;
reg rst;
always begin
#25    clk = ~clk;
end

reg [31:0] imem [0:4095];
integer i,j;

adam_riscv u_adam_riscv(
    .sys_clk  (clk ),
    .sys_rstn (rst )
);

//------------------------------------------------------------------------------------------------
// Gen FSDB
//------------------------------------------------------------------------------------------------

initial	begin
	    $fsdbDumpfile("tb.fsdb");//这个是产生名为tb.fsdb的文件
	    $fsdbDumpvars(0,tb);
        $fsdbDumpMDA();
end


//------------------------------------------------------------------------------------------------
// initial Instruction ROM
//------------------------------------------------------------------------------------------------
initial begin
    for (i=0;i<(`RAM_DEEP*8);i=i+1) begin
    imem[i] = 32'd0;
    end
    $readmemh("../rom/main_s.verilog",imem);
    for (i=0;i<(`RAM_DEEP);i=i+1) begin
        `TB_IROM.mem[i][00+7:00] = imem[i*4+0];
        `TB_IROM.mem[i][08+7:08] = imem[i*4+1];
        `TB_IROM.mem[i][16+7:16] = imem[i*4+2];
        `TB_IROM.mem[i][24+7:24] = imem[i*4+3];
    end
end

initial begin
    $display ($time, "<<Starting simulation>>");
    for(j=0; j<200; j=j+1)
        $display("%d: %h", j, `TB_IROM.mem[j]);
    clk = 1'b1;
    rst = 1'b0;
    #100 rst = 1'b1;

end

//---------------------------------------------------------------------------------------------
// TEST CONTENT
//---------------------------------------------------------------------------------------------
`include "test_content.sv"

//---------------------------------------------------------------------------------------------
// show test result
//---------------------------------------------------------------------------------------------
task    TEST_PASS;
    $display("==================================================================");
    $display("==================================================================");
    $display("=========                                              ===========");
    $display("=========   PPPPPPPP       A        SSSSS    SSSSS     ===========");
    $display("=========    P      P     A A      S     S  S     S    ===========");
    $display("=========    P      P    A   A     S        S          ===========");
    $display("=========    PPPPPP     AAAAAAA     SSSSS    SSSSS     ===========");
    $display("=========    P         A       A         S        S    ===========");
    $display("=========    P        A         A        S        S    ===========");
    $display("=========    P       A           A  SSSSS    SSSSS     ===========");
    $display("==================================================================");
    $display("========= This case is pass !!! %d",$time);
    $display("==================================================================");
    
    $finish;
endtask


task    TEST_FAIL;

    $display("==================================================================");
    $display("==================================================================");
    $display("=========                                             ============");
    $display("=========     FFFFFFF       A         III   L         ============");
    $display("=========     F            A A         I    L         ============");
    $display("=========     F           A   A        I    L         ============");
    $display("=========     FFFFFFF    AAAAAAA       I    L         ============");
    $display("=========     F         A       A      I    L         ============");
    $display("=========     F        A         A     I    L         ============");
    $display("=========     F       A           A   III   LLLLLLL   ============");
    $display("==================================================================");
    $display("========= This case is failed !!! %d",$time);
    $display("==================================================================");
    
    $finish;
endtask


endmodule