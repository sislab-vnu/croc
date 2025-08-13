all: sram_wrapper
VSIM_OPTS := -voptargs="+acc" -debugdb=tb_sram_wrapper.dbg -postsimdataflow -wlf tb_sram_wrapper.wlf +notimingchecks +nospecify
VSIM_CMD := log -r /*; run -all; quit -f
SRAM_VERILOG_DIR := $(PDK_ROOT)/$(PDK)/libs.ref/gf180mcu_fd_ip_sram/verilog
GF180MCU_SRAM_VERILOG_FILES  = $(SRAM_VERILOG_DIR)/gf180mcu_fd_ip_sram__sram64x8m8wm1.v
GF180MCU_SRAM_VERILOG_FILES += $(SRAM_VERILOG_DIR)/gf180mcu_fd_ip_sram__sram128x8m8wm1.v
GF180MCU_SRAM_VERILOG_FILES += $(SRAM_VERILOG_DIR)/gf180mcu_fd_ip_sram__sram256x8m8wm1.v
GF180MCU_SRAM_VERILOG_FILES += $(SRAM_VERILOG_DIR)/gf180mcu_fd_ip_sram__sram512x8m8wm1.v

sram_wrapper:
	vlib work
	vmap work work
	vlog +acc $(GF180MCU_SRAM_VERILOG_FILES)
	vlog +acc -sv \
		gf180mcu_sram_wrapper.sv \
	     	tb_sram_wrapper.sv
	vsim $(VSIM_OPTS) work.tb_sram_wrapper -c -do "$(VSIM_CMD)"
tc_sram_impl:
	vlib work
	vmap work work
	vlog +acc $(GF180MCU_SRAM_VERILOG_FILES)
	vlog +acc -sv \
		gf180mcu_sram_wrapper.sv \
	     	tc_sram_impl.sv
	vsim $(VSIM_OPTS) work.tc_sram_impl
