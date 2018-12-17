SELF_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

include $(SELF_DIR)/../Makefile

flash-blink:
	@make flash V=blink.v TOP=blink PCF=blink.pcf

flash-frame_counter:
	@make flash V=frame_counter.v TOP=frame_counter PCF=frame_counter.pcf

