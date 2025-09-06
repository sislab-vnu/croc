// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Hannah Pochert  <hpochert@ethz.ch>
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>

`include "common_cells/registers.svh"

module obi_dpll_register import obi_dpll_pkg::*; #(
  /// The OBI configuration connected to this peripheral.
  parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig, // SbrObiCfg
  /// OBI request type
  parameter type obi_req_t = logic,
  /// OBI response type
  parameter type obi_rsp_t = logic
) (
  input logic clk_i,
  input logic rst_ni,

  // OBI request interface
  input obi_req_t  obi_req_i, // a.addr, a.we, a.be, a.wdata, a.aid, a.a_optional | rready, req
  // OBI response interface
  output obi_rsp_t obi_rsp_o, // r.rdata, r.rid, r.err, r.r_optional | gnt, rvalid

  output reg_read_t reg_read_o,   // Current register values
  input  reg_write_t reg_write_i  // Internal updates to register values
);

  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Obi Preparations //
  ////////////////////////////////////////////////////////////////////////////////////////////////

  // Signals for the OBI response
  logic [ObiCfg.DataWidth-1:0] rsp_data;
  logic                        valid_d, valid_q;         // delayed for the response phase
  logic                        err;
  logic                        w_err_d, w_err_q;
  logic [AddressBits-1:0]      word_addr_d, word_addr_q; // delayed for the response phase
  logic [ObiCfg.IdWidth-1:0]   id_d, id_q;               // delayed for the response phase
  logic                        we_d, we_q;
  logic                        req_d, req_q;

  // OBI rsp Assignment
  always_comb begin
    obi_rsp_o         = '0;
    obi_rsp_o.r.rdata = rsp_data;
    obi_rsp_o.r.rid   = id_q;
    obi_rsp_o.r.err   = err;
    obi_rsp_o.gnt     = obi_req_i.req;
    obi_rsp_o.rvalid  = valid_q;
  end

  // id, valid and address handling
  assign id_d         = obi_req_i.a.aid;
  assign valid_d      = obi_req_i.req;
  assign word_addr_d  = obi_req_i.a.addr[AddressOffset+:AddressBits];
  assign we_d         = obi_req_i.a.we;
  assign req_d        = obi_req_i.req;

  // FF for the obi rsp signals (id and valid)
  `FF(id_q, id_d, '0, clk_i, rst_ni)               // 5 Bits
  `FF(valid_q, valid_d, '0, clk_i, rst_ni)         // 1 Bit
  `FF(word_addr_q, word_addr_d, '0, clk_i, rst_ni) // #AddressBits Bits
  `FF(we_q, we_d, '0, clk_i, rst_ni)               // 1 Bit
  `FF(w_err_q, w_err_d, '0, clk_i, rst_ni)         // 1 Bit
  `FF(req_q, req_d, '0, clk_i, rst_ni)             // 1 Bit


  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Registers //
  ////////////////////////////////////////////////////////////////////////////////////////////////
  dpll_reg_fields_t reg_d, reg_q;
  dpll_reg_fields_t new_reg; // next value of the registers if no read/write occurs (hw update)


  ////////////////////////////////////////////////////////////////////////////////////////////////
  // COMB LOGIC //
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // output current register values
  assign reg_read_o.CFG = reg_q.CFG;
  assign reg_read_o.EXTRIM = reg_q.EXTRIM;

  //-- Internal updates to registers -------------------------------------------------------------
  always_comb begin : hw_update
    // default
    new_reg = reg_q;
  end

  //-- Software updates to registers -------------------------------------------------------------
  always_comb begin
    // default
    err     = w_err_q;
    w_err_d = 1'b0;

    // read/write indicators
    reg_read_o.obi_read_cfg  = 1'b0;
    reg_read_o.obi_read_extrim  = 1'b0;

    rsp_data = 32'h0;

    reg_d = new_reg;

    //-- OBI-Writes ------------------------------------------------------------------------------
    if (obi_req_i.req & obi_req_i.a.we & obi_req_i.a.be[0]) begin

      w_err_d = 1'b0;
        case (word_addr_d)
          RegAddrCFG: begin
            reg_d.CFG = obi_req_i.a.wdata[RegWidthCfg-1:0];
          end

          RegAddrEXTRIM: begin
            reg_d.EXTRIM = obi_req_i.a.wdata[RegWidthExtrim-1:0];
          end

          default: begin
            w_err_d = 1'b1; // unmapped register access
          end
        endcase

    end

    //-- OBI-Read --------------------------------------------------------------------------------
    if (req_q & ~we_q) begin

      err = 1'b0;

        case (word_addr_q)
          RegAddrCFG: begin
            rsp_data[RegWidthCfg-1:0] = reg_q.CFG;
            reg_read_o.obi_read_cfg  = 1'b1;
          end

          RegAddrEXTRIM: begin
             rsp_data[RegWidthExtrim-1:0] = reg_q.EXTRIM;
	     reg_read_o.obi_read_extrim = 1'b1;
          end

          default: begin
            err = 1'b1;
          end
        endcase
    end

  end

  ////////////////////////////////////////////////////////////////////////////////////////////////
  // SEQUENTIAL LOGIC //
  ////////////////////////////////////////////////////////////////////////////////////////////////

  `FF(reg_q, reg_d, obi_dpll_pkg::RegResetVal, clk_i, rst_ni)

endmodule
