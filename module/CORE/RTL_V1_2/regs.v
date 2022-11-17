module regs(
    input wire clk,
    input wire rstn,

    input wire[4:0]     r_regs_addr1,
    input wire[4:0]     r_regs_addr2,
    input wire[4:0]     w_regs_addr,
    input wire[31:0]    w_regs_data,
    input wire          w_regs_en,

    output wire[31:0]   r_regs_o1,
    output wire[31:0]   r_regs_o2
);

reg [31:0] reg_bank [31:0]; //  32 32-bit registers
wire wb_hazard_a;
wire wb_hazard_b;

/*------------------------Write RegisterFile---------------*/
always @(posedge clk or negedge rstn) begin
    if (!rstn)begin
        reg_bank[0] <= 0;
        reg_bank[1] <= 0;
        reg_bank[2] <= 0;
        reg_bank[3] <= 0;
        reg_bank[4] <= 0;
        reg_bank[5] <= 0;
        reg_bank[6] <= 0;
        reg_bank[7] <= 0;
        reg_bank[8] <= 0;
        reg_bank[9] <= 0;
        reg_bank[10] <= 0;
        reg_bank[11] <= 0;
        reg_bank[12] <= 0;
        reg_bank[13] <= 0;
        reg_bank[14] <= 0;
        reg_bank[15] <= 0;
        reg_bank[16] <= 0;
        reg_bank[17] <= 0;
        reg_bank[18] <= 0;
        reg_bank[19] <= 0;
        reg_bank[20] <= 0;
        reg_bank[21] <= 0;
        reg_bank[22] <= 0;
        reg_bank[23] <= 0;
        reg_bank[24] <= 0;
        reg_bank[25] <= 0;
        reg_bank[26] <= 0;
        reg_bank[27] <= 0;
        reg_bank[28] <= 0;
        reg_bank[29] <= 0;
        reg_bank[30] <= 0;
        reg_bank[31] <= 0;


    end
    else if (w_regs_en && w_regs_addr != 5'b0) begin //forbit write x0
        $display("WRITE REGISTER FILE: x%d = %h", w_regs_addr, w_regs_data);
        reg_bank[w_regs_addr] <= w_regs_data;
    end
end

/*------------------------hazard check & forwarding-------------*/
assign wb_hazard_a = w_regs_en && (w_regs_addr != 0) && (w_regs_addr == r_regs_addr1); //me_rd != 0 : don't forward the result when rd is x0
assign wb_hazard_b = w_regs_en && (w_regs_addr != 0) && (w_regs_addr == r_regs_addr2);

/*------------------------Read RegisterFile---------------*/
assign r_regs_o1 = wb_hazard_a ? w_regs_data : reg_bank[r_regs_addr1];
assign r_regs_o2 = wb_hazard_b ? w_regs_data : reg_bank[r_regs_addr2];

endmodule
