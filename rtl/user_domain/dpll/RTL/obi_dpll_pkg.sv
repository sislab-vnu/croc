// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Duy-Hieu Bui  <hieubd@vnu.edu.vn>

package obi_dpll_pkg;

  // Address width within this peripheral used for address decoding (peripheral occupies 4KB)
  parameter int AddressWidth = 4;

  //-----------------------------------------------------------------------------------------------
  // Signals from registers to logic
  //-----------------------------------------------------------------------------------------------

  typedef struct packed {
     logic 	 en;
     logic 	 dco;
     logic [4:0] div;
     logic [26:0] extrim;
  } dpll_reg2hw_t;


  //-----------------------------------------------------------------------------------------------
  // Signals from logic to registers
  //-----------------------------------------------------------------------------------------------

  typedef struct packed {
     logic 	 out;
  } dpll_hw2reg_t;


  //-----------------------------------------------------------------------------------------------
  // Offsets
  //-----------------------------------------------------------------------------------------------
  // Register address offsets from GPIO base address
  // Spacing between registers left to allow for future implementation
  // of multiple GPIO banks (enabling more than 32 GPIOs)
  parameter logic [AddressWidth-1:0] DPLL_CFG_OFFSET           = 'h0;
  parameter logic [AddressWidth-1:0] DPLL_EXTRIM_OFFSET        = 'h4;
  parameter logic [AddressWidth-1:0] DPLL_STATUS_OFFSET        = 'h8;



endpackage
