`timescale 1ns / 1ps

module top(
    input wire D0,
    input wire D1,
    input wire HSYNC,
    input wire VSYNC,
    input wire PX_CLK,
    input wire CLK_3P3_MHZ
);
    reg [14:0] pixel_count = 15'b0;
    reg [1:0] data_in;

    always @(negedge PX_CLK) begin
        data_in = {D0, D1}; 

        pixel_count <= pixel_count + 1;
    end

    // framebuffer framebuff (
    //     .din(data_in),
    //     .write_en(1),
    //     .waddr(waddr),
    //     .wclk(PX_CLK),
    //     .raddr(), 
    //     .rclk(), 
    //     .dout()
    // );

endmodule

module framebuffer (din, write_en, waddr, wclk, raddr, rclk, dout);
    parameter addr_width = 15;
    parameter data_width = 2;//2042x2 block config

    input [addr_width-1:0] waddr, raddr;
    input [data_width-1:0] din;
    input write_en, wclk, rclk;

    output reg [data_width-1:0] dout;

    localparam pixel_count = 160 * 144;
    reg [data_width-1:0] mem [pixel_count-1:0];

    always @(posedge wclk) // Write memory.
    begin
        if (write_en)
            mem[waddr] <= din; // Using write address bus.
    end

    always @(posedge rclk) // Read memory.
    begin
        dout <= mem[raddr]; // Using read address bus.
    end
endmodule
