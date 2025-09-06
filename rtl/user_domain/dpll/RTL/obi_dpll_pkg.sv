// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Hannah Pochert  <hpochert@ethz.ch>
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>

package obi_dpll_pkg;

  //-- Configurable values -----------------------------------------------------------------------
  localparam int RegAlignBytes = 4; // regs aligned to this many bytes (4 -> 32-bit aligned)

  // Number of input synchronization stages
  localparam int NrSyncStages = 2;

  ////////////////////////////////////////////////////////////////////////////////////////////////
  // RX and TX Statemachine typedefs //
  ////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Address Offsets //
  ////////////////////////////////////////////////////////////////////////////////////////////////
  localparam int RegWidthCfg      = 8;
  localparam int RegWidthExtrim   = 8;
  // Address widths used for decoding
  localparam int AddressBits   = 2;
  localparam int AddressOffset = $clog2(RegAlignBytes);

  // Register Address Offsets
  localparam bit [AddressBits-1:0] RegAddrCFG = 2'b00;
  localparam bit [AddressBits-1:0] RegAddrEXTRIM = 2'b01;
  localparam bit [AddressBits-1:0] RegAddrSTATUS = 2'b10;
  localparam bit [AddressBits-1:0] RegAddrISR = 2'b11;


  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Single Register Unions for Register Interface//
  ////////////////////////////////////////////////////////////////////////////////////////////////

  //----------------------------------------------------------------------------------------------
  // Single Register Structs with Bit Definitions
  //----------------------------------------------------------------------------------------------


  typedef struct packed {
     logic 	 pll_en;	// 1: enable; 0: disable
     logic 	 dco;           // dco_mode
     logic 	 unused4;       // Optional: DMA
     logic [4:0] div;		// 
  } pll_config_bits_t;

  typedef struct packed {
     logic [5:0] unused;
     logic [25:0] extrim;
  } extrim_bits_t;


  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Registers //
  ////////////////////////////////////////////////////////////////////////////////////////////////

  typedef struct packed {
     pll_config_bits_t CFG;    // PLL config
     extrim_bits_t EXTRIM; // extrim bits
  } dpll_reg_fields_t;


  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Default/Reset Register Values //
  ////////////////////////////////////////////////////////////////////////////////////////////////

  // Default values for the Registers from UART 16550A Standard
  localparam dpll_reg_fields_t RegResetVal = '{
    CFG: 8'h00,
    EXTRIM: 32'h0000_0000
  };


  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Interface between UART INTERNAL LOGIC and Register //
  ////////////////////////////////////////////////////////////////////////////////////////////////

  typedef struct packed {
    // current register values
     pll_config_bits_t CFG;
     extrim_bits_t EXTRIM;
    // read/write indicators
    logic      obi_read_cfg;
    logic      obi_read_extrim;
  } reg_read_t;

  typedef struct packed {
     pll_config_bits_t CFG;
     extrim_bits_t EXTRIM;
     logic 	 obi_write_cfg;
     logic 	 obi_write_extrim;
  } reg_write_t;


endpackage
