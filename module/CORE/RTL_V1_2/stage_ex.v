`include "define.v"

module stage_ex(
    input  wire[31:0]  ex_pc,  //pc_now
    input  wire[31:0]  ex_regs_data1,
    input  wire[31:0]  ex_regs_data2,
    input  wire[31:0]  ex_imm,
    input  wire[2:0]   ex_func3_code, 
    input  wire        ex_func7_code,
    input  wire[2:0]   ex_alu_op,
    input  wire[1:0]   ex_alu_src1,
    input  wire[1:0]   ex_alu_src2,
    input  wire        ex_br_addr_mode,
    input  wire        ex_br,
    //forwarding
    input  wire[1:0]   forwardA,
    input  wire[1:0]   forwardB,
    input  wire[31:0]  me_alu_o,
    input  wire[31:0]  w_regs_data,

    output wire[31:0]  ex_alu_o,
    output wire[31:0]  ex_regs_data2_o,//the data for S-inst 
    output wire[31:0]  br_pc, //branch address
    output wire        br_ctrl
);

wire [3:0]  alu_ctrl;
wire [31:0] op_A;
wire [31:0] op_A_pre;
wire [31:0] op_B;
wire [31:0] op_B_pre;
wire        br_mark;
wire [31:0] br_addr_op_A; 

alu_control u_alu_control(
    .alu_op     (ex_alu_op     ),
    .func3_code (ex_func3_code ),
    .func7_code (ex_func7_code ),
    .alu_ctrl_r (alu_ctrl      )
);


alu u_alu(
    .alu_ctrl (alu_ctrl      ),
    .op_A     (op_A          ),
    .op_B     (op_B          ),
    .alu_o    (ex_alu_o      ),
    .br_mark  (br_mark       )
);

assign br_addr_op_A    = (ex_br_addr_mode == `J_REG) ? op_A_pre : ex_pc;
assign br_pc           = br_addr_op_A + ex_imm;
assign op_B            = (ex_alu_src2 == `PC_PLUS4)? 32'd4 : (ex_alu_src2 == `IMM)? ex_imm : op_B_pre;
assign op_A            = (ex_alu_src1 == `NULL)? 32'd0 : (ex_alu_src1 == `PC)? ex_pc : op_A_pre;
assign op_B_pre        = (forwardB == `EX_MEM_B)? me_alu_o : (forwardB == `MEM_WB_B)? w_regs_data : ex_regs_data2;
assign op_A_pre        = (forwardA == `EX_MEM_A)? me_alu_o : (forwardA == `MEM_WB_A)? w_regs_data : ex_regs_data1;
assign br_ctrl         = br_mark && ex_br;
assign ex_regs_data2_o = op_B_pre;

always @(*) begin
    if (forwardA)
        $display("forwardA! OP_A: %h",op_A);
    else if (forwardB)
        $display("forwardB! OP_B: %h",op_B);
end

endmodule