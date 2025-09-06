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
  input logic 	     clk_i, // Primary input clock
  input logic 	     rst_ni, // Asynchronous active-low reset

  // OBI request interface
  input 	     obi_req_t obi_req_i, // a.addr, a.we, a.be, a.wdata, a.aid, a.a_optional | rready, req
  // OBI response interface
  output 	     obi_rsp_t obi_rsp_o, // r.rdata, r.rid, r.err, r.r_optional | gnt, rvalid

  output logic 	     irq_o, // Interrupt line
  output logic 	     irq_no, // Negated Interrupt line
  output logic [7:0] dpll_cfg
);
  // Import the UART package for definitions and parameters
  import obi_dpll_pkg::*;

   reg_read_t reg_read;
   reg_write_t reg_write;
   
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

    .reg_read_o  (reg_read),
    .reg_write_i (reg_write)
  );

endmodule
