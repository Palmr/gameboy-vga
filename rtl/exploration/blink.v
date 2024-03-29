// Attempting to find the best counter variable to get 1second toggling of an LED for FPS count testing

// make flash V=blink.v TOP=blink PCF=blink.pcf BOARD=bx
module blink (
    input wire CLK16MHz,
    output wire BLINK_PIN
);

    parameter CLOCKS_PER_SEC   = 15998100; // Gets +-5us from 1s
    reg [31:0] CLOCK_COUNTER = 0;
    reg LED_STATE = 0;
  
    always @ (posedge CLK16MHz)
    begin
        if (CLOCK_COUNTER == CLOCKS_PER_SEC-1) // -1, since counter starts at 0
        begin        
            LED_STATE <= ~LED_STATE; // toggle LED
            CLOCK_COUNTER <= 0;
        end
        else
            CLOCK_COUNTER <= CLOCK_COUNTER + 1;
    end
  
    assign BLINK_PIN = LED_STATE;

endmodule