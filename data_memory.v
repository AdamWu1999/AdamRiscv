module data_memory #(
    parameter DROM_SPACE = 1024
)(
    input  wire         clk,
    input  wire         rst,
    input  wire[31:0]   data_addr,
    input  wire[31:0]   w_data_mem,
    input  wire         r_en_mem,
    input  wire         w_en_mem,
    input  wire[1:0]    byte_sel,
    output wire[31:0]   r_data_mem
);

reg [7:0] data [DROM_SPACE-1:0];

/*----------------Write DataMemory---------------------*/
always @(posedge clk) begin
    if (w_en_mem && !r_en_mem)begin
        if (byte_sel == 2'b00) begin
            data[data_addr]   <= w_data_mem[7:0];
        end
        else if(byte_sel == 2'b01) begin
            data[data_addr]   <= w_data_mem[7:0];
            data[data_addr+1] <= w_data_mem[15:8];
        end
        else if(byte_sel == 2'b10)begin
            data[data_addr]   <= w_data_mem[7:0];
            data[data_addr+1] <= w_data_mem[15:8];
            data[data_addr+2] <= w_data_mem[23:16];
            data[data_addr+3] <= w_data_mem[31:24];
        end
        $strobe("WRITE DATA MEMORY: Addr %d = %h ,mode:%d", data_addr,{data[data_addr+3],data[data_addr+2],data[data_addr+1],data[data_addr]},byte_sel);
    end
    
end

/*----------------Read DataMemory---------------------*/
assign r_data_mem = (r_en_mem && !w_en_mem)? {data[data_addr+3],data[data_addr+2],data[data_addr+1],data[data_addr]}: 32'b0;
/*
always @(posedge clk) begin
    if (!rst)begin
        r_data_mem <= 0;
    end
    else if (r_en_mem && !w_en_mem) begin
        r_data_mem[7:0]   <= data[data_addr];
        r_data_mem[15:8]  <= data[data_addr+1];
        r_data_mem[23:16] <= data[data_addr+2];
        r_data_mem[31:24] <= data[data_addr+3];
        $display("READ DATA MEMORY: Addr %d = %h", data_addr, r_data_mem);
    end
    else begin
        r_data_mem <= 0;
    end
end
*/  

endmodule