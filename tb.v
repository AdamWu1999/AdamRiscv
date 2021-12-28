`timescale 1ns/100ps
module tb;

reg clk;
reg rst;
always begin
#25    clk = ~clk;
end

adam_riscv u_adam_riscv(
    .clk (clk ),
    .rst (rst )
);
initial begin
    $display ($time, "<<Starting simulation>>");
    clk = 1'b1;
    rst = 1'b0;
    #100 rst = 1'b1;
end

endmodule