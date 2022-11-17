`include "define.v"
module inst_memory #(
    parameter IROM_SPACE = 4096 
)(
    input  wire       clk,
    input  wire       rstn,
    input  wire[31:0] inst_addr,
    output wire[31:0] inst_o
);

localparam ADDR_WIDTH = $clog2(IROM_SPACE);
wire [ADDR_WIDTH -1 : 0] inst_addr_2;

assign inst_addr_2 = inst_addr[ADDR_WIDTH +2-1 : 2];

`ifdef FPGA_MODE
//Use the COE editer in BRAM Wizards of Vivado to initialize BRAM
//initial $readmemh ("E:/proj/AdamRiscv/rom/main_s_fpga.txt",inst_memory.u_ram_data.mem,0,4095);
INST_ROM u_ram_data (
  .clka         (clk        ),    // input wire clka
  .ena          (rstn       ),      // input wire ena
  .wea          (4'b0       ),      // input wire [3 : 0] wea
  .addra        (inst_addr_2),  // input wire [11 : 0] addra
  .dina         (32'b0      ),    // input wire [31 : 0] dina
  .douta        (inst_o     )  // output wire [31 : 0] douta
);

`elsif MC_MACRO
SRAM_4096_32 u_ram_data(
    .QA       ( inst_o          ),     //port-A data output
    .CLKA     ( clk             ),     //port-A clock
    .CENA     ( rstn             ),     //port-A chip enable
    .WENA     ( 4'b0            ),     //port-A write enable
    .AA       ( inst_addr_2     ),     //port-A address
    .DA       ( 32'b0           ),     //port-A data input

    .QB       (                 ),     //port-B data output
    .CLKB     ( 1'b0            ),     //port-B clock
    .CENB     ( 1'b0            ),     //port-B chip enable
    .WENB     ( 4'd0            ),     //port-B write enable
    .AB       ( 12'd0           ),     //port-B address
    .DB       (                 ),     //port-B data input
    
    .EMAA     (     ),     
    .EMAB     (     )
);



`else //REG_ARRAY

ram_bfm #(
        .DATA_WHITH     ( 32            ),
        .DATA_SIZE      ( 8             ),
        .ADDR_WHITH     ( ADDR_WIDTH    ),
        .RAM_DEPTH      ( IROM_SPACE    )
    )
    u_ram_data(
    //system signals
    .clk                        ( clk               ),
    //RAM Control signals
    .cs                         ( rstn              ), //Once the reset is canceled, the memory starts outputting instructions
    .we                         ( 4'b0              ),
    .addr                       ( inst_addr_2       ),
    .wdata                      ( 32'b0             ),
    .rdata                      ( inst_o            )
);

`endif

endmodule