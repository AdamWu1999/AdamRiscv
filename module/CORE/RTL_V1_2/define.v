//-------------------inst_type-------------------
`define ItypeL 7'b0000011 //Itype for Load
`define ItypeA 7'b0010011 //Itype for ALU
`define ItypeJ 7'b1100111 //Itype for Jalr
`define Rtype  7'b0110011
`define Btype  7'b1100011
`define Stype  7'b0100011
`define UtypeL 7'b0110111 //Utype for lui
`define UtypeU 7'b0010111 //Utype for auipc
`define Jtype  7'b1101111 //Utype for jal
 

//-------------------ALU_MODE------------------
`define ADD    4'd0 
`define SUB    4'd1 
`define SLL    4'd2 
`define SRL    4'd3 
`define SRA    4'd4 
`define SLT    4'd5 
`define SLTU   4'd6 
`define AND    4'd7 
`define OR     4'd8
`define XOR    4'd9 
`define NOTEQ  4'd10 // NOT equel
`define SGE    4'd11   // set greater than
`define SGEU   4'd12  // set greater than unsigned
`define JUMP   4'd13   // FOR JAL,JALR

//-------------------Itype_Func3----------------
`define I_ADDI  3'b000
`define I_JALR  3'b000
`define I_SLLI  3'b001
`define I_SLTI  3'b010 
`define I_SLTIU 3'b011
`define I_XORI  3'b100  
`define I_SRLI  3'b101
`define I_SRAI  3'b101 
`define I_ORI   3'b110
`define I_ANDI  3'b111 

//-------------------Rtype_Func3----------------
`define R_ADD  4'b0000 
`define R_SUB  4'b0001 
`define R_SLL  4'b0010
`define R_SLT  4'b0100 
`define R_SLTU 4'b0110
`define R_XOR  4'b1000  
`define R_SRL  4'b1010
`define R_SRA  4'b1011 
`define R_OR   4'b1100
`define R_AND  4'b1110 

//-------------------Btype_Func3----------------
`define B_BEQ   3'b000 
`define B_BNE   3'b001
`define B_BLT   3'b100 
`define B_BGE   3'b101
`define B_BLTU  3'b110  
`define B_BGEU  3'b111

//-------------------forwarding--------------------
`define ID_EX_A   2'b00
`define EX_MEM_A  2'b10
`define MEM_WB_A  2'b01
`define ID_EX_B   2'b00
`define EX_MEM_B  2'b10
`define MEM_WB_B  2'b01

//-------------------EX STAGE control----------------
`define IMM         2'b01
`define PC_PLUS4    2'b10
`define REG         2'b00

`define PC          2'b10
`define NULL        2'b01

`define J_REG         2'b0
`define B_PC          2'b1

//------------------MEM STAGE control-----------------
`define LB  3'b000
`define LH  3'b001
`define LW  3'b010
`define LBU 3'b100
`define LHU 3'b101
`define SB  2'b00
`define SH  2'b01
`define SW  2'b10
