module reg_ex_mem(
    input  wire clk,
    input  wire rst,
    input  wire[31:0] ex_regs_data2,
    input  wire[31:0] ex_alu_o,
    input  wire[4:0]  ex_rd,
    input  wire       ex_mem_read,
    input  wire       ex_mem2reg,
    input  wire       ex_mem_write,
    input  wire       ex_regs_write,

    //forwarding
    input wire[4:0]   ex_rs2,
    output reg[4:0]   me_rs2,

    output reg[31:0]  me_regs_data2,
    output reg[31:0]  me_alu_o,
    output reg[4:0]   me_rd,
    output reg        me_mem_read,
    output reg        me_mem2reg,
    output reg        me_mem_write,
    output reg        me_regs_write
);

always @(posedge clk) begin
    if (!rst)begin
        me_regs_data2  <= 0;         
        me_alu_o       <= 0;     
        me_rd          <= 0; 
        me_mem_read    <= 0;     
        me_mem2reg     <= 0;     
        me_mem_write   <= 0;         
        me_regs_write  <= 0;  
        me_rs2         <= 0;       
    end 
    else begin  
        me_regs_data2  <= ex_regs_data2;         
        me_alu_o       <= ex_alu_o;     
        me_rd          <= ex_rd; 
        me_mem_read    <= ex_mem_read;     
        me_mem2reg     <= ex_mem2reg;     
        me_mem_write   <= ex_mem_write;         
        me_regs_write  <= ex_regs_write;
        me_rs2         <= ex_rs2;    
    end
end

endmodule