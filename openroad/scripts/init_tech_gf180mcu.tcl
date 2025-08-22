# Copyright 2023 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

# Authors:
# - Tobias Senti      <tsenti@ethz.ch>
# - Jannis Schönleber <janniss@iis.ee.ethz.ch>
# - Philippe Sauter   <phsauter@iis.ee.ethz.ch>

# Initialize the PDK
# set PDK_ROOT $::env(PDK_ROOT)
set PDK $::env(PDK)
set pdk_dir $PDK
if {[file exists "../technology"]} {
	utl::report "Init tech from ETHZ DZ cockpit"
	set pdk_dir "../technology"
	set pdk_cells_lib ${pdk_dir}/lib
	set pdk_cells_lef ${pdk_dir}/lef
	set pdk_sram_lib  ${pdk_dir}/lib
	set pdk_sram_lef  ${pdk_dir}/lef
	set pdk_io_lib    ${pdk_dir}/lib
	set pdk_io_lef    ${pdk_dir}/lef
} else {
	utl::report "Init tech from Github PDK"
	if {![info exists pdk_dir]} {
		set pdk_dir "../ihp13/pdk"
	}
	set pdk_cells_lib ${pdk_dir}/libs.ref/gf180mcu_fd_sc_mcu7t5v0/lib
	set pdk_cells_lef ${pdk_dir}/libs.ref/gf180mcu_fd_sc_mcu7t5v0/lef
	set pdk_sram_lib  ${pdk_dir}/libs.ref/gf180mcu_fd_ip_sram/lib
	set pdk_sram_lef  ${pdk_dir}/libs.ref/gf180mcu_fd_ip_sram/lef
	set pdk_io_lib    ${pdk_dir}/libs.ref/gf180mcu_fd_io/lib
	set pdk_io_lef    ${pdk_dir}/libs.ref/gf180mcu_fd_io/lef
}

# set pdk_pad_lef   ../ihp13/bondpad/lef


# LIB
define_corners tt ff

puts "Init standard cells"
read_liberty -corner tt ${pdk_cells_lib}/gf180mcu_fd_sc_mcu7t5v0__tt_025C_3v30.lib
read_liberty -corner ff ${pdk_cells_lib}/gf180mcu_fd_sc_mcu7t5v0__ff_n40C_3v60.lib

puts "Init IO cells"
read_liberty -corner tt ${pdk_io_lib}/gf180mcu_fd_io__tt_025C_3v30.lib
read_liberty -corner ff ${pdk_io_lib}/gf180mcu_fd_io__ff_n40C_3v63.lib

puts "Init SRAM macros"
foreach file [glob -directory $pdk_sram_lib *_tt_025C_3v30.lib] {
	read_liberty -corner tt "$file"
}

foreach file [glob -directory $pdk_sram_lib *_ff_n40C_3v60.lib] {
	read_liberty -corner ff "$file"
}

puts "Init tech-lef"
read_lef ${pdk_cells_lef}/../techlef/gf180mcu_fd_sc_mcu7t5v0__nom.tlef

puts "Init cell-lef"
read_lef ${pdk_cells_lef}/gf180mcu_fd_sc_mcu7t5v0.lef

puts "Init IO-lef"
read_lef ../gf180mcu/gf180mcu_fd_io.tlef
foreach file [glob -directory $pdk_io_lef *.lef] {
	read_lef "$file"
}

# read_lef ${pdk_pad_lef}/bondpad_70x70.lef
puts "Init SRAM-lef"
foreach file [glob -directory $pdk_sram_lef *.lef] {
	read_lef "$file"
}
puts "finish read lef"
set ctsBuf [ list gf180mcu_fd_sc_mcu7t5v0__buf_16 gf180mcu_fd_sc_mcu7t5v0__buf_8 gf180mcu_fd_sc_mcu7t5v0__buf_4 gf180mcu_fd_sc_mcu7t5v0__buf_2]
set ctsBufRoot gf180mcu_fd_sc_mcu7t5v0__buf_8

set stdfill [ list gf180mcu_fd_sc_mcu7t5v0__fill_64 gf180mcu_fd_sc_mcu7t5v0__fill_32 gf180mcu_fd_sc_mcu7t5v0__fill_16 gf180mcu_fd_sc_mcu7t5v0__fill_8 gf180mcu_fd_sc_mcu7t5v0__fill_4 gf180mcu_fd_sc_mcu7t5v0__fill_2 gf180mcu_fd_sc_mcu7t5v0__fill_1]

set iocorner gf180mcu_fd_io__cor
set iofill [ list gf180mcu_fd_io__fill1 gf180mcu_fd_io__fill5 gf180mcu_fd_io__fill10]

# the repair_timing/repair_design commands may try to use IO cells as buffers
set dont_use_cells "gf180mcu_fd_io* *_1"

proc makeTracks {} {
    utl::report "Metal Tracks"
	make_tracks Metal1    -x_offset 0.28 -x_pitch 0.56 -y_offset 0.28 -y_pitch 0.56
	make_tracks Metal2    -x_offset 0.28 -x_pitch 0.56 -y_offset 0.28 -y_pitch 0.56
	make_tracks Metal3    -x_offset 0.28 -x_pitch 0.56 -y_offset 0.28 -y_pitch 0.56
	make_tracks Metal4    -x_offset 0.28 -x_pitch 0.56 -y_offset 0.28 -y_pitch 0.56
	make_tracks Metal5    -x_offset 0.45 -x_pitch 0.90 -y_offset 0.45 -y_pitch 0.90

}
