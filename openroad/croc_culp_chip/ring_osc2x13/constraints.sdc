set CLK_SYS 8
create_clock -name ring_clk -period $CLK_SYS [get_ports clock]

# set_false_path -from [get_ports reset]
set_clock_uncertainty 0.1 [all_clocks]
set_clock_transition  0.2 [all_clocks]

set_driving_cell [all_inputs] -lib_cell gf180mcu_fd_sc_mcu7t5v0__buf_4 -pin Z
set_load 0.015 [all_outputs]

set_input_delay  -min -add_delay -clock ring_clk [ expr $CLK_SYS * 0.10 ] [get_ports {resetb enable dco trim* extrim*}]
set_input_delay  -max -add_delay -clock ring_clk [ expr $CLK_SYS * 0.30 ] [get_ports {resetb enable dco trim* extrim*}]

# set_output_delay -min -add_delay -clock ring_clk [ expr $CLK_SYS * 0.10 ] [get_ports {gpio*_o}]
# set_output_delay -max -add_delay -clock ring_clk [ expr $CLK_SYS * 0.30 ] [get_ports {gpio*_o}]

set_timing_derate -early 0.9500
set_timing_derate -late 1.0500