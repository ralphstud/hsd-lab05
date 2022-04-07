module my_pe #(
    parameter L_RAM_SIZE = 6
)
(
    // clk/reset
    input aclk,
    input aresetn,
    // port A
    input [31:0] ain,
    // port B
    input [31:0] bin,
    // integrated valid signal
    input valid
    // computation result
    output dvalid,
    output [31:0] dout
);

endmodule