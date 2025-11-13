# Exp-5-Design-and-Simulate the-Memory-Design-using-Verilog-HDL
# Aim
To design and simulate a RAM,ROM,FIFO using Verilog HDL, and verify its functionality through a testbench in the Vivado 2023.1 environment.
Apparatus Required
Vivado 2023.1
Procedure
1. Launch Vivado 2023.1
Open Vivado and create a new project.
2. Design the Verilog Code
Write the Verilog code for the RAM,ROM,FIFO
3. Create the Testbench
Write a testbench to simulate the memory behavior. The testbench should apply various and monitor the corresponding output.
4. Create the Verilog Files
Create both the design module and the testbench in the Vivado project.
5. Run Simulation
Run the behavioral simulation to verify the output.
6. Observe the Waveforms
Analyze the output waveforms in the simulation window, and verify that the correct read and write operation.
7. Save and Document Results
Capture screenshots of the waveform and save the simulation logs. These will be included in the lab report.

# Code
# RAM
// Verilog code
```

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
```

// Test bench
```
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
```

// output Waveform
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/e2848434-d6fd-4550-ad06-8e3add6d859a" />

# ROM
 // write verilog code for ROM using $random
 ```

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
```
 // Test bench
 ```
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
```

// output Waveform
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/b2ef58ea-a53d-47a6-9076-2ce2a045b721" />

 # FIFO
 // write verilog code for FIFO
 ```

module fifo #(parameter DEPTH = 8, DATA_WIDTH = 8) (
    input clk,
    input rst_n,
    input w_en,
    input r_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output full,
    output empty
);

    reg [$clog2(DEPTH)-1:0] w_ptr, r_ptr;
    reg [DATA_WIDTH-1:0] fifo [DEPTH-1:0];

    always @(posedge clk) begin
        if (!rst_n) begin
            w_ptr <= 0;
            r_ptr <= 0;
            data_out <= 0;
        end
    end

    always @(posedge clk) begin
        if (w_en & !full) begin
            fifo[w_ptr] <= data_in;
            w_ptr <= w_ptr + 1;
        end
    end

    always @(posedge clk) begin
        if (r_en & !empty) begin
            data_out <= fifo[r_ptr];
            r_ptr <= r_ptr + 1;
        end
    end

    assign full  = ((w_ptr + 1'b1) == r_ptr);
    assign empty = (w_ptr == r_ptr);

endmodule
```
// Test bench
```
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
```
// output Waveform
<img width="1918" height="1079" alt="image" src="https://github.com/user-attachments/assets/ca6b40ce-ffca-4fc2-9d78-7f5b53f7584e" />



# Conclusion
The RAM, ROM, FIFO memory with read and write operations was designed and successfully simulated using Verilog HDL. The testbench verified both the write and read functionalities by simulating the memory operations and observing the output waveforms. The experiment demonstrates how to implement memory operations in Verilog, effectively modeling both the reading and writing processes.
 
 

