`include "define.v"
module imm_gen (
    input wire[31:0]  inst,
    output wire[31:0] imm_o
);
assign imm_o = (inst[6:2] == `ItypeL || inst[6:2] == `ItypeA || inst[6:2] == `ItypeJ )? {{20{inst[31]}},inst[31:20]} :
               (inst[6:2] == `Stype)? {{20{inst[31]}},inst[31:25],inst[11:7]} :
               (inst[6:2] == `Btype)? {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0} :
               (inst[6:2] == `UtypeL || inst[6:2] == `UtypeU)? {inst[31:12],12'b0} :
               (inst[6:2] == `Jtype)? {{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0}:0;





endmodule