// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>

module croc_culp_chip (
  input wire  clk_i,
  input wire  rst_ni,
  input wire  ref_clk_i,

  input wire  jtag_tck_i,
  input wire  jtag_trst_ni,
  input wire  jtag_tms_i,
  input wire  jtag_tdi_i,
  output wire jtag_tdo_o,

  input wire  uart_rx_i,
  output wire uart_tx_o,

  input wire  fetch_en_i,
  output wire status_o,

  inout wire  gpio0_io,
  inout wire  gpio1_io,
  inout wire  gpio2_io,
  inout wire  gpio3_io,
  inout wire  gpio4_io,
  inout wire  gpio5_io,
  inout wire  gpio6_io,
  inout wire  gpio7_io,
  inout wire  gpio8_io,
  inout wire  gpio9_io,
  inout wire  gpio10_io,
  inout wire  gpio11_io,
  inout wire  gpio12_io,
  inout wire  gpio13_io,
  inout wire  gpio14_io,
  inout wire  gpio15_io,
  output wire pll_clk_o
  // output wire dac_outp_o,
  // output wire dac_outp_o,
  // input wire dac_vbias_i,
  // input wire adc_inp_i,
  // input wire  adc_inn_i       
); 
    logic soc_clk_i;
    logic soc_rst_ni;
    logic soc_ref_clk_i;

    logic soc_jtag_tck_i;
    logic soc_jtag_trst_ni;
    logic soc_jtag_tms_i;
    logic soc_jtag_tdi_i;
    logic soc_jtag_tdo_o;

    logic soc_fetch_en_i;
    logic soc_status_o;

    localparam int unsigned GpioCount = 16;

    logic [GpioCount-1:0] soc_gpio_i;             
    logic [GpioCount-1:0] soc_gpio_o;            
    logic [GpioCount-1:0] soc_gpio_out_en_o; // Output enable signal; 0 -> input, 1 -> output

   
   (* dont_touch = "true" *)
   croc_culp
     i_croc_soc (
    .clk_i          ( soc_clk_i      ),
    .rst_ni         ( soc_rst_ni     ),
    .ref_clk_i      ( soc_ref_clk_i  ),
    .fetch_en_i     ( soc_fetch_en_i ),
    .status_o       ( soc_status_o   ),

    .jtag_tck_i     ( soc_jtag_tck_i   ),
    .jtag_tdi_i     ( soc_jtag_tdi_i   ),
    .jtag_tdo_o     ( soc_jtag_tdo_o   ),
    .jtag_tms_i     ( soc_jtag_tms_i   ),
    .jtag_trst_ni   ( soc_jtag_trst_ni ),

    .uart_rx_i      ( soc_uart_rx_i ),
    .uart_tx_o      ( soc_uart_tx_o ),

    .gpio0_i         ( soc_gpio_i[0]        ),             
    .gpio1_i         ( soc_gpio_i[1]        ),             
    .gpio2_i         ( soc_gpio_i[2]        ),             
    .gpio3_i         ( soc_gpio_i[3]        ),             
    .gpio4_i         ( soc_gpio_i[4]        ),             
    .gpio5_i         ( soc_gpio_i[5]        ),             
    .gpio6_i         ( soc_gpio_i[6]        ),             
    .gpio7_i         ( soc_gpio_i[7]        ),             
    .gpio8_i         ( soc_gpio_i[8]        ),             
    .gpio9_i         ( soc_gpio_i[9]        ),             
    .gpio10_i         ( soc_gpio_i[10]        ),             
    .gpio11_i         ( soc_gpio_i[11]        ),             
    .gpio12_i         ( soc_gpio_i[12]        ),             
    .gpio13_i         ( soc_gpio_i[13]        ),             
    .gpio14_i         ( soc_gpio_i[14]        ),             
    .gpio15_i         ( soc_gpio_i[15]        ),             
    .gpio0_o         ( soc_gpio_o[0]        ),            
    .gpio1_o         ( soc_gpio_o[1]        ),            
    .gpio2_o         ( soc_gpio_o[2]        ),            
    .gpio3_o         ( soc_gpio_o[3]        ),            
    .gpio4_o         ( soc_gpio_o[4]        ),            
    .gpio5_o         ( soc_gpio_o[5]        ),            
    .gpio6_o         ( soc_gpio_o[6]        ),            
    .gpio7_o         ( soc_gpio_o[7]        ),            
    .gpio8_o         ( soc_gpio_o[8]        ),            
    .gpio9_o         ( soc_gpio_o[9]        ),            
    .gpio10_o         ( soc_gpio_o[10]        ),            
    .gpio11_o         ( soc_gpio_o[11]        ),            
    .gpio12_o         ( soc_gpio_o[12]        ),            
    .gpio13_o         ( soc_gpio_o[13]        ),            
    .gpio14_o         ( soc_gpio_o[14]        ),            
    .gpio15_o         ( soc_gpio_o[15]        ),            
    .gpio0_en_o  ( soc_gpio_out_en_o[0] ),
    .gpio1_en_o  ( soc_gpio_out_en_o[1] ),
    .gpio2_en_o  ( soc_gpio_out_en_o[2] ),
    .gpio3_en_o  ( soc_gpio_out_en_o[3] ),
    .gpio4_en_o  ( soc_gpio_out_en_o[4] ),
    .gpio5_en_o  ( soc_gpio_out_en_o[5] ),
    .gpio6_en_o  ( soc_gpio_out_en_o[6] ),
    .gpio7_en_o  ( soc_gpio_out_en_o[7] ),
    .gpio8_en_o  ( soc_gpio_out_en_o[8] ),
    .gpio9_en_o  ( soc_gpio_out_en_o[9] ),
    .gpio10_en_o  ( soc_gpio_out_en_o[10] ),
    .gpio11_en_o  ( soc_gpio_out_en_o[11] ),
    .gpio12_en_o  ( soc_gpio_out_en_o[12] ),
    .gpio13_en_o  ( soc_gpio_out_en_o[13] ),
    .gpio14_en_o  ( soc_gpio_out_en_o[14] ),
    .gpio15_en_o  ( soc_gpio_out_en_o[15] )
  );

   croc_padring
     i_padring (
    .soc_clk_i          ( soc_clk_i      ),
    .soc_rst_ni         ( soc_rst_ni     ),
    .soc_ref_clk_i      ( soc_ref_clk_i  ),
		.soc_tie_h (1'b1),
		.soc_tie_l (1'b1),
    .soc_fetch_en_i     ( soc_fetch_en_i ),
    .soc_status_o       ( soc_status_o   ),

    .soc_jtag_tck_i     ( soc_jtag_tck_i   ),
    .soc_jtag_tdi_i     ( soc_jtag_tdi_i   ),
    .soc_jtag_tdo_o     ( soc_jtag_tdo_o   ),
    .soc_jtag_tms_i     ( soc_jtag_tms_i   ),
    .soc_jtag_trst_ni   ( soc_jtag_trst_ni ),

    .soc_uart_rx_i      ( soc_uart_rx_i ),
    .soc_uart_tx_o      ( soc_uart_tx_o ),

    .soc_gpio0_i         ( soc_gpio_i[0]        ),             
    .soc_gpio1_i         ( soc_gpio_i[1]        ),             
    .soc_gpio2_i         ( soc_gpio_i[2]        ),             
    .soc_gpio3_i         ( soc_gpio_i[3]        ),             
    .soc_gpio4_i         ( soc_gpio_i[4]        ),             
    .soc_gpio5_i         ( soc_gpio_i[5]        ),             
    .soc_gpio6_i         ( soc_gpio_i[6]        ),             
    .soc_gpio7_i         ( soc_gpio_i[7]        ),             
    .soc_gpio8_i         ( soc_gpio_i[8]        ),             
    .soc_gpio9_i         ( soc_gpio_i[9]        ),             
    .soc_gpio10_i         ( soc_gpio_i[10]        ),             
    .soc_gpio11_i         ( soc_gpio_i[11]        ),             
    .soc_gpio12_i         ( soc_gpio_i[12]        ),             
    .soc_gpio13_i         ( soc_gpio_i[13]        ),             
    .soc_gpio14_i         ( soc_gpio_i[14]        ),             
    .soc_gpio15_i         ( soc_gpio_i[15]        ),             
    .soc_gpio0_o         ( soc_gpio_o[0]        ),            
    .soc_gpio1_o         ( soc_gpio_o[1]        ),            
    .soc_gpio2_o         ( soc_gpio_o[2]        ),            
    .soc_gpio3_o         ( soc_gpio_o[3]        ),            
    .soc_gpio4_o         ( soc_gpio_o[4]        ),            
    .soc_gpio5_o         ( soc_gpio_o[5]        ),            
    .soc_gpio6_o         ( soc_gpio_o[6]        ),            
    .soc_gpio7_o         ( soc_gpio_o[7]        ),            
    .soc_gpio8_o         ( soc_gpio_o[8]        ),            
    .soc_gpio9_o         ( soc_gpio_o[9]        ),            
    .soc_gpio10_o         ( soc_gpio_o[10]        ),            
    .soc_gpio11_o         ( soc_gpio_o[11]        ),            
    .soc_gpio12_o         ( soc_gpio_o[12]        ),            
    .soc_gpio13_o         ( soc_gpio_o[13]        ),            
    .soc_gpio14_o         ( soc_gpio_o[14]        ),            
    .soc_gpio15_o         ( soc_gpio_o[15]        ),            
    .soc_gpio0_en_o  ( soc_gpio_out_en_o[0] ),
    .soc_gpio1_en_o  ( soc_gpio_out_en_o[1] ),
    .soc_gpio2_en_o  ( soc_gpio_out_en_o[2] ),
    .soc_gpio3_en_o  ( soc_gpio_out_en_o[3] ),
    .soc_gpio4_en_o  ( soc_gpio_out_en_o[4] ),
    .soc_gpio5_en_o  ( soc_gpio_out_en_o[5] ),
    .soc_gpio6_en_o  ( soc_gpio_out_en_o[6] ),
    .soc_gpio7_en_o  ( soc_gpio_out_en_o[7] ),
    .soc_gpio8_en_o  ( soc_gpio_out_en_o[8] ),
    .soc_gpio9_en_o  ( soc_gpio_out_en_o[9] ),
    .soc_gpio10_en_o  ( soc_gpio_out_en_o[10] ),
    .soc_gpio11_en_o  ( soc_gpio_out_en_o[11] ),
    .soc_gpio12_en_o  ( soc_gpio_out_en_o[12] ),
    .soc_gpio13_en_o  ( soc_gpio_out_en_o[13] ),
    .soc_gpio14_en_o  ( soc_gpio_out_en_o[14] ),
    .soc_gpio15_en_o  ( soc_gpio_out_en_o[15] ),
    .soc_gpio0_ie_o  ( ~soc_gpio_out_en_o[0] ),
    .soc_gpio1_ie_o  ( ~soc_gpio_out_en_o[1] ),
    .soc_gpio2_ie_o  ( ~soc_gpio_out_en_o[2] ),
    .soc_gpio3_ie_o  ( ~soc_gpio_out_en_o[3] ),
    .soc_gpio4_ie_o  ( ~soc_gpio_out_en_o[4] ),
    .soc_gpio5_ie_o  ( ~soc_gpio_out_en_o[5] ),
    .soc_gpio6_ie_o  ( ~soc_gpio_out_en_o[6] ),
    .soc_gpio7_ie_o  ( ~soc_gpio_out_en_o[7] ),
    .soc_gpio8_ie_o  ( ~soc_gpio_out_en_o[8] ),
    .soc_gpio9_ie_o  ( ~soc_gpio_out_en_o[9] ),
    .soc_gpio10_ie_o  ( soc_gpio_out_en_o[10] ),
    .soc_gpio11_ie_o  ( soc_gpio_out_en_o[11] ),
    .soc_gpio12_ie_o  ( soc_gpio_out_en_o[12] ),
    .soc_gpio13_ie_o  ( soc_gpio_out_en_o[13] ),
    .soc_gpio14_ie_o  ( soc_gpio_out_en_o[14] ),
    .soc_gpio15_ie_o  ( ~soc_gpio_out_en_o[15] ),
    .p_clk_i(clk_i),
    .p_rst_ni(rst_ni),
    .p_ref_clk_i(ref_clk_i),

    .p_jtag_tck_i(jtag_tck_i),
    .p_jtag_trst_ni(jtag_trst_ni),
    .p_jtag_tms_i(jtag_tms_i),
    .p_jtag_tdi_i(jtag_tdi_i),
    .p_jtag_tdo_o(jtag_tdo_o),

    .p_uart_rx_i(uart_rx_i),
    .p_uart_tx_o(uart_tx_o),

    .p_fetch_en_i(fetch_en_i),
    .p_status_o(status_o),

    .p_gpio0_io(gpio0_io),
    .p_gpio1_io(gpio0_io),
    .p_gpio2_io(gpio0_io),
    .p_gpio3_io(gpio0_io),
    .p_gpio4_io(gpio0_io),
    .p_gpio5_io(gpio0_io),
    .p_gpio6_io(gpio0_io),
    .p_gpio7_io(gpio0_io),
    .p_gpio8_io(gpio0_io),
    .p_gpio9_io(gpio0_io),
    .p_gpio10_io(gpio0_io),
    .p_gpio11_io(gpio0_io),
    .p_gpio12_io(gpio0_io),
    .p_gpio13_io(gpio0_io),
    .p_gpio14_io(gpio0_io),
    .p_gpio15_io(gpio0_io),

  // custom IP
   .p_pll_clk_o(pll_clk_o)
  );

endmodule
