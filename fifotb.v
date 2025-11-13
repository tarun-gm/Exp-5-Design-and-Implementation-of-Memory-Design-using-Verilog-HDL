module fifotb;
    reg clk_t, rst_t;
    reg w_en_t, r_en_t;
    reg [7:0] data_in_t;
    wire [7:0] data_out_t;
    wire full_t, empty_t;

    fifo dut (
        .clk(clk_t),
        .rst_n(rst_t),
        .w_en(w_en_t),
        .r_en(r_en_t),
        .data_in(data_in_t),
        .data_out(data_out_t),
        .full(full_t),
        .empty(empty_t)
    );

    always #10 clk_t = ~clk_t;

    initial begin
        clk_t = 1'b0;
        rst_t = 1'b0;
        w_en_t = 1'b0;
        r_en_t = 1'b0;
        data_in_t = 8'd0;

        #50 rst_t = 1'b1;
        #20 w_en_t = 1'b1; data_in_t = 8'd10;
        #20 data_in_t = 8'd20;
        #20 data_in_t = 8'd30;
        #20 data_in_t = 8'd40;
        #20 w_en_t = 1'b0;
        #40 r_en_t = 1'b1;
        #100 r_en_t = 1'b0;
    end

endmodule
