# exclude_io_pin_region -region bottom:1116-2935 -region top:2300-2580 -region right:0-1054
set_io_pin_constraint -pin_names { \
				       uart_rx_i uart_tx_o fetch_en_i \
				       status_o ref_clk_i rst_ni \
				       jtag_tck_i  jtag_tms_i \
				       jtag_tdo_o jtag_trst_ni jtag_tdi_i \
				       clk_i \
				   } \
    -group -order -region left:*

set_io_pin_constraint -pin_names { \
				       gpio_i[23] gpio_en_o[23] gpio_o[23] \
				       gpio_i[22] gpio_en_o[22] gpio_o[22] \
				       gpio_i[21] gpio_en_o[21] gpio_o[21] \
				       gpio_i[20] gpio_en_o[20] gpio_o[20] \
				       gpio_i[19] gpio_en_o[19] gpio_o[19] \
				       gpio_i[18] gpio_en_o[18] gpio_o[18] \
				       gpio_i[17] gpio_en_o[17] gpio_o[17] \
				       gpio_i[16] gpio_en_o[16] gpio_o[16] \
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
				       gpio_i[28] gpio_en_o[28] gpio_o[28] \
				       gpio_i[27] gpio_en_o[27] gpio_o[27] \
				       gpio_i[26] gpio_en_o[26] gpio_o[26] \
				       gpio_i[25] gpio_en_o[25] gpio_o[25] \
				       gpio_i[24] gpio_en_o[24] gpio_o[24] \
				       dpll_* \
				       gpio_i[29] gpio_en_o[29] gpio_o[29] \
				       gpio_i[30] gpio_en_o[30] gpio_o[30] \
				       gpio_i[31] gpio_en_o[31] gpio_o[31] \
				   } \
    -region bottom:*
