`timescale 1ns/1ns
module tb;

reg clk;
reg rst;
always begin
#10    clk = ~clk;
end

reg [31:0] imem [0:4095];
wire [2:0] led;

adam_riscv u_adam_riscv(
    .sys_clk  (clk ),
    .sys_rstn (rst ),
    .led      (led)
);


initial begin
    $display ($time, "<<Starting simulation>>");
    clk = 1'b1;
    rst = 1'b0;
    #100 rst = 1'b1;

end


endmodule