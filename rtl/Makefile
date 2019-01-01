USE_SUDO = 1
BOARD = iceblink
PCF = gb-framebuffer.pcf
SELF_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

include $(SELF_DIR)/../fpga-tools/fpga.mk

flash-gb-framebuffer:
	@make flash V=top.v TOP=top PCF=gb-framebuffer.pcf
