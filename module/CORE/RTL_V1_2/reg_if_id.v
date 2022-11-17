module reg_if_id(
    input wire clk,
    input wire rstn,
    input wire[31:0] if_pc,
    input wire[31:0] if_inst,
    output wire[31:0] id_inst,
    output reg[31:0] id_pc,
    //hazard detection
    input  wire if_id_flush,
    input  wire if_id_stall
);

reg [31:0]     id_inst_reg;
reg            inst_swift; //when stall or flush happens, the inst from IROM is invalid. 

always @(posedge clk  or negedge rstn) begin
    if (!rstn)begin
        inst_swift  <= 1'b0;
    end
    else if (if_id_stall || if_id_flush) begin
        inst_swift  <= 1'b1;  
    end
    else begin
        inst_swift  <= 1'b0;
    end
end

always @(posedge clk  or negedge rstn) begin
    if ((!rstn) || if_id_flush)begin
        id_pc       <= 32'b0;

        if (if_id_flush)begin
        $display("if_id_flush pc: %h",id_pc);
        end
        
    end
    else if (if_id_stall) begin
        id_pc       <= id_pc; 
        $display("if_id_stall, inst: %h, \npc: %h", id_inst,id_pc );     
    end
    else begin
        id_pc       <= if_pc;
    end
end

always @(posedge clk  or negedge rstn) begin
    if ((!rstn) || if_id_flush)begin
        id_inst_reg <= 32'b0;
    end
    else begin
        id_inst_reg <= if_inst;
        $display("id_inst: %h",id_inst );        
    end
end

assign id_inst = (inst_swift)? id_inst_reg : if_inst ;


endmodule