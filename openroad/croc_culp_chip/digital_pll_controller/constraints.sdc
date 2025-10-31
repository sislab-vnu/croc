set CLK_SYS 25
create_clock -name clk_sys -period $CLK_SYS [get_ports clock]

create_clock -name osc_clk -period 40 [get_ports osc]

set_clock_groups -asynchronous -name clk_groups_async \
     -group {clk_sys} \
     -group {osc_clk}

# set_false_path -from [get_ports reset]
set_clock_uncertainty 0.1 [all_clocks]
set_clock_transition  0.2 [all_clocks]

set_driving_cell [all_inputs] -lib_cell gf180mcu_fd_sc_mcu7t5v0__buf_4 -pin Z
set_load 0.015 [all_outputs]

set_input_delay  -min -add_delay -clock clk_sys [ expr $CLK_SYS * 0.10 ] [get_ports {reset enable dco div*}]
set_input_delay  -max -add_delay -clock clk_sys [ expr $CLK_SYS * 0.30 ] [get_ports {reset enable dco div*}]

set_output_delay -min -add_delay -clock clk_sys [ expr $CLK_SYS * 0.10 ] [get_ports {trim*}]
set_output_delay -max -add_delay -clock clk_sys [ expr $CLK_SYS * 0.30 ] [get_ports {trim*}]

set_timing_derate -early 0.9500
set_timing_derate -late 1.0500