// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Duy-Hieu Bui <hieubd@vnu.edu.vn>
`ifdef CROC_CULP_BLACKBOX
(* blackbox *)
`endif
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

`ifdef ENABLE_CD_DAC
  //dac interface
  output wire dac_clk_o,
  output wire [9:0] dac_val_o,
`endif

  input wire  [15:0] gpio_i,
  output wire [15:0] gpio_o,
  output wire [15:0] gpio_en_o,

  output wire dpll_en_o, 
  output wire dpll_dco_o, 
  output wire dpll_rstn_o,
  output wire [4:0] dpll_div_o, 
  output wire [25:0] dpll_extrim_o
); 
`ifndef CROC_CULP_BLACKBOX

    localparam int unsigned GpioCount = 16;

    logic [GpioCount-1:0] soc_gpio_out_en_o; // Output enable signal; 0 -> input, 1 -> output
   
  croc_soc #(
    .GpioCount( GpioCount )
  )
  i_croc_soc (
    .clk_i          ( clk_i      ),
    .rst_ni         ( rst_ni     ),
    .ref_clk_i      ( ref_clk_i  ),
    .testmode_i     ( 1'b0 ),
    .fetch_en_i     ( fetch_en_i ),
    .status_o       ( status_o   ),

    .jtag_tck_i     ( jtag_tck_i   ),
    .jtag_tdi_i     ( jtag_tdi_i   ),
    .jtag_tdo_o     ( jtag_tdo_o   ),
    .jtag_tms_i     ( jtag_tms_i   ),
    .jtag_trst_ni   ( jtag_trst_ni ),

    .uart_rx_i      ( uart_rx_i ),
    .uart_tx_o      ( uart_tx_o ),

    .dpll_en_o		( dpll_en_o	),
    .dpll_rstn_o	( dpll_rstn_o	),
    .dpll_dco_o		( dpll_dco_o	),
    .dpll_div_o		( dpll_div_o	),
    .dpll_extrim_o	( dpll_extrim_o	),
`ifdef ENABLE_CD_DAC
     .dac_val_o	( dac_val_o	),
     .dac_clk_o	( dac_clk_o	),
`endif
    .gpio_i         ( gpio_i        ),
    .gpio_o         ( gpio_o        ),
    .gpio_out_en_o  ( gpio_en_o     )
  );
`endif
endmodule
