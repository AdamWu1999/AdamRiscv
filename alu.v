`include "define.v"

module alu(
    input  wire[3:0]     alu_ctrl,
    input  wire[31:0]    op_A,
    input  wire[31:0]    op_B,
    output reg[31:0]     alu_o,
    output wire          br_mark     
);

assign br_mark = (alu_ctrl == `JUMP)? 1 :
                 (alu_ctrl == `NOTEQ || alu_ctrl == `SLT || alu_ctrl == `SLTU)?
                 (alu_o != 0) : (alu_o == 0);
 
always @(alu_ctrl, op_A, op_B) begin
    case (alu_ctrl)
        `AND        : alu_o = op_A & op_B;           
        `OR         : alu_o = op_A | op_B;           
        `ADD,`JUMP  : alu_o = op_A + op_B;           
        `SUB,`NOTEQ : alu_o = op_A - op_B;           
        `XOR        : alu_o = op_A ^ op_B;           
        `SLT,`SGE   : alu_o = ($signed(op_A)) < ($signed(op_B)) ? 32'b1 : 32'b0;   
        `SLTU,`SGEU : alu_o = op_A < op_B ? 32'b1 : 32'b0;   
        `SLL        : alu_o = op_A << op_B[4:0];
        `SRL        : alu_o = op_A >> op_B[4:0];
        `SRA        : alu_o = ($signed(op_A)) >>> op_B[4:0];
        default: alu_o = 0;
    endcase
end

endmodule