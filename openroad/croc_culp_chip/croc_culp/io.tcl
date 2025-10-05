exclude_io_pin_region -region bottom:1116-2935 -region top:2300-2580 -region right:0-1054

set_io_pin_constraint -pin_names { \
				       uart_rx_i uart_tx_o fetch_en_i \
				       status_o clk_i ref_clk_i rst_ni \
				       jtag_tck_i jtag_trst_ni jtag_tms_i \
				       jtag_tdi_i jtag_tdo_o \
				   } \
    -group -order -region left:*

set_io_pin_constraint -pin_names { \
				       gpio_i[15] gpio_en_o[15] gpio_o[15] \
				       gpio_i[14] gpio_en_o[14] gpio_o[14] \
				       gpio_i[13] gpio_en_o[13] gpio_o[13] \
				       gpio_i[12] gpio_en_o[12] gpio_o[12] \
} \
    -region top:*

set_io_pin_constraint -pin_names { \
				       gpio_i[0] gpio_en_o[0] gpio_o[0] \
				       gpio_i[1] gpio_en_o[1] gpio_o[1] \
				       gpio_i[2] gpio_en_o[2] gpio_o[2] \
				       gpio_i[3] gpio_en_o[3] gpio_o[3] \
				       gpio_i[4] gpio_en_o[4] gpio_o[4] \
				       gpio_i[5] gpio_en_o[5] gpio_o[5] \
				       gpio_i[6] gpio_en_o[6] gpio_o[6] \
				       gpio_i[7] gpio_en_o[7] gpio_o[7] \
				       gpio_i[8] gpio_en_o[8] gpio_o[8] \
				       gpio_i[9] gpio_en_o[9] gpio_o[9] \
				       gpio_i[10] gpio_en_o[10] gpio_o[10] \
				       gpio_i[11] gpio_en_o[11] gpio_o[11] \
				   } \
    -region right:*

set_io_pin_constraint -pin_names { \
				       dpll_* dac_*
				   } \
    -region bottom:*
