module pc(
    input  wire         clk,
    input  wire         br_ctrl, //br
    input  wire[31:0]   br_addr,
    input  wire         rstn,
    output reg[31:0]    pc_o,
    //hazard detection
    input  wire         pc_stall
    );

reg [31:0] pc_next;

always @(posedge clk or negedge rstn) begin
    if (!rstn)begin
        pc_o    <= 0;
    end
    else if (br_ctrl) begin
        pc_o <= br_addr;
        $display("PC_o = BR_addr: %h", pc_o);
    end
    else if (pc_stall) begin
        pc_o <= pc_o;
        $display("PC_o = stall: %h", pc_o);
    end
    else begin
        pc_o <= pc_next;
        $display("PC_O = PC_next: %h", pc_o);
    end
end

always @(posedge clk or negedge rstn) begin
    if (!rstn)begin
        pc_next  <= 4;
    end
    else if (br_ctrl) begin
        pc_next <= br_addr + 4;
        //$display("PC_next = BR_addr: %h", pc_next);
    end
    else if (pc_stall) begin
        pc_next <= pc_next;
        $strobe("PC_next = stall: %h", pc_next);
    end
    else begin
        pc_next <= pc_next + 4;
    end
end

endmodule