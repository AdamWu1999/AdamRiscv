module hazard_detection(
    input  wire      ex_mem_read,
    input  wire[4:0] id_rs1,
    input  wire[4:0] id_rs2,
    input  wire[4:0] ex_rd,
    input  wire      br_ctrl,
    output wire      load_stall,
    output wire      flush
);
assign load_stall = ex_mem_read && (ex_rd == id_rs1 || ex_rd == id_rs2);
assign flush      = br_ctrl;


endmodule