// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>

module user_domain import user_pkg::*; import croc_pkg::*; #(
  parameter int unsigned GpioCount = 16
) (
  input logic 			     clk_i,
  input logic 			     ref_clk_i,
  input logic 			     rst_ni,
  input logic 			     testmode_i,

  output logic 			     dpll_en_o,
  output logic 			     dpll_dco_o,
  output logic 			     dpll_rstn_o,
  output logic [4:0] 		     dpll_div_o,
  output logic [26:0] 		     dpll_extrim_o,

// `ifdef ENABLE_CS_DAC
//   output logic 			     dac_val_o,
//   output logic 			     dac_clk_o,
// `endif

  input 			     sbr_obi_req_t user_sbr_obi_req_i, // User Sbr (rsp_o), Croc Mgr (req_i)
  output 			     sbr_obi_rsp_t user_sbr_obi_rsp_o,

  output 			     mgr_obi_req_t user_mgr_obi_req_o, // User Mgr (req_o), Croc Sbr (rsp_i)
  input 			     mgr_obi_rsp_t user_mgr_obi_rsp_i,

  input logic [ GpioCount-1:0] 	     gpio_in_sync_i, // synchronized GPIO inputs
  output logic [NumExternalIrqs-1:0] interrupts_o // interrupts to core
);

  assign interrupts_o = '0;  


  //////////////////////
  // User Manager MUX //
  /////////////////////

  // No manager so we don't need a obi_mux module and just terminate the request properly
  assign user_mgr_obi_req_o = '0;


  ////////////////////////////
  // User Subordinate DEMUX //
  ////////////////////////////

  // ----------------------------------------------------------------------------------------------
  // User Subordinate Buses
  // ----------------------------------------------------------------------------------------------
  
  // collection of signals from the demultiplexer
  sbr_obi_req_t [NumDemuxSbr-1:0] all_user_sbr_obi_req;
  sbr_obi_rsp_t [NumDemuxSbr-1:0] all_user_sbr_obi_rsp;

  // Error Subordinate Bus
  sbr_obi_req_t user_error_obi_req;
  sbr_obi_rsp_t user_error_obi_rsp;

  sbr_obi_req_t dpll_obi_req;
  sbr_obi_rsp_t dpll_obi_rsp;

// `ifdef ENABLE_CD_DAC
//   sbr_obi_req_t dac_obi_req;
//   sbr_obi_rsp_t dac_obi_rsp;
// `endif

  // Fanout into more readable signals
  assign user_error_obi_req              = all_user_sbr_obi_req[UserError];
  assign all_user_sbr_obi_rsp[UserError] = user_error_obi_rsp;
  assign dpll_obi_req              = all_user_sbr_obi_req[UserDpll];
  assign all_user_sbr_obi_rsp[UserDpll] = dpll_obi_rsp;

// `ifdef ENABLE_CD_DAC
//    assign dac_obi_req              = all_user_sbr_obi_req[UserDac];
//    assign all_user_sbr_obi_rsp[UserDac] = dac_obi_rsp;
// `endif


  //-----------------------------------------------------------------------------------------------
  // Demultiplex to User Subordinates according to address map
  //-----------------------------------------------------------------------------------------------

  logic [cf_math_pkg::idx_width(NumDemuxSbr)-1:0] user_idx;

  addr_decode #(
    .NoIndices ( NumDemuxSbr                    ),
    .NoRules   ( NumDemuxSbrRules               ),
    .addr_t    ( logic[SbrObiCfg.DataWidth-1:0] ),
    .rule_t    ( addr_map_rule_t                ),
    .Napot     ( 1'b0                           )
  ) i_addr_decode_periphs (
    .addr_i           ( user_sbr_obi_req_i.a.addr ),
    .addr_map_i       ( user_addr_map             ),
    .idx_o            ( user_idx                  ),
    .dec_valid_o      (),
    .dec_error_o      (),
    .en_default_idx_i ( 1'b1 ),
    .default_idx_i    ( '0   )
  );

  obi_demux #(
    .ObiCfg      ( SbrObiCfg     ),
    .obi_req_t   ( sbr_obi_req_t ),
    .obi_rsp_t   ( sbr_obi_rsp_t ),
    .NumMgrPorts ( NumDemuxSbr   ),
    .NumMaxTrans ( 2             )
  ) i_obi_demux (
    .clk_i,
    .rst_ni,

    .sbr_port_select_i ( user_idx             ),
    .sbr_port_req_i    ( user_sbr_obi_req_i   ),
    .sbr_port_rsp_o    ( user_sbr_obi_rsp_o   ),

    .mgr_ports_req_o   ( all_user_sbr_obi_req ),
    .mgr_ports_rsp_i   ( all_user_sbr_obi_rsp )
  );


//-------------------------------------------------------------------------------------------------
// User Subordinates
//-------------------------------------------------------------------------------------------------

  // Error Subordinate
  obi_err_sbr #(
    .ObiCfg      ( SbrObiCfg     ),
    .obi_req_t   ( sbr_obi_req_t ),
    .obi_rsp_t   ( sbr_obi_rsp_t ),
    .NumMaxTrans ( 1             ),
    .RspData     ( 32'hBADCAB1E  )
  ) i_user_err (
    .clk_i,
    .rst_ni,
    .testmode_i ( testmode_i      ),
    .obi_req_i  ( user_error_obi_req ),
    .obi_rsp_o  ( user_error_obi_rsp )
  );

   // DPLL
  obi_dpll #(
    .ObiCfg    ( SbrObiCfg     ),
    .obi_req_t ( sbr_obi_req_t ),
    .obi_rsp_t ( sbr_obi_rsp_t )
  ) i_dpll (
    .clk_i,
    .rst_ni,
   
    .obi_req_i ( dpll_obi_req ),
    .obi_rsp_o ( dpll_obi_rsp ),

    .dpll_en_o		( dpll_en_o	),
    .dpll_dco_o		( dpll_dco_o    ),
    .dpll_div_o		( dpll_div_o    ),
    .dpll_rstn_o	( dpll_rstn_o   ),
    .dpll_extrim_o	( dpll_extrim_o )
);
// `ifdef ENABLE_CD_DAC
//   // DAC
//   obi_dac #(
//     .ObiCfg    ( SbrObiCfg     ),
//     .obi_req_t ( sbr_obi_req_t ),
//     .obi_rsp_t ( sbr_obi_rsp_t )
//   ) i_dac (
//     .clk_i,
//     .rst_ni,

//     .obi_req_i ( dac_obi_req ),
//     .obi_rsp_o ( dac_obi_rsp ),

//     .dac_val_o		( dac_val_o	),
//     .dac_clk_o		( dac_clk_o    )
// );
// `endif
endmodule
