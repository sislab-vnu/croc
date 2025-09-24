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

  output dpll_reg2hw_t reg2hw,   // Current register values
  input  dpll_hw2reg_t hw2reg  // Internal updates to register values
);

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // Obi Preparations //
  ////////////////////////////////////////////////////////////////////////////////////////////////////

  // Signals for the OBI response
  logic                           valid_d, valid_q;         // delayed to the response phase
  logic                           we_d, we_q;               // delayed to the response phase
  logic                           req_d, req_q;             // delayed to the response phase
  logic [AddressWidth-1:0]        write_addr;               // in request phase (word addr)
  logic [AddressWidth-1:0]        read_addr_d, read_addr_q; // delayed to the response phase (word addr)
  logic [ObiCfg.IdWidth-1:0]      id_d, id_q;               // delayed to the response phase
  logic                           obi_err;
  logic                           w_err_d, w_err_q;         // delay write error to response phase
  // signals used in read/write for register
  logic [ObiCfg.DataWidth-1:0]    obi_rdata, obi_wdata;
  logic                           obi_read_request, obi_write_request;

  // OBI rsp Assignment
  always_comb begin
    obi_rsp_o              = '0;
    obi_rsp_o.r.rdata      = obi_rdata;
    obi_rsp_o.r.rid        = id_q;
    obi_rsp_o.r.err        = obi_err;
    obi_rsp_o.gnt          = obi_req_i.req;
    obi_rsp_o.rvalid       = valid_q;
  end

  // internally used signals
  assign obi_wdata         = obi_req_i.a.wdata;
  assign obi_read_request  = req_q & ~we_q;                  // in response phase (one cycle later)
  assign obi_write_request = obi_req_i.req & obi_req_i.a.we; // in request phase (same cycle)

  // id, valid and address handling
  assign id_d          = obi_req_i.a.aid;
  assign valid_d       = obi_req_i.req;
  assign write_addr    = obi_req_i.a.addr[AddressWidth-1:2]; // write in same cycle
  assign read_addr_d   = obi_req_i.a.addr[AddressWidth-1:2]; // delay read to response phase
  assign we_d          = obi_req_i.a.we;
  assign req_d         = obi_req_i.req;

    // FF for the obi rsp signals (id, valid, address, we and req)
    `FF(id_q, id_d, '0, clk_i, rst_ni)
    `FF(valid_q, valid_d, '0, clk_i, rst_ni)
    `FF(read_addr_q, read_addr_d, '0, clk_i, rst_ni)
    `FF(req_q, req_d, '0, clk_i, rst_ni)
    `FF(we_q, we_d, '0, clk_i, rst_ni)
    `FF(w_err_q, w_err_d, '0, clk_i, rst_ni)

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // Registers //
  ////////////////////////////////////////////////////////////////////////////////////////////////////

  // bits in register organized together to ease read/write
  typedef struct packed {
     logic 	 en;         // Direction register
     logic 	 dco;
     logic [4:0] div;        // Input register
     logic [26:0] extrim;    // Interrupt edge sensitivity register
  } dpll_reg_fields_t;

  // register signals
  dpll_reg_fields_t reg_d, reg_q;
  `FF(reg_q, reg_d, '0, clk_i, rst_ni)
  
  dpll_reg_fields_t new_reg; // new value of regs if there is no OBI transaction

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // COMB LOGIC //
  ////////////////////////////////////////////////////////////////////////////////////////////////////

  // output data from internal register
  always_comb begin
     reg2hw.en          = reg_q.en;
     reg2hw.div         = reg_q.div;
     reg2hw.dco         = reg_q.dco;
     reg2hw.extrim      = reg_q.extrim;
  end

  // update registers
  always_comb begin
    // defaults
    obi_rdata  = 32'h0;   // default value for read
    obi_err    = w_err_q;
    w_err_d    = 1'b0;
    new_reg    = reg_q;   // registers stay the same

     // update new_reg
     // we do nothing in this version
     
    // commit changes
    reg_d      = new_reg; // update regs without OBI transaction

    //---------------------------------------------------------------------------------
    // WRITE
    //---------------------------------------------------------------------------------
    if (obi_write_request) begin
      obi_err = 1'b0;
      case ({write_addr, 2'b00})
        DPLL_CFG_OFFSET: begin
           reg_d.div = obi_wdata[4:0];
	   reg_d.en = obi_wdata[7];
	   reg_d.dco = obi_wdata[6];
        end

        DPLL_EXTRIM_OFFSET: begin
           reg_d.extrim = obi_wdata[26:0];
        end

        default: begin
          w_err_d = 1'b1; // unmapped register access
        end
      endcase
    end
    //---------------------------------------------------------------------------------
    // READ
    //---------------------------------------------------------------------------------
    if (obi_read_request) begin
      obi_err = 1'b0;
       obi_rdata = 'h0;
      case ({read_addr_q, 2'b00})
        DPLL_CFG_OFFSET: begin
           obi_rdata[4:0] = reg_q.div;
	   obi_rdata[7] = reg_q.en;
	   obi_rdata[6] = reg_q.dco;
        end

        DPLL_EXTRIM_OFFSET: begin
          obi_rdata = reg_q.extrim;
        end

        // DPLL_STATUS_OFFSET: begin
        //   obi_rdata = reg_q.in;
        // end

        default: begin
          obi_rdata = 32'hBADCAB1E;  // Return error value in devmode for unmapped reads
          obi_err   = 1'b1;
        end
      endcase
    end

  end

endmodule
