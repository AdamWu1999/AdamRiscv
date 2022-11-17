`include "define.v"
module stage_wb(
    input  wire[31:0]  wb_mem_data,
    input  wire[31:0]  wb_alu_o,
    input  wire        wb_mem2reg,
    input  wire[2:0]   wb_func3_code,
    output wire[31:0]  w_regs_data
);

reg [31:0]  wb_mem_data_o; //the data from L-inst's logic design
wire [1:0]  addr_in_word_wb;
assign w_regs_data = wb_mem2reg ? wb_mem_data_o : wb_alu_o;
assign addr_in_word_wb   = wb_alu_o[1:0];

/*----------------Read DataMemory for L-inst---------------------*/
always @(*) begin
    case(wb_func3_code)
    `LB:begin
        case (addr_in_word_wb)
            2'b00:   wb_mem_data_o = {{24{wb_mem_data[7]}}, wb_mem_data[7:0]};
            2'b01:   wb_mem_data_o = {{24{wb_mem_data[15]}},wb_mem_data[15:8]};
            2'b10:   wb_mem_data_o = {{24{wb_mem_data[23]}},wb_mem_data[23:16]};
            2'b11:   wb_mem_data_o = {{24{wb_mem_data[31]}},wb_mem_data[31:24]};
            default: wb_mem_data_o = {32'd0};
        endcase
    end
    `LH:begin
        case (addr_in_word_wb[1])
            1'b0:    wb_mem_data_o = {{16{wb_mem_data[15]}},wb_mem_data[15:0]};
            1'b1:    wb_mem_data_o = {{16{wb_mem_data[31]}},wb_mem_data[31:16]};
            default: wb_mem_data_o = {32'd0};
        endcase
    end
    `LW:     wb_mem_data_o = wb_mem_data;
    `LBU:begin
        case (addr_in_word_wb)
            2'b00:   wb_mem_data_o = {24'd0,wb_mem_data[7:0]};
            2'b01:   wb_mem_data_o = {24'd0,wb_mem_data[15:8]};
            2'b10:   wb_mem_data_o = {24'd0,wb_mem_data[23:16]};
            2'b11:   wb_mem_data_o = {24'd0,wb_mem_data[31:24]};
            default: wb_mem_data_o = {32'd0};
        endcase
    end
    `LHU:begin
        case (addr_in_word_wb[1])//Half-byte address alignment
            1'b0:    wb_mem_data_o = {16'b0,wb_mem_data[15:0]};
            1'b1:    wb_mem_data_o = {16'b0,wb_mem_data[31:16]};
            default: wb_mem_data_o = {32'd0};
        endcase
    end
    default: wb_mem_data_o = 32'd0;
    endcase
end

always @(*) begin
    if(wb_mem2reg)begin
        $strobe("WHOLE-WORD READ FROM DATA MEMORY : Addr %d = %h ", wb_alu_o, wb_mem_data);
        $strobe("DATA IN LOAD-INST : ", wb_mem_data_o);
    end
end
endmodule