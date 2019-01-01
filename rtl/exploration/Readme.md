# Exploratory RTL

While developing this I sometimes needed to try things out. This folder contains my files.

## blink.v

While doing some dumps of the LCD cable previously I noticed issues with the VSYNC signal. To investigate this further I wanted to get an FPS counter from the cable based on vsync signals seen per second.

I developed on an iCEblink40LP1K devkit which has a 3.33MHz clock by default, to get the "per second" figure to a reasonable degree of accuracy I wrote blink.v to toggle an LED every second.

I used a logic analyser to check how accurate the timing was and tweaked the CLOCKS_PER_SEC parameter to hone in on a 1 second LED_STATE toggle.

### Building

```bash
make flash-blink
```

## frame_counter.v

Counts VSYNC signal per second, outputting counter on pins [B26, B27, A38, B29, B30, B31, A43, B34] and the second toggle on LED4/pin A25

![Frame counter pulseview](./images/frame_counter_pulseview.png)

In the above screenshot I could confirm I was seeing 0x3B (59) frames per second.

### Building

```bash
make flash-frame_counter
```

## pixels_per_frame_counter.v

Counts PIXEL_CLOCK falling per VSYNC, outputting counter in serial form at the fpga clock rate.

![Pixels per frame counter pulseview](./images/pixels_per_frame_counter_pulseview.png)

In the above screenshot I could confirm I was seeing 0x59FF (23039 == (160*144) - 1) the expected number of pixels

### Building

```bash
make flash-pixels_per_frame_counter
```

## vga.v

Testing VGA from a framebuffer. The iCEblink40 board I currently have has a clock that goes up to 33.3Mhz but VGA needs a stable ~25Mhz pixel clock, which I can't create on this board. Currently waiting on a TinyFPGA BX to test this code out.

### Building

```bash
make flash-vga
```