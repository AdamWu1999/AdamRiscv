module reg_if_id(
    input wire clk,
    input wire rst,
    input wire[31:0] if_pc,
    input wire[31:0] if_inst,
    output reg[31:0] id_inst,
    output reg[31:0] id_pc,
    //hazard detection
    input  wire if_id_flush,
    input  wire if_id_stall
);

always @(posedge clk) begin
    if (!rst | if_id_flush)begin
        $display("if_id_flush");
        id_inst <= 0;
        id_pc   <= 0;
    end
    else if (if_id_stall) begin
        $display("if_id_stall, inst: %h, \npc: %h", id_inst,id_pc );
        id_inst <= id_inst;
        id_pc   <= id_pc;        
    end
    else begin
        $display("id_inst: %h",id_inst );
        id_inst <= if_inst;
        id_pc   <= if_pc;        
    end
end

endmodule