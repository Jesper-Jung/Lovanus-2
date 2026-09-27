
TB_TOP			?= lovanus_core

BUILD_TARGET	?= FPGA				# SIM, FPGA, ASIC 중 택 1
FPGA_BOARD		?= TANG_20K			# DE10_NANO, TANG_20K, ICEBREAKER 등
ASIC_TECH		?=					# 

LOG_DIR 		= ./log
REPORT_DIR 		= ./report
DUMP_DIR 		= ./dump

INC_FILE 		= ./include/include_rtl.f


