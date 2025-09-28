// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Hannah Pochert  <hpochert@ethz.ch>
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>

`include "common_cells/registers.svh"

module obi_dpll #(
  /// The OBI configuration connected to this peripheral.
  parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig, // SbrObiCfg
  /// OBI request type
  parameter type obi_req_t = logic,
  /// OBI response type
  parameter type obi_rsp_t = logic
) (
  input logic 	      clk_i, // Primary input clock
  input logic 	      rst_ni, // Asynchronous active-low reset

  // OBI request interface
  input 	      obi_req_t obi_req_i, // a.addr, a.we, a.be, a.wdata, a.aid, a.a_optional | rready, req
  // OBI response interface
  output 	      obi_rsp_t obi_rsp_o, // r.rdata, r.rid, r.err, r.r_optional | gnt, rvalid

  output logic 	      dpll_en_o, // Interrupt line
  output logic 	      dpll_dco_o, // Negated Interrupt line
  output logic 	      dpll_rstn_o, // Negated Interrupt line
  output logic [4:0]  dpll_div_o, // Negated Interrupt line
  output logic [26:0] dpll_extrim_o
);
  // Import the UART package for definitions and parameters
  import obi_dpll_pkg::*;

   dpll_reg2hw_t reg_w;
   dpll_hw2reg_t reg_r;
   
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // REGISTER INTERFACE //
  ////////////////////////////////////////////////////////////////////////////////////////////////

  obi_dpll_register #(
    .obi_req_t (obi_req_t),
    .obi_rsp_t (obi_rsp_t)
  ) i_dpll_register (
    .clk_i,
    .rst_ni,

    .obi_req_i,
    .obi_rsp_o,

    .reg2hw  (reg_w),
    .hw2reg (reg_r)
  );

   assign dpll_en_o = reg_w.en;
   assign dpll_dco_o = reg_w.dco;
   assign dpll_rstn_o = reg_w.rst_n;
   assign dpll_div_o = reg_w.div;
   assign dpll_extrim_o = reg_w.extrim;

endmodule
