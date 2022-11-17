module reg_mem_wb(
    input  wire clk,
    input  wire rstn,
    input  wire[31:0] me_mem_data,
    input  wire[31:0] me_alu_o,
    input  wire[4:0]  me_rd,
    input  wire       me_mem2reg,
    input  wire       me_regs_write,
    input  wire[2:0]  me_func3_code,
    output reg[2:0]   wb_func3_code,
    output reg[31:0]  wb_mem_data,
    output reg[31:0]  wb_alu_o,
    output reg[4:0]   wb_rd,
    output reg        wb_mem2reg,
    output reg        wb_regs_write
);

always @(posedge clk or negedge rstn) begin
    if (!rstn)begin
//        wb_mem_data    <= 0;     
        wb_alu_o       <= 0;     
        wb_rd          <= 0; 
        wb_mem2reg     <= 0;     
        wb_regs_write  <= 0; 
        wb_func3_code  <= 0;            
    end 
    else begin
//        wb_mem_data    <= me_mem_data;     
        wb_alu_o       <= me_alu_o;     
        wb_rd          <= me_rd; 
        wb_mem2reg     <= me_mem2reg;     
        wb_regs_write  <= me_regs_write;   
        wb_func3_code  <= me_func3_code;
    end
    $display("wb_alu_o     : %h",wb_alu_o);
    $display("wb_mem2reg   : %h",wb_mem2reg);
    $display("wb_regs_write: %h",wb_regs_write);
    $display("-----------------------");
end

always @(*) begin
    wb_mem_data = me_mem_data; //offset the 1-cycle delay caused by syn_RAM
    $display("wb_mem_data  : %h",wb_mem_data);
end

endmodule