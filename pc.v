module pc(
    input  wire         clk,
    input  wire         br_ctrl, //br
    input  wire[31:0]   br_addr,
    input  wire         rst,
    output reg[31:0]    pc_o,
    //hazard detection
    input  wire         pc_stall
    );

reg [31:0] pc_now;

always @(posedge clk) begin
    if (!rst)begin
        pc_o    <= 0;
    end
    else begin
        $display("PC_O = PC_now: %h", pc_o);
        pc_o <= pc_now;
    end
end

always @(posedge clk) begin
    if (!rst)begin
        pc_now  <= 4;
    end
    else if (br_ctrl) begin
        $display("PC_now = BR_addr: %h", pc_now);
        pc_now <= br_addr;
    end
    else if (pc_stall) begin
        $display("PC_now = stall: %h", pc_now);
        pc_now <= pc_now;
    end
    else begin
        pc_now <= pc_now + 4;
    end
end

endmodule