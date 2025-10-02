// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>

`include "register_interface/typedef.svh"
`include "obi/typedef.svh"

`define ENABLE_CD_DAC

package user_pkg;

  ////////////////////////////////
  // User Manager Address maps //
  ///////////////////////////////
  
  // None


  /////////////////////////////////////
  // User Subordinate Address maps ////
  /////////////////////////////////////

 `ifdef ENABLE_CD_DAC
    localparam int unsigned NumUserDomainSubordinates = 2;
 `else
   localparam int unsigned NumUserDomainSubordinates = 1;
 `endif



  localparam bit [31:0] UserRomAddrOffset   = croc_pkg::UserBaseAddr; // 32'h2000_0000;
  localparam bit [31:0] UserRomAddrRange    = 32'h0000_1000;          // every subordinate has at least 4KB

  localparam bit [31:0] DpllAddrOffset    = croc_pkg::UserBaseAddr;
  localparam bit [31:0] DpllAddrRange     = 32'h0000_1000;

 `ifdef ENABLE_CD_DAC
   localparam bit [31:0] DacAddrOffset    = croc_pkg::UserBaseAddr + DpllAddrRange;
   localparam bit [31:0] DacAddrRange     = 32'h0000_1000;
 `endif

  localparam int unsigned NumDemuxSbrRules  = NumUserDomainSubordinates; // number of address rules in the decoder
  localparam int unsigned NumDemuxSbr       = NumDemuxSbrRules + 1; // additional OBI error, used for signal arrays

  // Enum for bus indices
  typedef enum int {
    UserError = 0,
    UserDpll = 1
 `ifdef ENABLE_CD_DAC
    , UserDac = 2
 `endif
  } user_demux_outputs_e;

  // Address rules given to address decoder
  localparam croc_pkg::addr_map_rule_t [NumDemuxSbrRules-1:0] user_addr_map = '{
     '{idx: UserDpll, start_addr: DpllAddrOffset, end_addr: DpllAddrOffset + DpllAddrRange}
 `ifdef ENABLE_CD_DAC
     ,'{idx: UserDac, start_addr: DacAddrOffset, end_addr: DacAddrOffset + DacAddrRange}
 `endif
};

endpackage
