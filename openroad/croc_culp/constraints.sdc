set_driving_cell [all_inputs] -lib_cell gf180mcu_fd_sc_mcu7t5v0__buf_4 -pin Z
set_load 0.015 [all_outputs]

set TCK_SYS 40.0
create_clock -name clk_sys -period $TCK_SYS [get_ports clk_i]

set TCK_JTG 50.0
create_clock -name clk_jtg -period $TCK_JTG [get_ports jtag_tck_i]

set TCK_RTC 200.0
create_clock -name clk_rtc -period $TCK_RTC [get_ports ref_clk_i]

set_clock_groups -asynchronous -name clk_groups_async \
     -group {clk_rtc} \
     -group {clk_jtg} \
     -group {clk_sys}

set_clock_uncertainty 0.1 [all_clocks]
set_clock_transition  0.2 [all_clocks]

set_input_delay -max [ expr $TCK_JTG * 0.10 ] [get_ports rst_ni]  
set_false_path -from [get_ports rst_ni]

set_input_delay  -min -add_delay -clock clk_jtg [ expr $TCK_JTG * 0.10 ]     [get_ports {jtag_tdi_i jtag_tms_i}]
set_input_delay  -max -add_delay -clock clk_jtg [ expr $TCK_JTG * 0.50 ]     [get_ports {jtag_tdi_i jtag_tms_i}]
set_output_delay -min -add_delay -clock clk_jtg [ expr $TCK_JTG * 0.10 / 2 ] [get_ports jtag_tdo_o]
set_output_delay -max -add_delay -clock clk_jtg [ expr $TCK_JTG * 0.50 / 2 ] [get_ports jtag_tdo_o]


set_input_delay -max [ expr $TCK_JTG * 0.10 ] [get_ports jtag_trst_ni]  
set_false_path -hold    -from [get_ports jtag_trst_ni]
set_max_delay $TCK_JTG  -from [get_ports jtag_trst_ni]

set_input_delay  -min -add_delay -clock clk_sys [ expr $TCK_SYS * 0.10 ] [get_ports {gpio*_i fetch_en_i}]
set_input_delay  -max -add_delay -clock clk_sys [ expr $TCK_SYS * 0.30 ] [get_ports {gpio*_i fetch_en_i}]

set_output_delay -min -add_delay -clock clk_sys [ expr $TCK_SYS * 0.10 ] [get_ports {gpio*_o}]
set_output_delay -max -add_delay -clock clk_sys [ expr $TCK_SYS * 0.30 ] [get_ports {gpio*_o}]

set_output_delay -min -add_delay -clock clk_sys [ expr $TCK_SYS * 0.10 ] [get_ports {status_o}]
set_output_delay -max -add_delay -clock clk_sys [ expr $TCK_SYS * 0.30 ] [get_ports {status_o}]

set_input_delay  -min -add_delay -clock clk_sys [ expr $TCK_SYS * 0.10 ] [get_ports uart_rx_i]
set_input_delay  -max -add_delay -clock clk_sys [ expr $TCK_SYS * 0.30 ] [get_ports uart_rx_i]
set_output_delay -min -add_delay -clock clk_sys [ expr $TCK_SYS * 0.10 ] [get_ports uart_tx_o]
set_output_delay -max -add_delay -clock clk_sys [ expr $TCK_SYS * 0.30 ] [get_ports uart_tx_o]

