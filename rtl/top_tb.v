`include "top.v"

// Testbench
module test;
  reg        pixel_clk;
  reg        vsync;
  reg        hsync;
  reg  [1:0] data_in;

  integer ii=0;
  
  // Instantiate design under test
  top top (
    .D0(data_in[0]),
    .D1(data_in[1]),
    .HSYNC(hsync),
    .VSYNC(vsync),
    .PX_CLK(pixel_clk),
    .CLK_3P3_MHZ(pixel_clk)
    );
  
  initial begin
    // Dump waves
    $dumpfile(`VCD_FILE);
    $dumpvars;
        
    pixel_clk = 1;
    vsync = 0;
    hsync = 0;

    data_in = 2'b00;
    toggle_pixel_clk;

    data_in = 2'b01;
    toggle_pixel_clk;

    data_in = 2'b10;
    toggle_pixel_clk;

    data_in = 2'b11;
    toggle_pixel_clk;

    for(ii=0; ii<160*144*2; ii=ii+1)
    begin
        data_in = $urandom % 3;
        toggle_pixel_clk;
    end
  end

  task toggle_pixel_clk;
    begin
      #10 pixel_clk = ~pixel_clk;
      #10 pixel_clk = ~pixel_clk;
    end
  endtask
endmodule