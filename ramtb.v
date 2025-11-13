module ramtb;
    reg clk_t, rst_t, en_t;
    reg [7:0] datain_t;
    reg [9:0] address_t;
    wire [7:0] dataout_t;

    ram dut(.clk(clk_t), .rst(rst_t), .en(en_t), .datain(datain_t),
            .address(address_t), .dataout(dataout_t));

    initial begin
        clk_t = 1'b0;
        rst_t = 1'b1;
        #100 rst_t = 1'b0;
        en_t = 1'b1;
        address_t = 10'd800;
        datain_t = 8'd50;
        #100 address_t = 10'd900;
        datain_t = 8'd60;
        #100 en_t = 1'b0;
        address_t = 10'd800;
        #100 address_t = 10'd900;
    end

    always #10 clk_t = ~clk_t;

endmodule
