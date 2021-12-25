module stage_wb(
    input  wire[31:0]  wb_mem_data,
    input  wire[31:0]  wb_alu_o,
    input  wire        wb_mem2reg,
    output wire[31:0]  w_regs_data
);

assign w_regs_data = wb_mem2reg ? wb_mem_data : wb_alu_o;

endmodule