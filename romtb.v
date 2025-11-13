module romtb;
    reg clk_t, rst_t;
    reg [9:0] address_t;
    wire [7:0] dataout_t;

    rom dut(.clk(clk_t), .rst(rst_t), .address(address_t), .dataout(dataout_t));

    initial begin
        clk_t = 1'b0;
        rst_t = 1'b1;
        #100 rst_t = 1'b0;
        address_t = 10'd700;
        #100 address_t = 10'd800;
        #100 address_t = 10'd900;
    end

    always #10 clk_t = ~clk_t;

endmodule
