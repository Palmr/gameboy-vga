`default_nettype none

module top(
    input [1:0] GB_DAT,         // GB pixel data 2 bit
    input wire GB_HSYNC,        // GB HSYNC
    input wire GB_VSYNC,        // GB VSYNC
    input wire GB_PX_CLK,       // GB pixel clock

    input wire CLK_16MHz,       // Oscillator input 16Mhz

    output [1:0] vga_r,         // VGA Red 2 bit
    output [1:0] vga_g,         // VGA Green 2 bit
    output [1:0] vga_b,         // VGA Blue 2 bit
    output wire vga_hs,         // H-sync pulse 
    output wire vga_vs          // V-sync pulse
);

    parameter h_pulse   = 96;   // H-SYNC pulse width 96 * 40 ns (25 Mhz) = 3.84 uS
    parameter h_bp      = 48;   // H-BP back porch pulse width
    parameter h_pixels  = 640;  // H-PIX Number of pixels horizontally
    parameter h_fp      = 16;   // H-FP front porch pulse width
    parameter h_pol     = 1'b0; // H-SYNC polarity
    parameter h_frame   = 800;  // 800 = 96 (H-SYNC) + 48 (H-BP) + 640 (H-PIX) + 16 (H-FP)
    parameter v_pulse   = 2;    // V-SYNC pulse width
    parameter v_bp      = 33;   // V-BP back porch pulse width
    parameter v_pixels  = 480;  // V-PIX Number of pixels vertically
    parameter v_fp      = 10;   // V-FP front porch pulse width
    parameter v_pol     = 1'b1; // V-SYNC polarity
    parameter v_frame   = 525;  // 525 = 2 (V-SYNC) + 33 (V-BP) + 480 (V-PIX) + 10 (V-FP)

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

    reg [7:0]   timer_t = 8'b0; // 8 bit timer with 0 initialization
    reg         reset = 1;    
    reg [9:0]   c_row;          // Complete frame register row
    reg [9:0]   c_col;          // Complete frame register column
    reg [9:0]   c_hor;          // Visible frame register horizontally
    reg [9:0]   c_ver;          // Visible  frame register vertically

    reg disp_en;    //Display enable flag

    reg [14:0] gb_pixel_per_vsync = 15'b0;

    reg [14:0] gb_pixel_count = 15'b0;
    reg GB_VSYNC_RESET = 1'b0;
    reg LAST_GB_VSYNC_RESET = 1'b0;
    always @(negedge GB_PX_CLK) begin
        if (GB_VSYNC_RESET == ~LAST_GB_VSYNC_RESET)
        begin
            gb_pixel_per_vsync <= gb_pixel_count;
            gb_pixel_count <= 0;
            LAST_GB_VSYNC_RESET <= GB_VSYNC_RESET;
        end
        else begin
            gb_pixel_count <= gb_pixel_count + 1;
        end
    end
    always @(negedge GB_VSYNC)
    begin
        GB_VSYNC_RESET <= ~GB_VSYNC_RESET;
    end

    reg [14:0] fb_addr = 15'b0;
    reg [1:0] fb_out;
    framebuffer fb (
        .din(GB_DAT),
        .write_en(1),
        .waddr(gb_pixel_count),
        .wclk(GB_PX_CLK),
        .raddr(fb_addr), 
        .rclk(CLK_25MHz), 
        .dout(fb_out)
    );

    always @(posedge CLK_25MHz) begin   // 25Mhz clock
        if(timer_t > 250) begin         // generate 10 uS RESET signal 
            reset <= 0;
        end
        else begin
            reset <= 1;                 // While in reset display is disabled, suare is set to initial position
            timer_t <= timer_t + 1;
            disp_en <= 0;
        end
        
        if(reset == 1) begin            // While RESET is high init counters
            c_hor <= 0;
            c_ver <= 0;
            vga_hs_r <= 1;
            vga_vs_r <= 0;
            c_row <= 0;
            c_col <= 0;
        end
        else begin                      // Update current beam position
            if(c_hor < h_frame - 1) begin
                c_hor <= c_hor + 1;
            end
            else begin
                c_hor <= 0;
                if(c_ver < v_frame - 1) begin
                    c_ver <= c_ver + 1;
                end
                else begin
                    c_ver <= 0;
                end
            end
        end
        if(c_hor < h_pixels + h_fp + 1 || c_hor > h_pixels + h_fp + h_pulse) begin  // H-SYNC generator
            vga_hs_r <= ~h_pol;
        end
        else begin
            vga_hs_r <= h_pol;
        end
        if(c_ver < v_pixels + v_fp || c_ver > v_pixels + v_fp + v_pulse) begin      // V-SYNC generator
            vga_vs_r <= ~v_pol;
        end
        else begin
            vga_vs_r <= v_pol;
        end
        if(c_hor < h_pixels) begin  // c_col and c_row counters are updated only in the visible time-frame
            c_col <= c_hor;
        end
        if(c_ver < v_pixels) begin
            c_row <= c_ver;
        end
        if(c_hor < h_pixels && c_ver < v_pixels) begin  // VGA color signals are enabled only in the visible time frame
            disp_en <= 1;
        end
        else begin
            disp_en <= 0;
        end

        if(disp_en == 1 && reset == 0) begin
            fb_addr = c_hor + (c_ver * 160);
            
            if (c_hor < 161 && c_ver < 145) begin
                    vga_r_r <= ~fb_out;
                    vga_g_r <= ~fb_out;
                    vga_b_r <= ~fb_out;
            end
            else if (c_hor[9:5] < 15 && c_ver >= 145 && c_ver < 185) begin
                if (c_ver >= 145 && c_ver < 165) begin
                    if (c_ver == 145 || c_ver == 164) begin
                        vga_r_r <= {0, c_hor[5]};
                        vga_g_r <= {0, ~c_hor[5]};
                        vga_b_r <= 0;
                    end
                    else begin
                        // Show pixels per vsync
                        vga_r_r <= gb_pixel_per_vsync[14 - c_hor[9:5]] << 1;
                        vga_g_r <= gb_pixel_per_vsync[14 - c_hor[9:5]] << 1;
                        vga_b_r <= gb_pixel_per_vsync[14 - c_hor[9:5]] << 1;
                    end
                end
            end
            else begin
                vga_r_r <= 0;
                vga_g_r <= 0;
                vga_b_r <= 0;
            end

        end
        else begin  // When display is not enabled everything is black
            vga_r_r <= 0;
            vga_g_r <= 0;
            vga_b_r <= 0;
        end

    end

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

    always @(negedge wclk) // Write memory.
    begin
        if (write_en)
            mem[waddr] <= din; // Using write address bus.
    end

    always @(posedge rclk) // Read memory.
    begin
        dout <= mem[raddr]; // Using read address bus.
    end
endmodule
