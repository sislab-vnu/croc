// Copyright 2023 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Thomas Benz <tbenz@iis.ee.ethz.ch>
// - Tobias Senti <tsenti@student.ethz.ch>
// - Paul Scheffler <paulsc@iis.ee.ethz.ch>

module tc_sram_blackbox #(
  parameter int unsigned NumWords     = 32'd0,
  parameter int unsigned DataWidth    = 32'd0,
  parameter int unsigned ByteWidth    = 32'd0,
  parameter int unsigned NumPorts     = 32'd0,
  parameter int unsigned Latency      = 32'd0,
  parameter              SimInit      = "none",
  parameter bit          PrintSimCfg  = 1'b0,
  parameter              ImplKey      = "none"
) ();
endmodule


module tc_sram_impl #(
  parameter int unsigned NumWords     = 32'd512,
  parameter int unsigned DataWidth    = 32'd32,
  parameter int unsigned ByteWidth    = 32'd8,
  parameter int unsigned NumPorts     = 32'd1,
  parameter int unsigned Latency      = 32'd1,
  parameter              SimInit      = "none",
  parameter bit          PrintSimCfg  = 1'b0,
  parameter              ImplKey      = "none",
  parameter type         impl_in_t    = logic,
  parameter type         impl_out_t   = logic,
  parameter impl_out_t   ImplOutSim   = 'X,
  // DEPENDENT PARAMETERS, DO NOT OVERWRITE!
  parameter int unsigned AddrWidth = (NumWords > 32'd1) ? $clog2(NumWords) : 32'd1,
  parameter int unsigned BeWidth   = (DataWidth + ByteWidth - 32'd1) / ByteWidth,
  parameter type         addr_t    = logic [AddrWidth-1:0],
  parameter type         data_t    = logic [DataWidth-1:0],
  parameter type         be_t      = logic [BeWidth-1:0]
) (
  input  logic                 clk_i,
  input  logic                 rst_ni,

  input  impl_in_t             impl_i,
  output impl_out_t            impl_o,

  input  logic  [NumPorts-1:0] req_i,
  input  logic  [NumPorts-1:0] we_i,
  input  addr_t [NumPorts-1:0] addr_i,
  input  data_t [NumPorts-1:0] wdata_i,
  input  be_t   [NumPorts-1:0] be_i,

  output data_t [NumPorts-1:0] rdata_o
);

  localparam P1L1 = (NumPorts == 1 & Latency == 1);

  // Assemble bit mask
  data_t [NumPorts-1:0] bm;

  for (genvar p = 0; p < NumPorts; ++p) begin : gen_bm_ports
      for (genvar b = 0; b < DataWidth; ++b) begin : gen_bm_bits
        assign bm[p][b] = be_i[p][b/ByteWidth];
      end
  end

  // We drive a static value for `impl_o` in behavioral simulation.
  assign impl_o = ImplOutSim;

  // Generate desired cuts
  if (NumWords == 64 && DataWidth == 64 && P1L1) begin: gen_64x64xBx1
    logic [63:0] wdata64, rdata64, bm64;
    
    assign rdata_o = rdata64;
    assign wdata64 = wdata_i;
    assign bm64    = bm;
    
  gf180mcu_sram_wrapper #(
    .WORDS(NumWords),
    .WIDTH(DataWidth)
  ) i_cut (
    .clk(clk_i),
    .cen(~req_i),
    .gwen(~we_i),
    .wen(~bm64),
    .addr(addr_i[0][5:0]),
    .din(wdata64),
    .dout(rdata64)
  );

    // RM_IHPSG13_1P_64x64_c2_bm_bist i_cut (
    //   .A_CLK   ( clk_i    ),
    //   .A_DLY   ( impl_i  ),
    //   .A_ADDR  ( addr_i [0][5:0] ),
    //   .A_BM    ( bm64     ),
    //   .A_MEN   ( req_i    ),
    //   .A_WEN   ( we_i     ),
    //   .A_REN   ( ~we_i    ),
    //   .A_DIN   ( wdata64  ),
    //   .A_DOUT  ( rdata64  ),
    //  `IHP13_TC_SRAM_64x64_TIEOFF
    // );

  end else if (NumWords == 256 & DataWidth == 64 & P1L1) begin : gen_256x64xBx1
    logic [63:0] wdata64, rdata64, bm64;
    
    assign rdata_o = rdata64;
    assign wdata64 = wdata_i;
    assign bm64    = bm;

  gf180mcu_sram_wrapper #(
    .WORDS(NumWords),
    .WIDTH(DataWidth)
  ) i_cut (
    .clk(clk_i),
    .cen(~req_i),
    .gwen(~we_i),
    .wen(~bm64),
    .addr(addr_i[0][7:0]),
    .din(wdata64),
    .dout(rdata64)
  );
    // RM_IHPSG13_1P_256x64_c2_bm_bist i_cut (
    //   .A_CLK   ( clk_i    ),
    //   .A_DLY   ( impl_i  ),
    //   .A_ADDR  ( addr_i [0][7:0] ),
    //   .A_BM    ( bm64     ),
    //   .A_MEN   ( req_i    ),
    //   .A_WEN   ( we_i     ),
    //   .A_REN   ( ~we_i    ),
    //   .A_DIN   ( wdata64  ),
    //   .A_DOUT  ( rdata64  ),
    //  `IHP13_TC_SRAM_256x64_TIEOFF
    // );

  end else if (NumWords == 512 & DataWidth == 64 & P1L1) begin : gen_512x64xBx1
    logic [63:0] wdata64, rdata64, bm64;
    
    assign rdata_o = rdata64;
    assign wdata64 = wdata_i;
    assign bm64    = bm;

  gf180mcu_sram_wrapper #(
    .WORDS(NumWords),
    .WIDTH(DataWidth)
  ) i_cut (
    .clk(clk_i),
    .cen(~req_i),
    .gwen(~we_i),
    .wen(~bm64),
    .addr(addr_i[0][8:0]),
    .din(wdata64),
    .dout(rdata64)
  );

    // RM_IHPSG13_1P_512x64_c2_bm_bist i_cut (
    //   .A_CLK   ( clk_i    ),
    //   .A_DLY   ( impl_i  ),
    //   .A_ADDR  ( addr_i [0][8:0] ),
    //   .A_BM    ( bm64     ),
    //   .A_MEN   ( req_i    ),
    //   .A_WEN   ( we_i     ),
    //   .A_REN   ( ~we_i    ),
    //   .A_DIN   ( wdata64  ),
    //   .A_DOUT  ( rdata64  ),
    //  `IHP13_TC_SRAM_512x64_TIEOFF
    // );

  end else if (NumWords == 1024 & DataWidth == 64 & P1L1) begin : gen_1024x64xBx1
    logic [63:0] wdata64, rdata64, bm64;
    
    assign rdata_o = rdata64;
    assign wdata64 = wdata_i;
    assign bm64    = bm;

  gf180mcu_sram_wrapper #(
    .WORDS(NumWords),
    .WIDTH(DataWidth)
  ) i_cut (
    .clk(clk_i),
    .cen(~req_i),
    .gwen(~we_i),
    .wen(~bm64),
    .addr(addr_i[0][9:0]),
    .din(wdata64),
    .dout(rdata64)
  );
    // RM_IHPSG13_1P_1024x64_c2_bm_bist i_cut (
    //    .A_CLK   ( clk_i    ),
    //    .A_DLY   ( impl_i  ),
    //    .A_ADDR  ( addr_i [0][9:0] ),
    //    .A_BM    ( bm64     ),
    //    .A_MEN   ( req_i    ),
    //    .A_WEN   ( we_i     ),
    //    .A_REN   ( ~we_i    ),
    //    .A_DIN   ( wdata64  ),
    //    .A_DOUT  ( rdata64  ),
    //    `IHP13_TC_SRAM_1024x64_TIEOFF
    //   );

  end else if (NumWords == 2048 & DataWidth == 64 & P1L1) begin : gen_2048x64xBx1
    logic [63:0] wdata64, rdata64, bm64;
    
    assign rdata_o = rdata64;
    assign wdata64 = wdata_i;
    assign bm64    = bm;

  gf180mcu_sram_wrapper #(
    .WORDS(NumWords),
    .WIDTH(DataWidth)
  ) i_cut (
    .clk(clk_i),
    .cen(~req_i),
    .gwen(~we_i),
    .wen(~bm64),
    .addr(addr_i[0][10:0]),
    .din(wdata64),
    .dout(rdata64)
  );

    // RM_IHPSG13_1P_2048x64_c2_bm_bist i_cut (
    //    .A_CLK   ( clk_i    ),
    //    .A_DLY   ( impl_i   ),
    //    .A_ADDR  ( addr_i [0][10:0] ),
    //    .A_BM    ( bm64     ),
    //    .A_MEN   ( req_i    ),
    //    .A_WEN   ( we_i     ),
    //    .A_REN   ( ~we_i    ),
    //    .A_DIN   ( wdata64  ),
    //    .A_DOUT  ( rdata64  ),
    //    `IHP13_TC_SRAM_2048x64_TIEOFF
    //   );
  end else if (NumWords == 512 && DataWidth == 32 && P1L1) begin: gen_512x32xBx1
    logic [32:0] wdata32, rdata32, bm32;
    
    assign rdata_o = rdata32;
    assign wdata32 = wdata_i;
    assign bm32    = bm;

  gf180mcu_sram_wrapper #(
    .WORDS(NumWords),
    .WIDTH(DataWidth)
  ) i_cut (
    .clk(clk_i),
    .cen(~req_i),
    .gwen(~we_i),
    .wen(~bm32),
    .addr(addr_i[0][8:0]),
    .din(wdata32),
    .dout(rdata32)
  );

    // RM_IHPSG13_1P_256x64_c2_bm_bist i_cut (
    //  .A_CLK   ( clk_i   ),
    //  .A_DLY   ( impl_i  ),
    //  .A_ADDR  ( addr_i [0][8:1] ),
    //  .A_BM    ( bm64    ),
    //  .A_MEN   ( req_i   ),
    //  .A_WEN   ( we_i    ),
    //  .A_REN   ( ~we_i   ),
    //  .A_DIN   ( wdata64 ),
    //  .A_DOUT  ( rdata64 ),
    //  `IHP13_TC_SRAM_256x64_TIEOFF
    // );

  end else if (NumWords == 1024 && DataWidth == 32 && P1L1) begin: gen_1024x32xBx1
    logic [32:0] wdata32, rdata32, bm32;
    
    assign rdata_o = rdata32;
    assign wdata32 = wdata_i;
    assign bm32    = bm;

  gf180mcu_sram_wrapper #(
    .WORDS(NumWords),
    .WIDTH(DataWidth)
  ) i_cut (
    .clk(clk_i),
    .cen(~req_i),
    .gwen(~we_i),
    .wen(~bm32),
    .addr(addr_i[0][9:0]),
    .din(wdata32),
    .dout(rdata32)
  );

    // RM_IHPSG13_1P_512x64_c2_bm_bist i_cut (
    //  .A_CLK   ( clk_i   ),
    //  .A_DLY   ( impl_i  ),
    //  .A_ADDR  ( addr_i [0][9:1] ),
    //  .A_BM    ( bm64    ),
    //  .A_MEN   ( req_i   ),
    //  .A_WEN   ( we_i    ),
    //  .A_REN   ( ~we_i   ),
    //  .A_DIN   ( wdata64 ),
    //  .A_DOUT  ( rdata64 ),
    //  `IHP13_TC_SRAM_512x64_TIEOFF
    // );
  end else if (NumWords == 2048 && DataWidth == 32 && P1L1) begin: gen_2048x32xBx1
    logic [32:0] wdata32, rdata32, bm32;
    
    assign rdata_o = rdata32;
    assign wdata32 = wdata_i;
    assign bm32    = bm;

  gf180mcu_sram_wrapper #(
    .WORDS(NumWords),
    .WIDTH(DataWidth)
  ) i_cut (
    .clk(clk_i),
    .cen(~req_i),
    .gwen(~we_i),
    .wen(~bm32),
    .addr(addr_i[0][10:0]),
    .din(wdata32),
    .dout(rdata32)
  );
    // RM_IHPSG13_1P_1024x64_c2_bm_bist i_cut (
    //  .A_CLK   ( clk_i   ),
    //  .A_DLY   ( impl_i  ),
    //  .A_ADDR  ( addr_i [0][10:1] ),
    //  .A_BM    ( bm64    ),
    //  .A_MEN   ( req_i   ),
    //  .A_WEN   ( we_i    ),
    //  .A_REN   ( ~we_i   ),
    //  .A_DIN   ( wdata64 ),
    //  .A_DOUT  ( rdata64 ),
    //  `IHP13_TC_SRAM_1024x64_TIEOFF
    // );

  end else begin : gen_blackbox

  `ifndef SYNTHESIS
    initial $fatal("No tc_sram for %m: NumWords %0d, DataWidth %0d NumPorts %0d, Latency %0d",
        NumWords, DataWidth, NumPorts);
  `endif

  // Instantiate a non-linkable blackbox with parameters for debugging
  `ifdef SYNTHESIS
    (* dont_touch = "true" *)
    tc_sram_blackbox #(
      .NumWords     ( NumWords    ),
      .DataWidth    ( DataWidth   ),
      .ByteWidth    ( ByteWidth   ),
      .NumPorts     ( NumPorts    ),
      .Latency      ( Latency     ),
      .SimInit      ( SimInit     ),
      .PrintSimCfg  ( PrintSimCfg ),
      .ImplKey      ( ImplKey     )
    ) i_sram_blackbox ();
  `endif

end

endmodule
