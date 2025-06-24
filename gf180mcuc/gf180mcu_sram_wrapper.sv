module gf180mcu_sram_wrapper #(
    parameter integer WORDS = 256,          // Number of words (depth), e.g., 64, 128, 256, 512
    parameter integer WIDTH = 64            // Number of bits (must be a multiple of 8)
)(
    input                      clk,         // Clock input
    input                      cen,         // Chip Enable (Active Low)
    input                      gwen,        // Global Write Enable. Low = write, High = read
    input      [WIDTH-1:0]     wen,         // Bit Write Mask (Active Low)
    input      [$clog2(WORDS)-1:0] addr,    // Address input
    input      [WIDTH-1:0]     din,         // Data input
    output     [WIDTH-1:0]     dout         // Data output
);

  // Number of banks = WIDTH / 8 (each bank handles 8 bits)
  localparam NUM_BANKS = WIDTH / 8;

  genvar i;
  generate
    for (i = 0; i < NUM_BANKS; i = i + 1) begin : gen_bank
      // Select the appropriate module based on memory depth
      // Module names must be matched manually or through synthesis tool parameter mapping
      if (WORDS == 64) begin
        gf180mcu_fd_ip_sram__sram64x8m8wm1 u_sram_bank (
          .CLK  (clk),
          .CEN  (cen),
          .GWEN (gwen),
          .WEN  (wen[i*8 +: 8]),
          .A    (addr),
          .D    (din[i*8 +: 8]),
          .Q    (dout[i*8 +: 8])
        );
      end else if (WORDS == 128) begin
        gf180mcu_fd_ip_sram__sram128x8m8wm1 u_sram_bank (
          .CLK  (clk),
          .CEN  (cen),
          .GWEN (gwen),
          .WEN  (wen[i*8 +: 8]),
          .A    (addr),
          .D    (din[i*8 +: 8]),
          .Q    (dout[i*8 +: 8])
        );
      end else if (WORDS == 256) begin
        gf180mcu_fd_ip_sram__sram256x8m8wm1 u_sram_bank (
          .CLK  (clk),
          .CEN  (cen),
          .GWEN (gwen),
          .WEN  (wen[i*8 +: 8]),
          .A    (addr),
          .D    (din[i*8 +: 8]),
          .Q    (dout[i*8 +: 8])
        );
      end else if (WORDS == 512) begin
        gf180mcu_fd_ip_sram__sram512x8m8wm1 u_sram_bank (
          .CLK  (clk),
          .CEN  (cen),
          .GWEN (gwen),
          .WEN  (wen[i*8 +: 8]),
          .A    (addr),
          .D    (din[i*8 +: 8]),
          .Q    (dout[i*8 +: 8])
        );
      end else begin
        // Unsupported configuration
        initial $error("Unsupported memory depth: %0d. Only 64/128/256/512 supported.", WORDS);
      end
    end
  endgenerate

endmodule // gf180mcu_sram_wrappe
