`default_nettype none

`include "../vga.v"

module top(
    input wire CLK_16MHz,       // Oscillator input 16Mhz
    input wire scaling_x2,      // GB framebuffer scaling

    output [1:0] vga_r,         // VGA Red 2 bit
    output [1:0] vga_g,         // VGA Green 2 bit
    output [1:0] vga_b,         // VGA Blue 2 bit
    output wire vga_hs,         // H-sync pulse 
    output wire vga_vs          // V-sync pulse
);
    parameter gb_h_pixels  = 160;
    parameter gb_v_pixels  = 144;
    parameter gb_pixel_data_width = 2;

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

    // Framebuffer
    reg [1:0] RDATA_r;
    reg WE_r = 0;
	reg [14:0] WADDR_r = 0;
    reg [1:0] WDATA_r = 2'b00;

    ram bram_buffer (
        .din(WDATA_r),
        .write_en(WE_r), 
        .waddr(WADDR_r), 
        .wclk(CLK_25MHz), 
        .raddr(read_addr),
        .rclk(CLK_25MHz), 
        .dout(RDATA_r)
    );

    reg [31:0] CLOCK_COUNTER = 0;
  
    always @ (posedge CLK_25MHz)
    begin
        WDATA_r <= WADDR_r[1:0];
        if (CLOCK_COUNTER == 10000)
        begin        
            WADDR_r <= WADDR_r - 1;
            CLOCK_COUNTER <= 0;
        end
        else
            CLOCK_COUNTER <= CLOCK_COUNTER + 1;
            WE_r <= 1;
    end

    reg [14:0] read_addr;
    localparam gb_pixel_count = gb_v_pixels * gb_h_pixels;

    // Scaling 
    reg [1:0] scaling = 1 << scaling_x2;
    reg [8:0] scaled_gb_h_pixels = gb_h_pixels * scaling;
    reg [8:0] scaled_gb_v_pixels = gb_v_pixels * scaling;
    reg [7:0] offset_x = (640 / 2) - (scaled_gb_h_pixels / 2);
    reg [7:0] offset_y = (480 / 2) - (scaled_gb_v_pixels / 2);

    always @(posedge CLK_25MHz) begin
        if(vga_pixel_active == 1) begin

            if (
                vga_x >= offset_x && vga_x < offset_x + scaled_gb_h_pixels && 
                vga_y >= offset_y && vga_y < offset_y + scaled_gb_v_pixels
            ) begin
                decode_gb_to_rgb(RDATA_r, vga_r_r, vga_g_r, vga_b_r);
                
                if (scaling == 1) begin
                    read_addr <= read_addr + 1;
                end else if (scaling == 2) begin
                    read_addr <= read_addr + vga_x[0];
                end
            end
            else if (
                scaling == 2 && 
                vga_x == offset_x + scaled_gb_h_pixels && 
                vga_y >= offset_y && vga_y < offset_y + scaled_gb_v_pixels &&
                vga_y[0] == 0
            ) begin
                read_addr <= read_addr - gb_h_pixels;

                vga_r_r <= 2'b11;
                vga_g_r <= 2'b00;
                vga_b_r <= 2'b00;
            end
            else if (
                vga_x == offset_x + scaled_gb_h_pixels && 
                vga_y == offset_y + scaled_gb_v_pixels
            ) begin
                read_addr <= 0;

                vga_r_r <= 2'b00;
                vga_g_r <= 2'b11;
                vga_b_r <= 2'b00;
            end
            else begin
                vga_r_r <= 2'b01;
                vga_g_r <= 2'b01;
                vga_b_r <= 2'b01;
            end
        end
        else begin  // When display is not enabled everything is black
            vga_r_r <= 0;
            vga_g_r <= 0;
            vga_b_r <= 0;
        end
    end

    task decode_gb_to_rgb (
        input  [1:0] data_in,
        output [1:0] data_out_r,
        output [1:0] data_out_g,
        output [1:0] data_out_b
    );
        begin
            data_out_r = ~data_in;
            data_out_g = ~data_in;
            data_out_b = ~data_in;
        end
    endtask

endmodule

module ram (
    din,
    write_en, 
    waddr, 
    wclk, 
    raddr,
    rclk, 
    dout
);
    parameter addr_width = 15;
    parameter data_width = 2;

    input [addr_width-1:0] waddr, raddr;
    input [data_width-1:0] din;
    input write_en, wclk, rclk;

    output reg [data_width-1:0] dout;

    reg [data_width-1:0] mem [(1<<addr_width)-1:0];
    initial $readmemb("vga_frame_buffer_160x144.bin", mem);

    always @(negedge wclk) // Write memory.
    begin
        if (write_en)
            mem[waddr] <= din; // Using write address bus.
    end

    always @(negedge rclk) // Read memory.
    begin
        dout <= mem[raddr]; // Using read address bus.
    end
endmodule
