module my_bram # (
    parameter integer BRAM_ADDR_WIDTH = 15, // 4x8192
    parameter INIT_FILE = "input.txt",
    parameter OUT_FILE = "output.txt"
)(
    input wire [BRAM_ADDR_WIDTH-1:0] BRAM_ADDR,
    input wire BRAM_CLK,
    input wire [31:0] BRAM_WRDATA,
    output reg [31:0] BRAM_RDDATA,
    input wire BRAM_EN,
    input wire BRAM_RST,
    input wire [3:0] BRAM_WE,
    input wire done
);
    reg [31:0] mem[0:8191];
    wire [BRAM_ADDR_WIDTH-3:0] addr = BRAM_ADDR[BRAM_ADDR_WIDTH-1:2];
    reg [31:0] dout;
    genvar i;
    // code for reading & writing
    initial begin
        if (INIT_FILE != "") begin
            // read data from INIT_FILE and store them into mem
            $readmemh(INIT_FILE, mem);
        end
        wait (done)
        // write data stored in mem into OUT_FILE
        $writememh(OUT_FILE, mem);        
    end

    always @(posedge BRAM_CLK) begin
        if (BRAM_EN == 1) begin
            if (BRAM_RST == 1) begin
                BRAM_RDDATA = 0;
            end else if (BRAM_WE == 4'b0000) begin
                assign BRAM_RDDATA = mem[addr];
            end else begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (BRAM_WE[i] == 1)
                        mem[addr][8 * (i + 1) - 1:8 * i] = BRAM_WRDATA[8 * (i + 1) - 1:8 * i];
                end
            end 
        end
    end
    //code for BRAM implementation
    
endmodule