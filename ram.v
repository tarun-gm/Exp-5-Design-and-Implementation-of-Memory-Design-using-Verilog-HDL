
module ram(
    input clk,
    input rst,
    input en,
    input [7:0] datain,
    input [9:0] address,
    output reg [7:0] dataout
);

    reg [7:0] mem_1kb_ram [1023:0];

    always @(posedge clk) begin
        if (rst)
            dataout <= 8'b0;
        else if (en)
            mem_1kb_ram[address] <= datain;
        else
            dataout <= mem_1kb_ram[address];
    end

endmodule
