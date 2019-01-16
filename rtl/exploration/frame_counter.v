// Count frames per second
module frame_counter (
    input wire CLK16MHz,
    input wire VSYNC,
    output reg [6:0] COUNT,
    output wire BLINK_PIN
);

    parameter CLOCKS_PER_SEC   = 15998100; // Gets +-5us from 1s
    reg [31:0] CLOCK_COUNTER = 0;
    reg LED_STATE = 0;

    reg [6:0] FRAME_COUNT = 0;
    wire RESET;
    wire LAST_RESET;
  
    always @ (posedge CLK16MHz)
    begin
        if (CLOCK_COUNTER == CLOCKS_PER_SEC-1) // -1, since counter starts at 0
            begin
                CLOCK_COUNTER <= 32'b0;
                RESET <= ~RESET;
                LED_STATE <= ~LED_STATE; // toggle LED
            end
        else
            begin
                CLOCK_COUNTER <= CLOCK_COUNTER + 1;
            end
    end

    always @(negedge VSYNC)
    begin
        if (RESET == ~LAST_RESET)
        begin
            FRAME_COUNT <= 8'b0;
            LAST_RESET <= RESET;
        end
        else
        begin
            FRAME_COUNT <= FRAME_COUNT + 1;
        end
    end

    assign COUNT = FRAME_COUNT;
    assign BLINK_PIN = LED_STATE;

endmodule