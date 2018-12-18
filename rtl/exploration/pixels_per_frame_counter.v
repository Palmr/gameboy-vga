// Count pizels per vsync
module pixels_per_frame_counter (
    input wire CLK_3P3_MHZ,
    input wire PIXEL_CLOCK,
    input wire VSYNC,
    output wire OUTPUT_ENABLED,
    output wire SERIAL_OUT
);

    reg [15:0] PIXEL_COUNT = 0;
    reg [15:0] SHIFT_OUT;

    wire FRAME_TOGGLE;
    wire LAST_FRAME_TOGGLE;

    reg [5:0] CLOCKING_OUT_COUNT;
    wire LAST_CLOCKING_FRAME_TOGGLE;
    // wire CLOCKING_OUT_ENABLE;
    assign SERIAL_OUT = SHIFT_OUT[15];
    // assign OUTPUT_ENABLED = CLOCKING_OUT_COUNT;
  
    always @ (negedge CLK_3P3_MHZ)
    begin
        if (FRAME_TOGGLE == ~LAST_CLOCKING_FRAME_TOGGLE) begin
            SHIFT_OUT <= PIXEL_COUNT;
            CLOCKING_OUT_COUNT <= 16;
            OUTPUT_ENABLED <= 1;
            LAST_CLOCKING_FRAME_TOGGLE <= FRAME_TOGGLE;
        end else if (CLOCKING_OUT_COUNT) begin
            CLOCKING_OUT_COUNT <= CLOCKING_OUT_COUNT - 1;
            SHIFT_OUT <= SHIFT_OUT << 1;
        end else begin
            OUTPUT_ENABLED <= 0;
        end
    end

    always @(negedge VSYNC)
    begin
        FRAME_TOGGLE <= ~FRAME_TOGGLE;
    end

    always @(negedge PIXEL_CLOCK)
    begin
        if (FRAME_TOGGLE == ~LAST_FRAME_TOGGLE)
        begin
            PIXEL_COUNT <= 8'b0;
            LAST_FRAME_TOGGLE <= FRAME_TOGGLE;
        end
        else
        begin
            PIXEL_COUNT <= PIXEL_COUNT + 1;
        end
    end

endmodule