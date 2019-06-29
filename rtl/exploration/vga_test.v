`default_nettype none

`include "../vga.v"

module top(
    input wire CLK_16MHz,       // Oscillator input 16Mhz

    output [1:0] vga_r,         // VGA Red 2 bit
    output [1:0] vga_g,         // VGA Green 2 bit
    output [1:0] vga_b,         // VGA Blue 2 bit
    output wire vga_hs,         // H-sync pulse 
    output wire vga_vs          // V-sync pulse
);
    // IO registers
    reg [1:0]   vga_r_r;    // VGA color registers R,G,B x 2 bit
    reg [1:0]   vga_g_r;
    reg [1:0]   vga_b_r;
    reg         vga_hs_r;   // H-SYNC register
    reg         vga_vs_r;   // V-SYNC register

    assign  vga_r   = vga_r_r;  // Assign the output signals for VGA to the VGA registers
    assign  vga_g   = vga_g_r;
    assign  vga_b   = vga_b_r;
    assign  vga_hs  = vga_hs_r;
    assign  vga_vs  = vga_vs_r;

    // VGA Pixel clock
    wire CLK_25MHz;             // 25MHz clock
    /**
    * PLL configuration
    *
    * This Verilog module was generated automatically
    * using the icepll tool from the IceStorm project.
    * Use at your own risk.
    *
    * Given input frequency:        16.000 MHz
    * Requested output frequency:   25.000 MHz
    * Achieved output frequency:    25.000 MHz
    */
    SB_PLL40_CORE #(
        .FEEDBACK_PATH("SIMPLE"),
        .DIVR(4'b0000),        // DIVR =  0
        .DIVF(7'b0110001),    // DIVF = 49
        .DIVQ(3'b101),        // DIVQ =  5
        .FILTER_RANGE(3'b001)    // FILTER_RANGE = 1
    ) uut (
        // .LOCK(locked),
        .RESETB(1'b1),
        .BYPASS(1'b0),
        .REFERENCECLK(CLK_16MHz),
        .PLLOUTCORE(CLK_25MHz)
    );

    // VGA module registers
    reg [9:0] vga_x;         // X coord
    reg [9:0] vga_y;         // Y coord
    reg vga_pixel_active;    // Display enable flag

    vga vga1(
        .clk(CLK_25MHz),                    // The master clock for this module
        .vga_pixel_active(vga_pixel_active),
        .vga_x(vga_x),
        .vga_y(vga_y),
        .vga_hsync(vga_hs_r),
        .vga_vsync(vga_vs_r)
        );

    always @(posedge CLK_25MHz) begin
        if(vga_pixel_active == 1) begin
            if (vga_x == 0 || vga_x == 639 || vga_y == 0 || vga_y == 479) begin
                vga_r_r = 2'b11;
                vga_g_r = 2'b00;
                vga_b_r = 2'b11;
            end
            else begin
                vga_r_r <= vga_x[4:3];
                vga_g_r <= vga_y[4:3];
                vga_b_r <= ~{vga_x[4], vga_y[4]};
            end
        end
        else begin  // When display is not enabled everything is black
            vga_r_r <= 0;
            vga_g_r <= 0;
            vga_b_r <= 0;
        end
    end

endmodule