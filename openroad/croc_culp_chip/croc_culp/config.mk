export YOSYS_EXE = $(shell which yosys)
export OPENROAD_EXE = $(shell which openroad)
export PROJECT_ROOT = .

export DESIGN_NAME = croc_culp
export TOP_DESIGN_NICKNAME = croc_culp_chip
export DESIGN_NICKNAME = ${TOP_DESIGN_NICKNAME}_${DESIGN_NAME}

export TRACK_OPTION    = 7t
export POWER_OPTION    = 5v0
export METAL_OPTION    = 5LM_1TM
export KVALUE          = 9

export PLATFORM        = gf180
export CORE_AREA = 15.12 15.68 2125.2 1889.44
export DIE_AREA = 0 0 2140.32 1905.12

# export PLACE_PINS_ARGS = -min_distance 50.0 -corner_avoidance 50.0

export FAST_LIB_FILES = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__ff_n40C_3v60.lib.gz) \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__ff_n40C_3v60.lib \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__ff_n40C_3v60.lib 
export FAST_TEMPERATURE = -40c
export FAST_VOLTAGE     = 3.6

export SLOW_LIB_FILES = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__ss_125C_3v00.lib.gz) \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__ss_125C_3v00.lib \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__ss_125C_3v00.lib

export SLOW_TEMPERATURE = 125c
export SLOW_VOLTAGE     = 3.0

export TYP_LIB_FILES = $(abspath $(PLATFORM_DIR)/lib/gf180mcu_fd_sc_mcu$(TRACK_OPTION)$(POWER_OPTION)__tt_025C_3v30.lib.gz) \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__tt_025C_3v30.lib \
			$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__tt_025C_3v30.lib

export TYP_TEMPERATURE = 25c
export TYP_VOLTAGE     = 3.3

export PDK_PATH = $(PDK_ROOT)/$(PDK)
export ADDITIONAL_LEFS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lef/gf180mcu_fd_ip_sram__sram256x8m8wm1.lef \
	$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lef/gf180mcu_fd_ip_sram__sram512x8m8wm1.lef

export ADDITIONAL_LIBS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram256x8m8wm1__tt_025C_5v00.lib \
		$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/lib/gf180mcu_fd_ip_sram__sram512x8m8wm1__tt_025C_5v00.lib
export ADDITIONAL_GDS = $(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/gds/gf180mcu_fd_ip_sram__sram256x8m8wm1.gds \
		$(PDK_PATH)/libs.ref/gf180mcu_fd_ip_sram/gds/gf180mcu_fd_ip_sram__sram512x8m8wm1.gds

export SDC_FILE        = $(DESIGN_NAME)/constraints.sdc

export MAX_ROUTING_LAYER = Metal4

export PDN_TCL = $(DESIGN_NAME)/pdn.tcl
export IO_CONSTRAINTS = $(DESIGN_NAME)/io.tcl
export MACRO_PLACEMENT_TCL = $(DESIGN_NAME)/macro_placement.tcl

export CORE_MARGIN       = 1

export PLACE_DENSITY = 0.45
export MACRO_PLACE_HALO = 10 10

export CORNERS = slow typ fast

ifeq ($(USE_FILL),1)
export DESIGN_TYPE = CELL
else
export DESIGN_TYPE = CELL_NODEN
endif

export VERILOG_INCLUDE_DIRS = ../../rtl/apb/include \
        ../../rtl/common_cells/include \
        ../../rtl/cve2/include \
        ../../rtl/obi/include \
        ../../rtl/register_interface/include

export VERILOG_DEFINES = -D TARGET_ASIC -D TARGET_GF180MCU -D TARGET_SYNTHESIS -D SYNTHESIS=1
export SYNTH_HDL_FRONTEND = slang
export VERILOG_FILES = ../../rtl/common_cells/binary_to_gray.sv \
../../rtl/common_cells/cb_filter_pkg.sv \
../../rtl/common_cells/cc_onehot.sv \
../../rtl/common_cells/cdc_reset_ctrlr_pkg.sv \
../../rtl/common_cells/cf_math_pkg.sv \
../../rtl/common_cells/clk_int_div.sv \
../../rtl/common_cells/credit_counter.sv \
../../rtl/common_cells/delta_counter.sv \
../../rtl/common_cells/ecc_pkg.sv \
../../rtl/common_cells/edge_propagator_tx.sv \
../../rtl/common_cells/exp_backoff.sv \
../../rtl/common_cells/fifo_v3.sv \
../../rtl/common_cells/gray_to_binary.sv \
../../rtl/common_cells/isochronous_4phase_handshake.sv \
../../rtl/common_cells/isochronous_spill_register.sv \
../../rtl/common_cells/lfsr.sv \
../../rtl/common_cells/lfsr_16bit.sv \
../../rtl/common_cells/lfsr_8bit.sv \
../../rtl/common_cells/lossy_valid_to_stream.sv \
../../rtl/common_cells/mv_filter.sv \
../../rtl/common_cells/onehot_to_bin.sv \
../../rtl/common_cells/plru_tree.sv \
../../rtl/common_cells/passthrough_stream_fifo.sv \
../../rtl/common_cells/popcount.sv \
../../rtl/common_cells/rr_arb_tree.sv \
../../rtl/common_cells/rstgen_bypass.sv \
../../rtl/common_cells/serial_deglitch.sv \
../../rtl/common_cells/shift_reg.sv \
../../rtl/common_cells/shift_reg_gated.sv \
../../rtl/common_cells/spill_register_flushable.sv \
../../rtl/common_cells/stream_demux.sv \
../../rtl/common_cells/stream_filter.sv \
../../rtl/common_cells/stream_fork.sv \
../../rtl/common_cells/stream_intf.sv \
../../rtl/common_cells/stream_join_dynamic.sv \
../../rtl/common_cells/stream_mux.sv \
../../rtl/common_cells/stream_throttle.sv \
../../rtl/common_cells/sub_per_hash.sv \
../../rtl/common_cells/sync.sv \
../../rtl/common_cells/sync_wedge.sv \
../../rtl/common_cells/unread.sv \
../../rtl/common_cells/read.sv \
../../rtl/common_cells/addr_decode_dync.sv \
../../rtl/common_cells/cdc_2phase.sv \
../../rtl/common_cells/cdc_4phase.sv \
../../rtl/common_cells/clk_int_div_static.sv \
../../rtl/common_cells/addr_decode.sv \
../../rtl/common_cells/addr_decode_napot.sv \
../../rtl/common_cells/multiaddr_decode.sv \
../../rtl/common_cells/cb_filter.sv \
../../rtl/common_cells/cdc_fifo_2phase.sv \
../../rtl/common_cells/clk_mux_glitch_free.sv \
../../rtl/common_cells/counter.sv \
../../rtl/common_cells/ecc_decode.sv \
../../rtl/common_cells/ecc_encode.sv \
../../rtl/common_cells/edge_detect.sv \
../../rtl/common_cells/lzc.sv \
../../rtl/common_cells/max_counter.sv \
../../rtl/common_cells/rstgen.sv \
../../rtl/common_cells/spill_register.sv \
../../rtl/common_cells/stream_delay.sv \
../../rtl/common_cells/stream_fifo.sv \
../../rtl/common_cells/stream_fork_dynamic.sv \
../../rtl/common_cells/stream_join.sv \
../../rtl/common_cells/cdc_reset_ctrlr.sv \
../../rtl/common_cells/cdc_fifo_gray.sv \
../../rtl/common_cells/fall_through_register.sv \
../../rtl/common_cells/id_queue.sv \
../../rtl/common_cells/stream_to_mem.sv \
../../rtl/common_cells/stream_arbiter_flushable.sv \
../../rtl/common_cells/stream_fifo_optimal_wrap.sv \
../../rtl/common_cells/stream_register.sv \
../../rtl/common_cells/stream_xbar.sv \
../../rtl/common_cells/cdc_fifo_gray_clearable.sv \
../../rtl/common_cells/cdc_2phase_clearable.sv \
../../rtl/common_cells/mem_to_banks_detailed.sv \
../../rtl/common_cells/stream_arbiter.sv \
../../rtl/common_cells/stream_omega_net.sv \
../../rtl/common_cells/mem_to_banks.sv \
../../rtl/apb/apb_pkg.sv \
../../rtl/obi/obi_pkg.sv \
../../rtl/obi/obi_intf.sv \
../../rtl/obi/obi_rready_converter.sv \
../../rtl/obi/obi_atop_resolver.sv \
../../rtl/obi/obi_cut.sv \
../../rtl/obi/obi_demux.sv \
../../rtl/obi/obi_err_sbr.sv \
../../rtl/obi/obi_mux.sv \
../../rtl/obi/obi_sram_shim.sv \
../../rtl/obi/obi_xbar.sv \
../../rtl/cve2/cve2_pkg.sv \
../../rtl/cve2/cve2_alu.sv \
../../rtl/cve2/cve2_compressed_decoder.sv \
../../rtl/cve2/cve2_controller.sv \
../../rtl/cve2/cve2_counter.sv \
../../rtl/cve2/cve2_csr.sv \
../../rtl/cve2/cve2_decoder.sv \
../../rtl/cve2/cve2_fetch_fifo.sv \
../../rtl/cve2/cve2_load_store_unit.sv \
../../rtl/cve2/cve2_multdiv_fast.sv \
../../rtl/cve2/cve2_multdiv_slow.sv \
../../rtl/cve2/cve2_pmp.sv \
../../rtl/cve2/cve2_register_file_ff.sv \
../../rtl/cve2/cve2_wb.sv \
../../rtl/cve2/cve2_cs_registers.sv \
../../rtl/cve2/cve2_ex_block.sv \
../../rtl/cve2/cve2_id_stage.sv \
../../rtl/cve2/cve2_prefetch_buffer.sv \
../../rtl/cve2/cve2_if_stage.sv \
../../rtl/cve2/cve2_core.sv \
../../rtl/user_domain/dpll/RTL/obi_dpll_pkg.sv \
../../rtl/user_domain/dpll/RTL/obi_dpll.sv \
../../rtl/user_domain/dpll/RTL/obi_dpll_register.sv \
../../rtl/obi_uart/obi_uart_pkg.sv \
../../rtl/obi_uart/obi_uart_baudgen.sv \
../../rtl/obi_uart/obi_uart_interrupts.sv \
../../rtl/obi_uart/obi_uart_modem.sv \
../../rtl/obi_uart/obi_uart_rx.sv \
../../rtl/obi_uart/obi_uart_tx.sv \
../../rtl/obi_uart/obi_uart_register.sv \
../../rtl/obi_uart/obi_uart.sv \
../../rtl/register_interface/reg_intf.sv \
../../rtl/register_interface/lowrisc_opentitan/prim_subreg_arb.sv \
../../rtl/register_interface/lowrisc_opentitan/prim_subreg_ext.sv \
../../rtl/register_interface/periph_to_reg.sv \
../../rtl/register_interface/reg_to_apb.sv \
../../rtl/register_interface/lowrisc_opentitan/prim_subreg_shadow.sv \
../../rtl/register_interface/lowrisc_opentitan/prim_subreg.sv \
../../rtl/riscv-dbg/dm_pkg.sv \
../../rtl/riscv-dbg/debug_rom/debug_rom.sv \
../../rtl/riscv-dbg/debug_rom/debug_rom_one_scratch.sv \
../../rtl/riscv-dbg/dm_csrs.sv \
../../rtl/riscv-dbg/dm_mem.sv \
../../rtl/riscv-dbg/dmi_cdc.sv \
../../rtl/riscv-dbg/dmi_jtag_tap.sv \
../../rtl/riscv-dbg/dm_sba.sv \
../../rtl/riscv-dbg/dm_top.sv \
../../rtl/riscv-dbg/dmi_jtag.sv \
../../rtl/riscv-dbg/dm_obi_top.sv \
../../rtl/timer_unit/timer_unit_counter.sv \
../../rtl/timer_unit/timer_unit_counter_presc.sv \
../../rtl/timer_unit/apb_timer_unit.sv \
../../rtl/timer_unit/timer_unit.sv \
../../gf180mcu/tc_clk.sv \
../../gf180mcu/gf180mcu_sram_wrapper.sv \
../../gf180mcu/tc_sram_impl.sv \
../../rtl/croc_pkg.sv \
../../rtl/user_pkg.sv \
../../rtl/soc_ctrl/soc_ctrl_reg_pkg.sv \
../../rtl/gpio/gpio_reg_pkg.sv \
../../rtl/core_wrap.sv \
../../rtl/soc_ctrl/soc_ctrl_reg_top.sv \
../../rtl/gpio/gpio_reg_top.sv \
../../rtl/gpio/gpio.sv \
../../rtl/user_domain/dpll/RTL/digital_pll.v \
../../rtl/user_domain/dpll/RTL/digital_pll_controller.v \
../../rtl/user_domain/dpll/RTL/ring_osc2x13.v \
../../rtl/user_domain/cs_dac/obi_dac_pkg.sv \
../../rtl/user_domain/cs_dac/dac_blackbox.v \
../../rtl/user_domain/cs_dac/obi_dac_regs.sv \
../../rtl/user_domain/cs_dac/obi_dac.sv \
../../rtl/user_domain/cs_dac/dac_clock_div.v \
../../rtl/croc_domain.sv \
../../rtl/user_domain.sv \
../../rtl/croc_soc.sv \
../../rtl/croc_chip.sv \
../../rtl/croc_culp.sv \
../../rtl/croc_padring.sv \
../../rtl/croc_culp_chip.sv
