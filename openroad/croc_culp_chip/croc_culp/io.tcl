set_io_pin_constraint -pin_names { \
				       uart_rx_i uart_tx_o fetch_en_i \
				       status_o clk_i ref_clk_i rst_ni \
				       jtag_tck_i jtag_trst_ni jtag_tms_i \
				       jtag_tdi_i jtag_tdo_o \
				   } \
    -group -order -region left:*

set_io_pin_constraint -pin_names { \
				       gpio15_i gpio15_en_o gpio15_o \
				       gpio14_i gpio14_en_o gpio14_o \
				       gpio13_i gpio13_en_o gpio13_o \
				       gpio12_i gpio12_en_o gpio12_o
				       gpio11_i gpio11_en_o gpio11_o \
} \
    -group -order -region top:*

set_io_pin_constraint -pin_names { \
				       gpio10_i gpio10_en_o gpio10_o \
				       gpio9_i  gpio9_en_o  gpio9_o \
				       gpio8_i  gpio8_en_o  gpio8_o \
				       gpio7_i  gpio7_en_o  gpio7_o \
				       gpio6_i  gpio6_en_o  gpio6_o \
				       gpio5_i  gpio5_en_o  gpio5_o \
				       gpio4_i  gpio4_en_o  gpio4_o \
				       gpio3_i  gpio3_en_o  gpio3_o \
				       gpio2_i  gpio2_en_o  gpio2_o \
				       gpio1_i  gpio1_en_o  gpio1_o \
				       gpio0_i  gpio0_en_o  gpio0_o \
				   } \
    -group -order -region right:*
