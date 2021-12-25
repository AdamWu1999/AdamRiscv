`include "define.v"

module forwarding(
    input wire[4:0]   ex_rs1,
    input wire[4:0]   ex_rs2,
    input wire[4:0]   me_rd,
    input wire[4:0]   wb_rd,
    input wire[4:0]   me_rs2,
    input wire        me_mem_write,
    input wire        me_regs_write,
    input wire        wb_regs_write,
    //forwarding for alu_operatant
    output wire[1:0]  forwardA,
    output wire[1:0]  forwardB,
    //forwarding for data_memory write_data
    output wire       forward_data
);

// alu_operatant forwarding
wire ex_hazard_a;
wire ex_hazard_b;
wire mem_hazard_a;
wire mem_hazard_b;
//data_memory write_data forwarding for store
wire hazard_data_w;

assign ex_hazard_a   = me_regs_write & (me_rd != 0) & (me_rd == ex_rs1); //me_rd != 0 : don't forward the result when rd is x0
assign ex_hazard_b   = me_regs_write & (me_rd != 0) & (me_rd == ex_rs2);
assign mem_hazard_a  = wb_regs_write & (wb_rd != 0) & (wb_rd == ex_rs1); 
assign mem_hazard_b  = wb_regs_write & (wb_rd != 0) & (wb_rd == ex_rs2);
assign hazard_data_w = wb_regs_write & (wb_rd != 0) & (wb_rd == me_rs2) & me_mem_write; //for store

assign forwardA     = ex_hazard_a ? `EX_MEM_A : mem_hazard_a ? `MEM_WB_A : `ID_EX_A;
assign forwardB     = ex_hazard_b ? `EX_MEM_B : mem_hazard_b ? `MEM_WB_B : `ID_EX_B;
assign forward_data = hazard_data_w ? 1 : 0;

endmodule