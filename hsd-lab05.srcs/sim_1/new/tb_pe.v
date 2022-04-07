`timescale 1ns / 1ps
module my_pe #(
    parameter L_RAM_SIZE = 6
)
    // global buffer
    reg [31:0] gb1 [0:2**L_RAM_SIZE - 1];
    reg [31:0] gb2 [0:2**L_RAM_SIZE - 1];
    
    initial begin
    
    end
    
endmodule

