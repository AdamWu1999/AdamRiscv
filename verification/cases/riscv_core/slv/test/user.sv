
initial begin
    //$display("\n******** IIC Slave Test Start !!!! ******");
    //#10us;
    ////`I2C_W32(16'h0004,32'h55aaffdd);
    //#5us;
    //`I2C_R32(16'h0004,rdata);

    //$display("\n******** Rdata= %x !!!! ******",rdata);
    //#5us
    //TEST_PASS;
    $display("\n******** hello risc_v !!!! ******");
    #10us;
    TEST_PASS;

end

