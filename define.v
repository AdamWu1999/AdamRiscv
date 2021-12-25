//-------------------inst_type-------------------
`define ItypeL 5'b00000 //Itype for Load
`define ItypeA 5'b00100 //Itype for ALU
`define ItypeJ 5'b11001 //Itype for Jalr
`define Rtype  5'b01100
`define Btype  5'b11001
`define Stype  5'b01000
`define UtypeL 5'b01101 //Utype for lui
`define UtypeU 5'b01101 //Utype for auipc
`define Jtype  5'b11011 //Utype for jal
 

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
`define SGEU   4'd10  // set greater than unsigned

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
`define B_BLT   3'b010 
`define B_BGE   3'b011
`define B_BLTU  3'b100  
`define B_BGEU  3'b101

//-------------------forwarding--------------------
`define ID_EX_A   2'b00
`define EX_MEM_A  2'b10
`define MEM_WB_A  2'b01
`define ID_EX_B   2'b00
`define EX_MEM_B  2'b10
`define MEM_WB_B  2'b01



