`default_nettype none			//disable implicit definitions by Verilog

module top(				//top module and signals wired to FPGA pins
	CLK100MHz,
	vga_r,
	vga_g,
	vga_b,
	vga_hs,
	vga_vs
);

input			CLK100MHz;	// Oscillator input 100Mhz
output  [1:0]   	vga_r;		// VGA Red 2 bit
output  [1:0]   	vga_g;		// VGA Green 2 bit
output  [1:0]   	vga_b;		// VGA Blue 2 bit
output          	vga_hs;		// H-sync pulse 
output          	vga_vs;		// V-sync pulse


parameter h_pulse   = 96;	//H-SYNC pulse width 96 * 40 ns (25 Mhz) = 3.84 uS
parameter h_bp      = 48;	//H-BP back porch pulse width
parameter h_pixels  = 640;	//H-PIX Number of pixels horizontally
parameter h_fp      = 16;	//H-FP front porch pulse width
parameter h_pol     = 1'b0;	//H-SYNC polarity
parameter h_frame   = 800;	//800 = 96 (H-SYNC) + 48 (H-BP) + 640 (H-PIX) + 16 (H-FP)
parameter v_pulse   = 2;	//V-SYNC pulse width
parameter v_bp      = 33;	//V-BP back porch pulse width
parameter v_pixels  = 480;	//V-PIX Number of pixels vertically
parameter v_fp      = 10;	//V-FP front porch pulse width
parameter v_pol     = 1'b1;	//V-SYNC polarity
parameter v_frame   = 525;	// 525 = 2 (V-SYNC) + 33 (V-BP) + 480 (V-PIX) + 10 (V-FP)

reg	[1:0]		clk_div;	// 2 bit counter
wire			vga_clk;	

assign 	vga_clk 	= clk_div[1];		// 25Mhz clock = 100Mhz divided by 2-bit counter

always @ (posedge CLK100MHz) begin		// 2-bt counter ++ on each positive edge of 100Mhz clock
	clk_div <= clk_div + 2'b1;
end

reg     [2:0]   	vga_r_r;	//VGA color registers R,G,B x 3 bit
reg     [2:0]   	vga_g_r;
reg     [2:0]   	vga_b_r;
reg             	vga_hs_r;	//H-SYNC register
reg             	vga_vs_r;	//V-SYNC register

assign 	vga_r 		= vga_r_r;		//assign the output signals for VGA to the VGA registers
assign 	vga_g 		= vga_g_r;
assign 	vga_b 		= vga_b_r;
assign 	vga_hs 		= vga_hs_r;
assign 	vga_vs 		= vga_vs_r;

reg     [7:0]		timer_t = 8'b0;	// 8 bit timer with 0 initialization
reg             	reset = 1;	
reg     [9:0]   	c_row;		//complete frame register row
reg     [9:0]   	c_col;		//complete frame register column
reg     [9:0]   	c_hor;		//visible frame register horizontally
reg     [9:0]   	c_ver;		//visible  frame register vertically

reg			disp_en;	//display enable flag

reg [1:0] dout;
framebuffer framebuff (
    .din(0),
    .write_en(1),
    .waddr(c_row),
    .wclk(vga_clk),
    .raddr(c_row), 
    .rclk(vga_clk), 
    .dout(dout)
);

always @ (posedge vga_clk) begin				//25Mhz clock

	if(timer_t > 250) begin					// generate 10 uS RESET signal 
		reset <= 0;
	end
	else begin
		reset <= 1;					//while in reset display is disabled, suare is set to initial position
		timer_t <= timer_t + 1;
		disp_en <= 0;
	end
	
	if(reset == 1) begin					//while RESET is high init counters
		c_hor <= 0;
		c_ver <= 0;
		vga_hs_r <= 1;
		vga_vs_r <= 0;
		c_row <= 0;
		c_col <= 0;
	end
	else begin						// update current beam position
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
	if(c_hor < h_pixels + h_fp + 1 || c_hor > h_pixels + h_fp + h_pulse) begin	// H-SYNC generator
		vga_hs_r <= ~h_pol;
	end
	else begin
		vga_hs_r <= h_pol;
	end
	if(c_ver < v_pixels + v_fp || c_ver > v_pixels + v_fp + v_pulse) begin		//V-SYNC generator
		vga_vs_r <= ~v_pol;
	end
	else begin
		vga_vs_r <= v_pol;
	end
	if(c_hor < h_pixels) begin		//c_col and c_row counters are updated only in the visible time-frame
		c_col <= c_hor;
	end
	if(c_ver < v_pixels) begin
		c_row <= c_ver;
	end
	if(c_hor < h_pixels && c_ver < v_pixels) begin		//VGA color signals are enabled only in the visible time frame
		disp_en <= 1;
	end
	else begin
		disp_en <= 0;
	end

	if(disp_en == 1 && reset == 0) begin
		if(c_row == 0 || c_col == 0 || c_row == v_pixels-1 || c_col == h_pixels-1) begin	//generate red frame with size 640x480
			vga_r_r <= 7;
			vga_g_r <= 0;
			vga_b_r <= 0;
		end
		// else if(c_col > l_sq_pos_x && c_col < r_sq_pos_x && c_row > u_sq_pos_y && c_row < d_sq_pos_y) begin	//generate blue square
		// 	vga_r_r <= 7;
		// 	vga_g_r <= 0;
		// 	vga_b_r <= 7;
		// end
		else begin			//everything else is black
			vga_r_r <= dout;
			vga_g_r <= dout;
			vga_b_r <= dout;
		end
	end
	else begin			//when display is not enabled everything is black
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