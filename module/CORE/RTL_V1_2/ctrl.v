`include "define.v"
module ctrl(   
    input  wire[6:0]    inst_op,
    output wire         br,
    output wire         mem_read,
    output wire         mem2reg,
    output wire[2:0]    alu_op,
    output wire         mem_write,
    output wire[1:0]    alu_src1,
    output wire[1:0]    alu_src2,
    output wire         br_addr_mode,
    output wire         regs_write
);

assign alu_op = (inst_op == `ItypeL || inst_op == `Stype || inst_op == `UtypeL || inst_op == `UtypeU)? 3'b000 :
                (inst_op == `Btype)? 3'b001:
                (inst_op == `Rtype)? 3'b010:
                (inst_op == `ItypeA) ? 3'b011:
                (inst_op == `ItypeJ || inst_op == `Jtype)? 3'b100 : 3'b111;

assign alu_src1 = (inst_op == `ItypeJ || inst_op == `Jtype || inst_op == `UtypeU) ? `PC : 
                  (inst_op == `UtypeL) ? `NULL : `REG;
assign alu_src2 = (inst_op == `ItypeL || inst_op == `Stype || inst_op == `UtypeU || inst_op == `ItypeA || inst_op == `UtypeL)? `IMM :
                  (inst_op == `ItypeJ || inst_op == `Jtype) ? `PC_PLUS4 : `REG;
assign br_addr_mode = (inst_op == `ItypeJ)? `J_REG : `B_PC;


assign br = (inst_op == `Btype || inst_op == `ItypeJ || inst_op == `Jtype)? 1:0;
assign mem_write = ( inst_op == `Stype)? 1:0; //for store, memory write_en
assign mem_read = ( inst_op == `ItypeL)? 1:0; //for load, memory load_en
assign regs_write = (inst_op == `ItypeL || inst_op == `Rtype || inst_op == `UtypeU || inst_op == `ItypeA || inst_op == `ItypeJ || inst_op == `UtypeL || inst_op == `Jtype)? 1:0;//for the inst that writes back the regs
//assign regs_write = (inst_op == `Stype || inst_op == `Btype)? 0:1;     // when the inst is beyond the definition ,like 0x00000000, reg_write is 0  
assign mem2reg = (regs_write && inst_op == `ItypeL)?1:0; //for load, detect the data from whether memory or alu at wb_stage


endmodule