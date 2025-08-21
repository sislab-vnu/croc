module gf180mcu_sram_wrapper #(
  parameter integer WORDS = 256,
  parameter integer WIDTH = 64
)(
  input  wire                     clk,
  input  wire                     cen,
  input  wire                     gwen,
  input  wire [WIDTH-1:0]         wen,
  input  wire [$clog2(WORDS)-1:0] addr,
  input  wire [WIDTH-1:0]         din,
  output wire [WIDTH-1:0]         dout
);

  localparam integer BYTES           = WIDTH / 8;
  localparam integer PHYS_DEPTH      = (WORDS <= 64)  ? 64  :
                                       (WORDS <= 128) ? 128 :
                                       (WORDS <= 256) ? 256 : 512;
  localparam integer NUM_BANKS       = WORDS / PHYS_DEPTH;
  localparam integer BANK_ADDR_WIDTH = $clog2(PHYS_DEPTH);
  localparam integer BANK_SEL_WIDTH  = (NUM_BANKS > 1) ? $clog2(NUM_BANKS) : 1;

  wire [BANK_SEL_WIDTH-1:0] bank_sel;
  wire [BANK_ADDR_WIDTH-1:0] local_addr = addr[BANK_ADDR_WIDTH-1:0];

  generate
    if (NUM_BANKS > 1) begin
      assign bank_sel = addr[$clog2(WORDS)-1 -: BANK_SEL_WIDTH];
    end else begin
      assign bank_sel = '0;
    end
  endgenerate

  genvar i, j;
  generate
    for (i = 0; i < BYTES; i = i + 1) begin : byte_slice
      wire [7:0] wdata = din[i*8 +: 8];
      wire [7:0] wmask = wen[i*8 +: 8];
      wire [7:0] rdata[NUM_BANKS-1:0];

      for (j = 0; j < NUM_BANKS; j = j + 1) begin : depth_bank
        wire cen_masked = cen | (bank_sel != j);

        if (PHYS_DEPTH == 64) begin
          gf180mcu_fd_ip_sram__sram64x8m8wm1 u_sram (
            .CLK  ( clk        ),
            .CEN  ( cen_masked ),
            .GWEN ( gwen       ),
            .WEN  ( wmask      ),
            .A    ( local_addr ),
            .D    ( wdata      ),
            .Q    ( rdata[j]   )
          );
        end else if (PHYS_DEPTH == 128) begin
          gf180mcu_fd_ip_sram__sram128x8m8wm1 u_sram (
            .CLK  ( clk        ),
            .CEN  ( cen_masked ),
            .GWEN ( gwen       ),
            .WEN  ( wmask      ),
            .A    ( local_addr ),
            .D    ( wdata      ),
            .Q    ( rdata[j]   )
          );
        end else if (PHYS_DEPTH == 256) begin
          gf180mcu_fd_ip_sram__sram256x8m8wm1 u_sram (
            .CLK  ( clk        ),
            .CEN  ( cen_masked ),
            .GWEN ( gwen       ),
            .WEN  ( wmask      ),
            .A    ( local_addr ),
            .D    ( wdata      ),
            .Q    ( rdata[j]   )
          );
        end else begin
          gf180mcu_fd_ip_sram__sram512x8m8wm1 u_sram (
            .CLK  ( clk        ),
            .CEN  ( cen_masked ),
            .GWEN ( gwen       ),
            .WEN  ( wmask      ),
            .A    ( local_addr ),
            .D    ( wdata      ),
            .Q    ( rdata[j]   )
          );
        end
      end

      assign dout[i*8 +: 8] = rdata[bank_sel];
    end
  endgenerate

endmodule
// module gf180mcu_sram_wrapper #(
//     parameter integer WORDS = 256,          // Number of words (depth), e.g., 64, 128, 256, 512
//     parameter integer WIDTH = 64            // Number of bits (must be a multiple of 8)
// )(
//     input                      clk,         // Clock input
//     input                      cen,         // Chip Enable (Active Low)
//     input                      gwen,        // Global Write Enable. Low = write, High = read
//     input      [WIDTH-1:0]     wen,         // Bit Write Mask (Active Low)
//     input      [$clog2(WORDS)-1:0] addr,    // Address input
//     input      [WIDTH-1:0]     din,         // Data input
//     output     [WIDTH-1:0]     dout         // Data output
// );

//   // Number of banks = WIDTH / 8 (each bank handles 8 bits)
//   localparam NUM_BANKS = WIDTH / 8;

//   genvar i;
//   generate
//     for (i = 0; i < NUM_BANKS; i = i + 1) begin : gen_bank
//       // Select the appropriate module based on memory depth
//       // Module names must be matched manually or through synthesis tool parameter mapping
//       if (WORDS == 64) begin
//         gf180mcu_fd_ip_sram__sram64x8m8wm1 u_sram_bank (
//           .CLK  (clk),
//           .CEN  (cen),
//           .GWEN (gwen),
//           .WEN  (wen[i*8 +: 8]),
//           .A    (addr),
//           .D    (din[i*8 +: 8]),
//           .Q    (dout[i*8 +: 8])
//         );
//       end else if (WORDS == 128) begin
//         gf180mcu_fd_ip_sram__sram128x8m8wm1 u_sram_bank (
//           .CLK  (clk),
//           .CEN  (cen),
//           .GWEN (gwen),
//           .WEN  (wen[i*8 +: 8]),
//           .A    (addr),
//           .D    (din[i*8 +: 8]),
//           .Q    (dout[i*8 +: 8])
//         );
//       end else if (WORDS == 256) begin
//         gf180mcu_fd_ip_sram__sram256x8m8wm1 u_sram_bank (
//           .CLK  (clk),
//           .CEN  (cen),
//           .GWEN (gwen),
//           .WEN  (wen[i*8 +: 8]),
//           .A    (addr),
//           .D    (din[i*8 +: 8]),
//           .Q    (dout[i*8 +: 8])
//         );
//       end else if (WORDS == 512) begin
//         gf180mcu_fd_ip_sram__sram512x8m8wm1 u_sram_bank (
//           .CLK  (clk),
//           .CEN  (cen),
//           .GWEN (gwen),
//           .WEN  (wen[i*8 +: 8]),
//           .A    (addr),
//           .D    (din[i*8 +: 8]),
//           .Q    (dout[i*8 +: 8])
//         );
//       end else begin
//         // Unsupported configuration
//         initial $error("Unsupported memory depth: %0d. Only 64/128/256/512 supported.", WORDS);
//       end
//     end
//   endgenerate

// endmodule // gf180mcu_sram_wrappe
