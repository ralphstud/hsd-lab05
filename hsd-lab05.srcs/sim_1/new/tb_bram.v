`timescale 1ns / 1ps

module tb_bram();

    parameter BRAM_ADDR_WIDTH = 15;
    parameter INIT_FILE = "input.txt";
    parameter OUT_FILE = "output.txt";

    //for my IP
    reg [BRAM_ADDR_WIDTH-1:0] BRAM_ADDR;
    reg BRAM_CLK;
    reg [31:0] BRAM1_WRDATA;
    reg [31:0] BRAM2_WRDATA;
    wire [31:0] BRAM1_RDDATA;
    wire [31:0] BRAM2_RDDATA;
    reg BRAM1_EN;
    reg BRAM2_EN;
    reg BRAM1_RST;
    reg BRAM2_RST;
    reg [3:0] BRAM1_WE;
    reg [3:0] BRAM2_WE;
    reg done;

    //for test

    integer i;

    initial begin
        BRAM_CLK <= 1;
        BRAM1_EN <= 1;
        BRAM2_EN <= 1;
        BRAM1_RST <= 0;
        BRAM2_RST <= 0;
        BRAM1_WE <= 4'b0000;
        BRAM2_WE <= 4'b1111;
        BRAM_ADDR <= 0;
        done <= 0;
        for (i = 0; i < 2**13; i = i + 1) begin
            BRAM_ADDR = BRAM_ADDR + 4;
            #30;
            BRAM2_WRDATA = BRAM1_RDDATA;            
        end
        done <= 1;
    end
    
    always #5 BRAM_CLK = ~BRAM_CLK;

    my_bram #(15, INIT_FILE, "") BRAM1 (
        .BRAM_ADDR(BRAM_ADDR),
        .BRAM_CLK(BRAM_CLK),
        .BRAM_WRDATA(BRAM1_WRDATA),
        .BRAM_RDDATA(BRAM1_RDDATA),
        .BRAM_EN(BRAM1_EN),
        .BRAM_RST(BRAM1_RST),
        .BRAM_WE(BRAM1_WE),
        .done(done)
    );

    my_bram #(15, "", OUT_FILE) BRAM2 (
        .BRAM_ADDR(BRAM_ADDR),
        .BRAM_CLK(BRAM_CLK),
        .BRAM_WRDATA(BRAM2_WRDATA),
        .BRAM_RDDATA(BRAM2_RDDATA),
        .BRAM_EN(BRAM2_EN),
        .BRAM_RST(BRAM2_RST),
        .BRAM_WE(BRAM2_WE),
        .done(done)
    );

endmodule