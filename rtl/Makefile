BOARD = bx
PCF = gb-framebuffer.pcf
SELF_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
VERBOSE = true

include $(SELF_DIR)/../fpga-tools/fpga.mk

flash-gb-framebuffer:
	@make flash V=gb-framebuffer.v TOP=top PCF=gb-framebuffer.pcf
