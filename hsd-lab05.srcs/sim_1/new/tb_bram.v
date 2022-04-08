`timescale 1ns / 1ps

module tb_bram();

    parameter BRAM_ADDR_WIDTH = 15;

    //for my IP
    reg [BRAM_ADDR_WIDTH-1:0] BRAM1_ADDR;
    reg [BRAM_ADDR_WIDTH-1:0] BRAM2_ADDR;
    reg BRAM1_CLK;
    reg BRAM2_CLK;
    reg [31:0] BRAM1_WRDATA;
    reg [31:0] BRAM2_WRDATA;
    reg [31:0] BRAM1_RDDATA;
    reg [31:0] BRAM2_RDDATA;
    reg BRAM1_EN;
    reg BRAM2_EN;
    reg BRAM1_RST;
    reg BRAM2_RST;
    reg [3:0] BRAM1_WE;
    reg [3:0] BRAM2_WE;
    reg done1;
    reg done2;

    //for test

    integer i;

    initial begin
        BRAM1_ADDR <= 0;
        BRAM1_WRDATA <= 0;
        BRAM1_RDDATA <= 0;
        BRAM1_CLK <= 0;
        BRAM2_CLK <= 0;
        BRAM1_EN <= 0;
        BRAM2_EN <= 0;
        BRAM1_RST <= 0;
        BRAM2_RST <= 0;
        BRAM1_WE <= 0;
        BRAM2_WE <= 0;
        done1 <= 0;
        done2 <= 0;
        #30;
        BRAM1_EN <= 1;
        BRAM1_WE <= 4'b1111;
        
        for (i = 0; i < 2**13; i = i + 1) begin
            BRAM1_ADDR = BRAM1_ADDR + 1;
            BRAM1_WRDATA = BRAM1_WRDATA + 1;
        end
    end
    
    always #5 BRAM1_CLK = ~BRAM1_CLK;

    my_bram BRAM1 (
        .BRAM_ADDR(BRAM1_ADDR),
        .BRAM_CLK(BRAM1_CLK),
        .BRAM_WRDATA(BRAM1_WRDATA),
        .BRAM_RDDATA(BRAM1_RDDATA),
        .BRAM_EN(BRAM1_EN),
        .BRAM_RST(BRAM1_RST),
        .BRAM_WE(BRAM1_WE),
        .done(done1)
    );

    /* my_bram BRAM2 (
        .BRAM_ADDR(BRAM2_ADDR),
        .BRAM_CLK(BRAM2_CLK),
        .BRAM_WRDATA(BRAM2_WRDATA),
        .BRAM_RDDATA(BRAM2_RDDATA),
        .BRAM_EN(BRAM2_EN),
        .BRAM_RST(BRAM2_RST),
        .BRAM_WE(BRAM2_WE),
        .done(done2)
    ); */

endmodule
