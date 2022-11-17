`include "define.v"
module alu_control(
    input wire[2:0] alu_op,
    input wire[2:0] func3_code, 
    input wire      func7_code,  //func7_code = func7[5] = [inst[30]]
    output reg[3:0] alu_ctrl_r
);

always @(*) begin
    case(alu_op)
        3'b000: //`ItypeL,`Stype,`UtypeL、`UtypeU
            alu_ctrl_r = `ADD;

        3'b001:begin //`Btype
            case (func3_code)
                `B_BEQ:  alu_ctrl_r = `SUB;
                `B_BNE:  alu_ctrl_r = `NOTEQ;
                `B_BLT:  alu_ctrl_r = `SLT;
                `B_BGE:  alu_ctrl_r = `SGE;
                `B_BLTU: alu_ctrl_r = `SLTU;
                `B_BGEU: alu_ctrl_r = `SGEU;
                default: alu_ctrl_r = 4'b1111;
            endcase
        end

        3'b010:begin //`Rtype
            case ({func3_code,func7_code})
                `R_ADD  :   alu_ctrl_r = `ADD  ;
                `R_SUB  :   alu_ctrl_r = `SUB  ;
                `R_SLL  :   alu_ctrl_r = `SLL  ;
                `R_SLT  :   alu_ctrl_r = `SLT  ;
                `R_SLTU :   alu_ctrl_r = `SLTU ;
                `R_XOR  :   alu_ctrl_r = `XOR  ;
                `R_SRL  :   alu_ctrl_r = `SRL  ;
                `R_SRA  :   alu_ctrl_r = `SRA  ;
                `R_OR   :   alu_ctrl_r = `OR   ;
                `R_AND  :   alu_ctrl_r = `AND  ;
                default: alu_ctrl_r = 4'b1111;
            endcase
        end

        3'b011:begin //`ItypeA
            case (func3_code)
                `I_ADDI  :  alu_ctrl_r = `ADD  ;//also `I_JALR
                `I_SLLI  :  alu_ctrl_r = (func7_code == 0)? `SLL :4'b1111 ;
                `I_SLTI  :  alu_ctrl_r = `SLT ; 
                `I_SLTIU :  alu_ctrl_r = `SLTU ;
                `I_XORI  :  alu_ctrl_r = `XOR ;  
                `I_SRLI  :  alu_ctrl_r = (func7_code == 0)? `SRL : (func7_code == 1)? `SRA : 4'b1111 ; //also `I_SRAI
                `I_ORI   :  alu_ctrl_r = `OR ;
                `I_ANDI  :  alu_ctrl_r = `AND ; 
                default: alu_ctrl_r = 4'b1111;
            endcase
        end

        3'b100: //`ItypeJ,`Jtype
            alu_ctrl_r = `JUMP;
        default   : alu_ctrl_r = 4'b1111;

    /*
        `OP_LS    : alu_ctrl_r = `ADD;  //load,store : alu_mode is add
        `OP_Br    : alu_ctrl_r = `SUB;  //beq : alu_mode is subtract
        `OP_R_ADD : alu_ctrl_r = `ADD;  //Rtype 
        `OP_R_SUB : alu_ctrl_r = `SUB;  //Rtype 
        `OP_R_SLL : alu_ctrl_r = `SLL;  //Rtype 
        `OP_R_SLT : alu_ctrl_r = `SLT;  //Rtype 
        `OP_R_SLTU: alu_ctrl_r = `SLTU; //Rtype
        `OP_R_XOR : alu_ctrl_r = `XOR;  //Rtype 
        `OP_R_SRL : alu_ctrl_r = `SRL;  //Rtype
        `OP_R_SRA : alu_ctrl_r = `SRA;  //Rtype 
        `OP_R_OR  : alu_ctrl_r = `OR;   //Rtype
        `OP_R_AND : alu_ctrl_r = `AND;  //Rtype 
*/
    endcase
end

endmodule