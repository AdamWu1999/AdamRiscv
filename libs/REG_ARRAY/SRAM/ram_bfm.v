// *********************************************************************************
// Project Name : CK_riscv
// Author       : Core_kingdom
// Website      : https://blog.csdn.net/weixin_40377195
// Create Time  : 2022-05-25
// File Name    : ram_bfm.v
// Module Name  : ram_bfm
// Called By    :
// Abstract     :
//
// 
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 2022-05-25    Macro           1.0                     Original
//  
// *********************************************************************************




module ram_bfm
    #(
        parameter   DATA_WHITH  = 32    ,
        parameter   DATA_SIZE   = 8     ,
        parameter   ADDR_WHITH  = 10    ,
        parameter   RAM_DEPTH   = 1024  ,
        parameter   DATA_BYTE = DATA_WHITH/DATA_SIZE
    )
    (
    //system signals
    input                               clk     ,
    //RAM Control signals
    input                               cs      ,
    input           [DATA_BYTE-1:0]     we      ,
    input           [ADDR_WHITH-1:0]    addr    ,
    input           [DATA_WHITH-1:0]    wdata   ,
    output  reg     [DATA_WHITH-1:0]    rdata   

);


(*ram_style = "block"*)  reg [DATA_WHITH-1:0] mem    [0:RAM_DEPTH-1] ;


//=================================================================================
// Body
//=================================================================================

always @(posedge clk) begin
    if(cs && !we)
        rdata <= mem[addr];
    else
        rdata <= 32'd0;
end


genvar i;

generate
    for(i=0; i<DATA_BYTE; i=i+1)begin:ram_with_mask
        always @(posedge clk)begin
            if(cs && we[i])
                mem[addr][(DATA_SIZE*i)+:DATA_SIZE] <= wdata[(DATA_SIZE*i)+:DATA_SIZE];
        end
    end

endgenerate

endmodule
