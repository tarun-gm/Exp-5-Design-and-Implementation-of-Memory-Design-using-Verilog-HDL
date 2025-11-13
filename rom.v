
module rom(
    input clk,
    input rst,
    input [9:0] address,
    output reg [7:0] dataout
);

    reg [7:0] mem_1kb_rom [1023:0];
    integer i;

    initial begin
        for (i = 0; i < 1024; i = i + 1)
            mem_1kb_rom[i] = $random;
    end

    always @(posedge clk) begin
        if (rst)
            dataout <= 8'b0;
        else
            dataout <= mem_1kb_rom[address];
    end

endmodule
