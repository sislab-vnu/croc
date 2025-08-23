// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>

(* blackbox *)
module croc_culp (
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

  input wire  gpio0_i,
  input wire  gpio1_i,
  input wire  gpio2_i,
  input wire  gpio3_i,
  input wire  gpio4_i,
  input wire  gpio5_i,
  input wire  gpio6_i,
  input wire  gpio7_i,
  input wire  gpio8_i,
  input wire  gpio9_i,
  input wire  gpio10_i,
  input wire  gpio11_i,
  input wire  gpio12_i,
  input wire  gpio13_i,
  input wire  gpio14_i,
  input wire  gpio15_i,
  output wire  gpio0_o,
  output wire  gpio1_o,
  output wire  gpio2_o,
  output wire  gpio3_o,
  output wire  gpio4_o,
  output wire  gpio5_o,
  output wire  gpio6_o,
  output wire  gpio7_o,
  output wire  gpio8_o,
  output wire  gpio9_o,
  output wire  gpio10_o,
  output wire  gpio11_o,
  output wire  gpio12_o,
  output wire  gpio13_o,
  output wire  gpio14_o,
  output wire  gpio15_o,
  output wire  gpio0_en_o,
  output wire  gpio1_en_o,
  output wire  gpio2_en_o,
  output wire  gpio3_en_o,
  output wire  gpio4_en_o,
  output wire  gpio5_en_o,
  output wire  gpio6_en_o,
  output wire  gpio7_en_o,
  output wire  gpio8_en_o,
  output wire  gpio9_en_o,
  output wire  gpio10_en_o,
  output wire  gpio11_en_o,
  output wire  gpio12_en_o,
  output wire  gpio13_en_o,
  output wire  gpio14_en_o,
  output wire  gpio15_en_o
); 
  //   logic soc_clk_i;
  //   logic soc_rst_ni;
  //   logic soc_ref_clk_i;
  //   logic soc_testmode;

  //   logic soc_jtag_tck_i;
  //   logic soc_jtag_trst_ni;
  //   logic soc_jtag_tms_i;
  //   logic soc_jtag_tdi_i;
  //   logic soc_jtag_tdo_o;

  //   logic soc_fetch_en_i;
  //   logic soc_status_o;

  //   localparam int unsigned GpioCount = 16;

  //   logic [GpioCount-1:0] soc_gpio_i;             
  //   logic [GpioCount-1:0] soc_gpio_o;            
  //   logic [GpioCount-1:0] soc_gpio_out_en_o; // Output enable signal; 0 -> input, 1 -> output
  //  assign soc_gpio_i = {gpio15_i, gpio14_i, gpio13_i, gpio12_i,
  // 			gpio11_i, gpio10_i, gpio9_i, gpio8_i,
  // 			gpio7_i, gpio6_i, gpio5_i, gpio4_i,
  // 			gpio3_i, gpio2_i, gpio1_i, gpio0_i};
  //  assign gpio15_o = soc_gpio_o[15];
  //  assign gpio14_o = soc_gpio_o[14];
  //  assign gpio13_o = soc_gpio_o[13];
  //  assign gpio12_o = soc_gpio_o[12];
  //  assign gpio11_o = soc_gpio_o[11];
  //  assign gpio10_o = soc_gpio_o[10];
  //  assign gpio9_o = soc_gpio_o[9];
  //  assign gpio8_o = soc_gpio_o[8];
  //  assign gpio7_o = soc_gpio_o[7];
  //  assign gpio6_o = soc_gpio_o[6];
  //  assign gpio5_o = soc_gpio_o[5];
  //  assign gpio4_o = soc_gpio_o[4];
  //  assign gpio3_o = soc_gpio_o[3];
  //  assign gpio2_o = soc_gpio_o[2];
  //  assign gpio1_o = soc_gpio_o[1];
  //  assign gpio0_o = soc_gpio_o[0];
  //  assign gpio15_en_o = soc_gpio_out_en_o[15];
  //  assign gpio14_en_o = soc_gpio_out_en_o[14];
  //  assign gpio13_en_o = soc_gpio_out_en_o[13];
  //  assign gpio12_en_o = soc_gpio_out_en_o[12];
  //  assign gpio11_en_o = soc_gpio_out_en_o[11];
  //  assign gpio10_en_o = soc_gpio_out_en_o[10];
  //  assign gpio9_en_o = soc_gpio_out_en_o[9];
  //  assign gpio8_en_o = soc_gpio_out_en_o[8];
  //  assign gpio7_en_o = soc_gpio_out_en_o[7];
  //  assign gpio6_en_o = soc_gpio_out_en_o[6];
  //  assign gpio5_en_o = soc_gpio_out_en_o[5];
  //  assign gpio4_en_o = soc_gpio_out_en_o[4];
  //  assign gpio3_en_o = soc_gpio_out_en_o[3];
  //  assign gpio2_en_o = soc_gpio_out_en_o[2];
  //  assign gpio1_en_o = soc_gpio_out_en_o[1];
  //  assign gpio0_en_o = soc_gpio_out_en_o[0];

   
  // croc_soc #(
  //   .GpioCount( GpioCount )
  // )
  // i_croc_soc (
  //   .clk_i          ( soc_clk_i      ),
  //   .rst_ni         ( soc_rst_ni     ),
  //   .ref_clk_i      ( soc_ref_clk_i  ),
  //   .testmode_i     ( soc_testmode_i ),
  //   .fetch_en_i     ( soc_fetch_en_i ),
  //   .status_o       ( soc_status_o   ),

  //   .jtag_tck_i     ( soc_jtag_tck_i   ),
  //   .jtag_tdi_i     ( soc_jtag_tdi_i   ),
  //   .jtag_tdo_o     ( soc_jtag_tdo_o   ),
  //   .jtag_tms_i     ( soc_jtag_tms_i   ),
  //   .jtag_trst_ni   ( soc_jtag_trst_ni ),

  //   .uart_rx_i      ( soc_uart_rx_i ),
  //   .uart_tx_o      ( soc_uart_tx_o ),

  //   .gpio_i         ( soc_gpio_i        ),             
  //   .gpio_o         ( soc_gpio_o        ),            
  //   .gpio_out_en_o  ( soc_gpio_out_en_o )
  // );

endmodule
