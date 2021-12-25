module stage_mem(
    input  wire        clk,
    input  wire        rst,
    input  wire[31:0]  me_regs_data2,
    input  wire[31:0]  me_alu_o,
    input  wire        me_mem_read,
    input  wire        me_mem_write,

    //forwarding
    input wire         forward_data,
    input wire[31:0]   w_regs_data,

    output wire[31:0]  me_mem_data
);

wire[31:0]  w_data_mem;

data_memory 
#(
    .DROM_SPACE (1024       )
)
u_data_memory(
    .clk        (clk           ),
    .rst        (rst           ),
    .data_addr  (me_alu_o      ),
    .w_data_mem (w_data_mem    ),
    .r_en_mem   (me_mem_read   ),
    .w_en_mem   (me_mem_write  ),
    .r_data_mem (me_mem_data   )
);

assign w_data_mem = forward_data ? w_regs_data : me_regs_data2;

endmodule