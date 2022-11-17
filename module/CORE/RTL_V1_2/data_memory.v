`include "define.v"
module data_memory #(
    parameter RAM_SPACE = 4096
)(
    input  wire         clk,
    //input  wire         rstn,
    input  wire[31:0]   addr_mem,
    input  wire[31:0]   w_data_mem,
//    input  wire[ 3:0]   r_en_mem,
    input  wire[ 3:0]   w_en_mem,
    input  wire         en_mem,
    output wire[31:0]   r_data_mem
);
localparam ADDR_WIDTH = $clog2(RAM_SPACE);
wire [ADDR_WIDTH -1 : 0] addr_mem_2;

assign addr_mem_2 = addr_mem[ADDR_WIDTH +2-1 : 2];//Word-alignment, and width depends on `RAM_SPACE


`ifdef FPGA_MODE

DATA_RAM u_ram_data (
  .clka         (clk          ),    // input wire clka
  .ena          (en_mem       ),      // input wire ena
  .wea          (w_en_mem     ),      // input wire [3 : 0] wea
  .addra        (addr_mem_2   ),  // input wire [11 : 0] addra
  .dina         (w_data_mem   ),    // input wire [31 : 0] dina
  .douta        (r_data_mem   )  // output wire [31 : 0] douta
);

`elsif  MC_MACRO

SRAM_4096_32 u_ram_data(
    .QA       ( r_data_mem      ),     //port-A data output
    .CLKA     ( clk             ),     //port-A clock
    .CENA     ( en_mem          ),     //port-A chip enable
    .WENA     ( w_en_mem        ),     //port-A write enable
    .AA       ( addr_mem_2      ),     //port-A address
    .DA       ( w_data_mem      ),     //port-A data input

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
        .RAM_DEPTH      ( RAM_SPACE     )
    )
    u_ram_data(
    //system signals
    .clk                        ( clk               ),
    //RAM Control signals
    .cs                         ( en_mem            ),
    .we                         ( w_en_mem          ),
    .addr                       ( addr_mem_2        ),
    .wdata                      ( w_data_mem        ),
    .rdata                      ( r_data_mem        )
);
`endif
endmodule