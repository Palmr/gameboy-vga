module vga (
    clk,
    vga_pixel_active,
    vga_x,
    vga_y,
    vga_hsync,
    vga_vsync
);
    parameter h_pixels  = 640;  // H-PIX Number of pixels horizontally
    parameter v_pixels  = 480;  // V-PIX Number of pixels vertically

    parameter h_pulse   = 96;   // H-SYNC pulse width 96 * 40 ns (25 Mhz) = 3.84 uS
    parameter h_bp      = 48;   // H-BP back porch pulse width
    parameter h_fp      = 16;   // H-FP front porch pulse width
    parameter h_pol     = 1'b0; // H-SYNC polarity
    parameter h_frame   = 800;  // 800 = 96 (H-SYNC) + 48 (H-BP) + 640 (H-PIX) + 16 (H-FP)
    parameter v_pulse   = 2;    // V-SYNC pulse width
    parameter v_bp      = 33;   // V-BP back porch pulse width
    parameter v_fp      = 10;   // V-FP front porch pulse width
    parameter v_pol     = 1'b1; // V-SYNC polarity
    parameter v_frame   = 525;  // 525 = 2 (V-SYNC) + 33 (V-BP) + 480 (V-PIX) + 10 (V-FP)

    input  wire  clk;
    output wire  vga_pixel_active;
    output [9:0] vga_x;
    output [9:0] vga_y;
    output wire  vga_hsync;
    output wire  vga_vsync;

    reg [7:0]   timer_t = 8'b0; // 8 bit timer with 0 initialization
    reg         reset = 1;
    reg [9:0]   c_row_r;          // Complete frame register row
    reg [9:0]   c_col_r;          // Complete frame register column
    reg [9:0]   c_hor_r;          // Visible frame register horizontally
    reg [9:0]   c_ver_r;          // Visible frame register vertically

    reg         disp_en; // 
    reg         vga_hs_r;           // H-SYNC register
    reg         vga_vs_r;           // V-SYNC register

    assign  vga_pixel_active   = disp_en == 1 & reset == 0;  // Assign the output signals for VGA to the VGA registers
    assign  vga_x   = c_col_r;
    assign  vga_y   = c_row_r;
    assign  vga_hsync  = vga_hs_r;
    assign  vga_vsync  = vga_vs_r;

    always @(posedge clk) begin   // 25Mhz clock
        if(timer_t > 250) begin         // generate 10 uS RESET signal 
            reset <= 0;
        end
        else begin
            reset <= 1;                 // While in reset display is disabled, suare is set to initial position
            timer_t <= timer_t + 1;
            disp_en <= 0;
        end
        
        if(reset == 1) begin            // While RESET is high init counters
            c_hor_r <= 0;
            c_ver_r <= 0;
            vga_hs_r <= 1;
            vga_vs_r <= 0;
            c_row_r <= 0;
            c_col_r <= 0;
        end
        else begin                      // Update current beam position
            if(c_hor_r < h_frame - 1) begin
                c_hor_r <= c_hor_r + 1;
            end
            else begin
                c_hor_r <= 0;
                if(c_ver_r < v_frame - 1) begin
                    c_ver_r <= c_ver_r + 1;
                end
                else begin
                    c_ver_r <= 0;
                end
            end
        end
        if(c_hor_r < h_pixels + h_fp + 1 || c_hor_r > h_pixels + h_fp + h_pulse) begin  // H-SYNC generator
            vga_hs_r <= ~h_pol;
        end
        else begin
            vga_hs_r <= h_pol;
        end
        if(c_ver_r < v_pixels + v_fp || c_ver_r > v_pixels + v_fp + v_pulse) begin      // V-SYNC generator
            vga_vs_r <= ~v_pol;
        end
        else begin
            vga_vs_r <= v_pol;
        end
        if(c_hor_r < h_pixels) begin  // c_col_r and c_row_r counters are updated only in the visible time-frame
            c_col_r <= c_hor_r;
        end
        if(c_ver_r < v_pixels) begin
            c_row_r <= c_ver_r;
        end
        if(c_hor_r < h_pixels && c_ver_r < v_pixels) begin  // VGA color signals are enabled only in the visible time frame
            disp_en <= 1;
        end
        else begin
            disp_en <= 0;
        end

    end

endmodule