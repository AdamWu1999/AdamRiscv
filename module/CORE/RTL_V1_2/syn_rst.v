module syn_rst(
    input  wire      clock,
    input  wire      rstn,     //async_negedge_active_reset
    output wire      syn_rstn
);
    reg rst_nr1, rst_nr2;
 
    always @(posedge clock or negedge rstn) begin
        if(!rstn) begin
			rst_nr1 <= 1'b0;
            rst_nr2 <= 1'b0;		//异步复位
        end
        else begin
			rst_nr1 <= 1'b1;
			rst_nr2 <= rst_nr1;		//同步释放
		end
    end
	
	assign syn_rstn = rst_nr2;			//新的系统复位信号rst_n	
endmodule							// sync_async_reset