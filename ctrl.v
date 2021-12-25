`include "define.v"
module ctrl(   
    input  wire[4:0]    inst_op,
    output wire         br,
    output wire         mem_read,
    output wire         mem2reg,
    output wire[2:0]    alu_op,
    output wire         mem_write,
    output wire         alu_src,
    output wire         regs_write
);

assign alu_op = (inst_op == `ItypeL | inst_op == `Stype | inst_op == `UtypeU)? 3'b000 :
                (inst_op == `Btype)? 3'b001:
                (inst_op == `Rtype)? 3'b010:
                (inst_op == `ItypeA | inst_op == `ItypeJ)? 3'b011: 3'b100;

assign alu_src = (inst_op == `ItypeL | inst_op == `Stype | inst_op == `UtypeU | inst_op == `ItypeA | inst_op == `ItypeJ)? 1:0;
assign br = (inst_op == `Btype | inst_op == `ItypeJ | inst_op == `Jtype)? 1:0;
assign mem_write = ( inst_op == `Stype)? 1:0;
assign mem_read = ( inst_op == `ItypeL)? 1:0;
assign regs_write = (inst_op == `Stype | inst_op == `Btype)? 0:1;
assign mem2reg = (regs_write == 1 | inst_op == `ItypeL)?1:0;


endmodule