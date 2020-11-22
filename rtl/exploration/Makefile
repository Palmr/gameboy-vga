SELF_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

include $(SELF_DIR)/../Makefile

flash-blink:
	@make flash V=blink.v TOP=blink PCF=blink.pcf

flash-frame_counter:
	@make flash V=frame_counter.v TOP=frame_counter PCF=frame_counter.pcf

flash-pixels_per_frame_counter:
	@make flash V=pixels_per_frame_counter.v TOP=pixels_per_frame_counter PCF=pixels_per_frame_counter.pcf

flash-vga_test:
	@make flash V=vga_test.v PCF=vga_test.pcf

flash-vga_frame_buffer_test:
	@make flash V=vga_frame_buffer_test.v PCF=vga_frame_buffer_test.pcf

flash-uart:
	@make flash V=uart.v TOP=transmit_hello PCF=uart.pcf

