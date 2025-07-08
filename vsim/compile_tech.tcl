# Copyright (c) 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Authors:
# - Philippe Sauter <phsauter@iis.ee.ethz.ch>
set TECHNO $::env(TARGET_TECH)
puts "Techno: $TECHNO"
set PDK_ROOT $::env(PDK_ROOT)
set PDK $::env(PDK)
if {$TECHNO eq "ihp13"} {
    if {[catch { vlog -incr -sv \
		     +define+FUNCTIONAL \
		     "$ROOT/ihp13/pdk/ihp-sg13g2/libs.ref/sg13g2_stdcell/verilog/sg13g2_stdcell.v" \
		     "$ROOT/ihp13/pdk/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_1P_core_behavioral_bm_bist.v" \
		     "$ROOT/ihp13/pdk/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_1P_64x64_c2_bm_bist.v" \
		     "$ROOT/ihp13/pdk/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_1P_256x64_c2_bm_bist.v" \
		     "$ROOT/ihp13/pdk/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_1P_512x64_c2_bm_bist.v" \
		     "$ROOT/ihp13/pdk/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_1P_1024x64_c2_bm_bist.v" \
		     "$ROOT/ihp13/pdk/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_1P_2048x64_c2_bm_bist.v" \
		     "$ROOT/ihp13/pdk/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_1P_256x48_c2_bm_bist.v" \
		     "$ROOT/ihp13/pdk/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_1P_256x48_c2_bm_bist.v" \
		     "$ROOT/ihp13/tc_sram_impl.sv" \
		     "$ROOT/ihp13/tc_clk.sv" \
		 }]} {return 1}
} elseif {$TECHNO eq "gf180mcu"} {
    if {[catch { vlog -incr -sv \
		     +define+FUNCTIONAL \
		     "$PDK_ROOT/$PDK/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/primitives.v" \
		     "$PDK_ROOT/$PDK/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/gf180mcu_fd_sc_mcu7t5v0.v" \
		     "$PDK_ROOT/$PDK/libs.ref/gf180mcu_fd_ip_sram/verilog/gf180mcu_fd_ip_sram__sram128x8m8wm1.v" \
		     "$PDK_ROOT/$PDK/libs.ref/gf180mcu_fd_ip_sram/verilog/gf180mcu_fd_ip_sram__sram64x8m8wm1.v" \
		     "$PDK_ROOT/$PDK/libs.ref/gf180mcu_fd_ip_sram/verilog/gf180mcu_fd_ip_sram__sram256x8m8wm1.v" \
		     "$PDK_ROOT/$PDK/libs.ref/gf180mcu_fd_ip_sram/verilog/gf180mcu_fd_ip_sram__sram512x8m8wm1.v" \
		     "$PDK_ROOT/$PDK/libs.ref/gf180mcu_fd_io/verilog/gf180mcu_fd_io.v" \
		     "$ROOT/gf180mcuc/gf180mcu_sram_wrapper.sv" \
		     "$ROOT/gf180mcuc/tc_sram_impl.sv" \
		     "$ROOT/gf180mcuc/tc_clk.sv" \
		 }]} {return 1}
}

