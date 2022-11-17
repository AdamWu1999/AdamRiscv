// author       : adam_wu
// course       : Microprocessor Architecture and Design
// ID           : 21033075
// project_name : AdamRiscv(Five-stage Pipelined Processor Based on RV32I)

module adam_riscv(
    input wire sys_clk,
`ifdef FPGA_MODE
    output wire[2:0] led,
`endif
    input wire sys_rstn
);

wire          rstn;
wire          clk;

wire          br_ctrl;
wire[31:0]    br_addr;
wire          stall;
wire[31:0]    if_pc;
wire[31:0]    if_inst;
wire          flush;
wire[31:0]    id_inst;
wire[31:0]    id_pc;

wire          w_regs_en;
wire[4:0]     w_regs_addr;
wire[31:0]    w_regs_data;
wire[31:0]    id_regs_data1;
wire[31:0]    id_regs_data2;
wire[31:0]    id_imm;
wire[2:0]     id_func3_code; 
wire          id_func7_code;
wire[4:0]     id_rd;
wire          id_br;
wire          id_mem_read;
wire          id_mem2reg;
wire[2:0]     id_alu_op;
wire          id_mem_write;
wire[1:0]     id_alu_src1;
wire[1:0]     id_alu_src2;
wire          id_br_addr_mode;
wire          id_regs_write;
wire          id_mem_write_forward;
wire[4:0]     id_rs1;
wire[4:0]     id_rs2;
wire[4:0]     ex_rs1;
wire[4:0]     ex_rs2;
wire[31:0]    ex_pc;
wire[31:0]    ex_regs_data1;
wire[31:0]    ex_regs_data2;
wire[31:0]    ex_imm;
wire[2:0]     ex_func3_code; 
wire          ex_func7_code;
wire[4:0]     ex_rd;
wire          ex_br;
wire          ex_mem_read;
wire          ex_mem2reg;
wire[2:0]     ex_alu_op;
wire          ex_mem_write;
wire[1:0]     ex_alu_src1;
wire[1:0]     ex_alu_src2;
wire          ex_br_addr_mode;
wire          ex_regs_write;
wire[31:0]    ex_regs_data2_o;
wire[31:0]    ex_alu_o;

wire[1:0]     forwardA;
wire[1:0]     forwardB;

wire [4:0]    me_rs2;
wire [31:0]   me_regs_data2;
wire [31:0]   me_alu_o;
wire [4:0]    me_rd;
wire          me_mem_read;
wire          me_mem2reg;
wire          me_mem_write;
wire          me_regs_write;
wire[31:0]    me_mem_data;
wire[2:0]     me_func3_code;  

wire          forward_data;
wire[2:0]     wb_func3_code;
wire[31:0]    wb_mem_data;
wire[31:0]    wb_alu_o;
wire          wb_mem2reg;

`ifdef FPGA_MODE
    clk_wiz_0 clk2cpu
     (
      // Clock out ports
      .clk_out1(clk),     // output clk_out1
     // Clock in ports
      .clk_in1(sys_clk));      // input clk_in1
`else
    assign clk = sys_clk;
`endif


syn_rst u_syn_rst(
    .clock      (clk    ),
    .rstn       (sys_rstn),
    .syn_rstn    (rstn   )
);

stage_if u_stage_if(
    .clk      (clk      ),
    .rstn     (rstn     ),
    .pc_stall (stall    ),
    .if_flush (flush    ),
    .br_addr  (br_addr  ),
    .br_ctrl  (br_ctrl  ),
    .if_inst  (if_inst  ),
    .if_pc    (if_pc    )
);


reg_if_id u_reg_if_id(
    .clk         (clk         ),
    .rstn        (rstn        ),
    .if_pc       (if_pc       ),
    .if_inst     (if_inst     ),
    .id_inst     (id_inst     ),
    .id_pc       (id_pc       ),
    .if_id_flush (flush       ),
    .if_id_stall (stall       )
);

stage_id u_stage_id(
    .clk                  (clk                 ),
    .rstn                 (rstn                ),
    .id_inst              (id_inst             ),
    .w_regs_en            (w_regs_en           ),
    .w_regs_addr          (w_regs_addr         ),
    .w_regs_data          (w_regs_data         ),
    .ctrl_stall           (stall               ),
    .id_regs_data1        (id_regs_data1       ),
    .id_regs_data2        (id_regs_data2       ),
    .id_imm               (id_imm              ),
    .id_func3_code        (id_func3_code       ),
    .id_func7_code        (id_func7_code       ),
    .id_rd                (id_rd               ),
    .id_br                (id_br               ),
    .id_mem_read          (id_mem_read         ),
    .id_mem2reg           (id_mem2reg          ),
    .id_alu_op            (id_alu_op           ),
    .id_mem_write         (id_mem_write        ),
    .id_alu_src1          (id_alu_src1         ),
    .id_alu_src2          (id_alu_src2         ),
    .id_br_addr_mode      (id_br_addr_mode     ),
    .id_regs_write        (id_regs_write       ),
    .id_mem_write_forward (id_mem_write_forward),
    .id_rs1               (id_rs1              ),
    .id_rs2               (id_rs2              )
);


reg_id_ex u_reg_id_ex(
    .clk             (clk             ),
    .rstn            (rstn            ),
    .id_pc           (id_pc           ),
    .id_regs_data1   (id_regs_data1   ),
    .id_regs_data2   (id_regs_data2   ),
    .id_imm          (id_imm          ),
    .id_func3_code   (id_func3_code   ),
    .id_func7_code   (id_func7_code   ),
    .id_rd           (id_rd           ),
    .id_br           (id_br           ),
    .id_mem_read     (id_mem_read     ),
    .id_mem2reg      (id_mem2reg      ),
    .id_alu_op       (id_alu_op       ),
    .id_mem_write    (id_mem_write    ),
    .id_alu_src1     (id_alu_src1     ),
    .id_alu_src2     (id_alu_src2     ),
    .id_br_addr_mode (id_br_addr_mode ),
    .id_regs_write   (id_regs_write   ),
    .id_ex_flush     (flush           ),
    .id_rs1          (id_rs1          ),
    .id_rs2          (id_rs2          ),
    .ex_rs1          (ex_rs1          ),
    .ex_rs2          (ex_rs2          ),
    .ex_pc           (ex_pc           ),
    .ex_regs_data1   (ex_regs_data1   ),
    .ex_regs_data2   (ex_regs_data2   ),
    .ex_imm          (ex_imm          ),
    .ex_func3_code   (ex_func3_code   ),
    .ex_func7_code   (ex_func7_code   ),
    .ex_rd           (ex_rd           ),
    .ex_br           (ex_br           ),
    .ex_mem_read     (ex_mem_read     ),
    .ex_mem2reg      (ex_mem2reg      ),
    .ex_alu_op       (ex_alu_op       ),
    .ex_mem_write    (ex_mem_write    ),
    .ex_alu_src1     (ex_alu_src1     ),
    .ex_alu_src2     (ex_alu_src2     ),
    .ex_br_addr_mode (ex_br_addr_mode ),
    .ex_regs_write   (ex_regs_write   )
);



stage_ex u_stage_ex(
    .ex_pc           (ex_pc           ),
    .ex_regs_data1   (ex_regs_data1   ),
    .ex_regs_data2   (ex_regs_data2   ),
    .ex_imm          (ex_imm          ),
    .ex_func3_code   (ex_func3_code   ),
    .ex_func7_code   (ex_func7_code   ),
    .ex_alu_op       (ex_alu_op       ),
    .ex_alu_src1     (ex_alu_src1     ),
    .ex_alu_src2     (ex_alu_src2     ),
    .ex_br_addr_mode (ex_br_addr_mode ),
    .ex_br           (ex_br           ),
    .forwardA        (forwardA        ),
    .forwardB        (forwardB        ),
    .me_alu_o        (me_alu_o        ),
    .w_regs_data     (w_regs_data     ),
    .ex_alu_o        (ex_alu_o        ),
    .ex_regs_data2_o (ex_regs_data2_o ),
    .br_pc           (br_addr         ),
    .br_ctrl         (br_ctrl         )
);

reg_ex_mem u_reg_ex_mem(
    .clk           (clk             ),
    .rstn          (rstn            ),
    .ex_regs_data2 (ex_regs_data2_o ),
    .ex_alu_o      (ex_alu_o        ),
    .ex_rd         (ex_rd           ),
    .ex_mem_read   (ex_mem_read     ),
    .ex_mem2reg    (ex_mem2reg      ),
    .ex_mem_write  (ex_mem_write    ),
    .ex_regs_write (ex_regs_write   ),
    .ex_func3_code (ex_func3_code   ),
    .ex_rs2        (ex_rs2          ),
    .me_rs2        (me_rs2          ),
    .me_regs_data2 (me_regs_data2   ),
    .me_alu_o      (me_alu_o        ),
    .me_rd         (me_rd           ),
    .me_mem_read   (me_mem_read     ),
    .me_mem2reg    (me_mem2reg      ),
    .me_mem_write  (me_mem_write    ),
    .me_regs_write (me_regs_write   ),
    .me_func3_code (me_func3_code   )
);

`ifdef FPGA_MODE
    stage_mem u_stage_mem(
        .clk           (clk           ),
        .rstn          (rstn          ),
        .me_regs_data2 (me_regs_data2 ),
        .me_alu_o      (me_alu_o      ),
        .me_mem_read   (me_mem_read   ),
        .me_mem_write  (me_mem_write  ),
        .me_func3_code (me_func3_code ),
        .forward_data  (forward_data  ),
        .w_regs_data   (w_regs_data   ),
        .me_led        (led           ),
        .me_mem_data   (me_mem_data   )
    );

`else
    stage_mem u_stage_mem(
        .clk           (clk           ),
        .rstn          (rstn          ),
        .me_regs_data2 (me_regs_data2 ),
        .me_alu_o      (me_alu_o      ),
        .me_mem_read   (me_mem_read   ),
        .me_mem_write  (me_mem_write  ),
        .me_func3_code (me_func3_code ),
        .forward_data  (forward_data  ),
        .w_regs_data   (w_regs_data   ),
        .me_mem_data   (me_mem_data   )
    );
`endif


reg_mem_wb u_reg_mem_wb(
    .clk           (clk           ),
    .rstn          (rstn          ),
    .me_mem_data   (me_mem_data   ),
    .me_alu_o      (me_alu_o      ),
    .me_rd         (me_rd         ),
    .me_mem2reg    (me_mem2reg    ),
    .me_regs_write (me_regs_write ),
    .me_func3_code (me_func3_code ),
    .wb_func3_code (wb_func3_code ),
    .wb_mem_data   (wb_mem_data   ),
    .wb_alu_o      (wb_alu_o      ),
    .wb_rd         (w_regs_addr   ),
    .wb_mem2reg    (wb_mem2reg    ),
    .wb_regs_write (w_regs_en     )
);


stage_wb u_stage_wb(
    .wb_mem_data   (wb_mem_data ),
    .wb_alu_o      (wb_alu_o    ),
    .wb_mem2reg    (wb_mem2reg  ),
    .wb_func3_code (wb_func3_code ),
    .w_regs_data   (w_regs_data )
);

forwarding u_forwarding(
    .ex_rs1        (ex_rs1        ),
    .ex_rs2        (ex_rs2        ),
    .me_rd         (me_rd         ),
    .wb_rd         (w_regs_addr   ),
    .me_rs2        (me_rs2        ),
    .me_mem_write  (me_mem_write  ),
    .wb_mem2reg    (wb_mem2reg    ),
    .me_regs_write (me_regs_write ),
    .wb_regs_write (w_regs_en     ),
    .forwardA      (forwardA      ),
    .forwardB      (forwardB      ),
    .forward_data  (forward_data  )
);

hazard_detection u_hazard_detection(
    .ex_mem_read         (ex_mem_read         ),
    .id_mem_write_forward(id_mem_write_forward),
    .id_rs1              (id_rs1              ),
    .id_rs2              (id_rs2              ),
    .ex_rd               (ex_rd               ),
    .br_ctrl             (br_ctrl             ),
    .stall               (stall               ),
    .flush               (flush               )
);


endmodule