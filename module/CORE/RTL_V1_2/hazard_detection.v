module hazard_detection(
    input  wire      ex_mem_read,
    input  wire[4:0] id_rs1,
    input  wire[4:0] id_rs2,
    input  wire[4:0] ex_rd,
    input  wire      br_ctrl,
    input  wire      id_mem_write_forward,
    output wire      stall,
    output wire      flush
);

wire load_stall;
assign load_stall      = ex_mem_read && (ex_rd == id_rs1 || ex_rd == id_rs2);
//detect load+store to avoid being stalled
assign stall_exception = ex_mem_read && id_mem_write_forward && (ex_rd == id_rs2);
assign flush           = br_ctrl;
assign stall           = load_stall && (~stall_exception);

endmodule