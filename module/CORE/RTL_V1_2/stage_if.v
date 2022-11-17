module stage_if(
    input  wire          clk,
    input  wire          rstn,
    input  wire          pc_stall,
    input  wire          if_flush,
    input  wire[31:0]    br_addr,
    input  wire          br_ctrl,
    output wire[31:0]    if_inst,
    output wire[31:0]    if_pc
);


pc u_pc(
    .clk      (clk      ),
    .br_ctrl  (br_ctrl  ),
    .br_addr  (br_addr  ),
    .rstn     (rstn     ),
    .pc_o     (if_pc    ),
    .pc_stall (pc_stall )
);

inst_memory #(
    .IROM_SPACE (4096 )
)u_inst_memory(    
    .clk           (clk                ),
    .rstn          (rstn&&(!if_flush)  ),
    .inst_addr     (if_pc              ),
    .inst_o        (if_inst            )
);


endmodule