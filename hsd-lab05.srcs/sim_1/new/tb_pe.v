`timescale 1ns / 1ps
module tb_pe #(
   parameter L_RAM_SIZE = 6
);
    // global buffer
    reg [31:0] gb1 [0:2**L_RAM_SIZE - 1];
    reg [31:0] gb2 [0:2**L_RAM_SIZE - 1];
    reg aclk;
    reg aresetn;
    reg [31:0] ain;
    reg [31:0] bin;
    reg valid;
    wire dvalid;
    wire [31:0] dout;
    
    integer i;
    initial begin
        aclk <= 0;
        aresetn <= 0;
        valid <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            gb1[i] = ($urandom%2 << 31) | ($urandom % 10 + 122) << 23 | ($urandom%2**10 << 12);
            gb2[i] = ($urandom%2 << 31) | ($urandom % 10 + 122) << 23 | ($urandom%2**10 << 12);
        end
        #30;
        aresetn <= 1;
        valid <= 1;
        for (i = 0; i < 16; i = i + 1) begin
            valid = 1;
            ain = gb1[i];
            bin = gb2[i];
            #20;
            valid = 0;
            #140;
        end
    end
    
    always #5 aclk = ~aclk;
    
    my_pe MPE(
        .aclk(aclk),
        .aresetn(aresetn),
        .ain(ain),
        .bin(bin),
        .valid(valid),
        .dvalid(dvalid),
        .dout(dout)
    );
endmodule