`include "define.v"

module forwarding(
    input wire[4:0]   ex_rs1, 
    input wire[4:0]   ex_rs2,
    input wire[4:0]   me_rd,
    input wire[4:0]   wb_rd,
    input wire[4:0]   me_rs2,
    input wire        me_mem_write,
    input wire        wb_mem2reg, 
    input wire        me_regs_write,
    input wire        wb_regs_write,
    //forwarding for alu_opwb_mem2regeratant
    output wire[1:0]  forwardA,
    output wire[1:0]  forwardB,
    //forwarding for data_memory write_data
    output wire       forward_data
);

// alu_operatant forwarding (at ex_stage)
//detect the data correlation between rs at the beginning of ex_stage and rd at the beginning of mem_stage
wire ex_hazard_a; 
wire ex_hazard_b;
//detect the data correlation between rs at the beginning of ex_stage and rd at the beginning of wb_stage
wire mem_hazard_a;
wire mem_hazard_b;
//detect the data correlation between load + store(especially for memory data copy, that store data to mem from where the load_inst has just writed in)
wire hazard_data_mem;

assign ex_hazard_a   = me_regs_write && (me_rd != 0) && (me_rd == ex_rs1); //me_rd != 0 : don't forward the result when rd is x0
assign ex_hazard_b   = me_regs_write && (me_rd != 0) && (me_rd == ex_rs2);
assign mem_hazard_a  = wb_regs_write && (wb_rd != 0) && (wb_rd == ex_rs1); 
assign mem_hazard_b  = wb_regs_write && (wb_rd != 0) && (wb_rd == ex_rs2);
assign hazard_data_mem = wb_mem2reg && me_mem_write && (wb_rd != 0) && (wb_rd == me_rs2) ; //for load+store: detect L inst is in wb_stage and S inst is in Mem_stage

assign forwardA     = ex_hazard_a ? `EX_MEM_A : mem_hazard_a ? `MEM_WB_A : `ID_EX_A;
assign forwardB     = ex_hazard_b ? `EX_MEM_B : mem_hazard_b ? `MEM_WB_B : `ID_EX_B;
assign forward_data = hazard_data_mem ? 1 : 0;

always @(*) begin
    if (forwardA)
        $display("forwardA! ex_hazard: %b, mem_hazard: %b",ex_hazard_a,mem_hazard_a);
    else if (forwardB)
        $display("forwardB! ex_hazard: %b, mem_hazard: %b",ex_hazard_b,mem_hazard_b);
    else if (forward_data)
        $display("forward4store! hazard_data: %b",hazard_data_mem);
end

endmodule