// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Duy-Hieu Bui  <hieubd@vnu.edu.vn>

package obi_dac_pkg;

  // Address width within this peripheral used for address decoding (peripheral occupies 4KB)
  parameter int AddressWidth = 4;
  parameter int DACResolution = 10;

  //-----------------------------------------------------------------------------------------------
  // Signals from registers to logic
  //-----------------------------------------------------------------------------------------------

  typedef struct packed {
     logic 	 en;
     logic 	 rstn;
     logic [7:0] div;
     logic [DACResolution-1:0] dac_val;	 
  } dac_reg2hw_t;


  //-----------------------------------------------------------------------------------------------
  // Signals from logic to registers
  //-----------------------------------------------------------------------------------------------

  typedef struct packed {
     logic 	 dac_clk;
  } dac_hw2reg_t;


  //-----------------------------------------------------------------------------------------------
  // Offsets
  //-----------------------------------------------------------------------------------------------
  // Register address offsets from GPIO base address
  // Spacing between registers left to allow for future implementation
  // of multiple GPIO banks (enabling more than 32 GPIOs)
  parameter logic [AddressWidth-1:0] DAC_CFG_OFFSET       = 'h0;
  parameter logic [AddressWidth-1:0] DAC_CLKDIV_OFFSET    = 'h4;
  parameter logic [AddressWidth-1:0] DAC_VALUE_OFFSET     = 'h8;



endpackage
