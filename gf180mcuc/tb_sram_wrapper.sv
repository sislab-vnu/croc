`timescale 1ns/1ps

module tb_sram_wrapper;

   parameter WORDS = 64;
   parameter WIDTH = 32;
   localparam ADDR_WIDTH = $clog2(WORDS);

  // DUT Signals
   reg                   clk;
   reg                   cen;
   reg                   gwen;
   reg [WIDTH-1:0] 	 wen;
   reg [ADDR_WIDTH-1:0]  addr;
   reg [WIDTH-1:0] 	 din;
   wire [WIDTH-1:0] 	 dout;
   wire [ADDR_WIDTH-1:0] max_addr;
   assign max_addr = {ADDR_WIDTH{1'b1}};
  // Clock Generation
  initial clk = 0;
  always #5 clk = ~clk;  // 100MHz

  // DUT Instantiation
  gf180mcu_sram_wrapper #(
    .WORDS(WORDS),
    .WIDTH(WIDTH)
  ) dut (
    .clk(clk),
    .cen(cen),
    .gwen(gwen),
    .wen(wen),
    .addr(addr),
    .din(din),
    .dout(dout)
  );

  // Test Procedure
  initial begin
     $display("==== SRAM Test Started ====");
     cen  = 1; gwen = 1; wen = {WIDTH{1'b1}}; addr = 0; din = 0;

     // Wait for reset-like condition
     repeat(20) @(posedge clk);

     // Enable Memory
     #2 cen = 0;
     @(posedge clk);
     
     // Write All 1s with Full Mask
     #2 addr = 8'h0A;
     din  = 64'hFFFF_FFFF_FFFF_FFFF;
     wen  = 64'h00_00_00_00_00_00_00_00;  // Enable all bits
     gwen = 0;  // Write
     $display("Write @%X = %h (mask=%X)", addr, din, wen);
     @(posedge clk);
     
     // Partial Mask Write (only upper 32 bits)
     #2 addr = 8'h0B;
     din  = 64'hDEAD_BEEF_FACE_CAFE;
     wen  = 64'h00_00_00_00_FF_FF_FF_FF;  // Mask lower 32 bits
     gwen = 0;
     $display("Write @%X = %h (mask=%X)", addr, din, wen);
     @(posedge clk);

     // Partial Mask Write (only upper 32 bits)
     #2 addr = 8'h0C;
     din  = 64'hAAAA_AAAA_AAAA_AAAA;
     wen  = 64'h0000_0000_FFFF_FFFF;  // Mask lower 32 bits
     gwen = 0;
     $display("Write @%X = %h (mask=%X)", addr, din, wen);
     @(posedge clk);

     #2 addr = 8'h0D;
     din  = 64'h9999_9999_9999_9999;
     wen  = 64'hFFFF_FFFF_0000_0000;  // Mask lower 32 bits
     gwen = 0;
     $display("Write @%X = %h (mask=%X)", addr, din, wen);
     @(posedge clk);

     #2 addr = max_addr;
     din  = 64'h9999_9999_9999_9999;
     wen  = 64'h0000_0000_0000_0000;  // Mask lower 32 bits
     gwen = 0;
     $display("Write @%X = %h (mask=%X)", addr, din, wen);
     @(posedge clk);

     // Readback
     #2 gwen = 1; wen = {WIDTH{1'b1}};
     addr = 8'h0A;
     @(posedge clk);
     #2 $display("READ @%X = %h", addr, dout);

     addr = 8'h0B;
     @(posedge clk);
     #2 $display("READ @%X = %h", addr, dout);

     addr = 8'h0C;
     @(posedge clk);
     #2 $display("READ @%X = %h", addr, dout);

     addr = 8'h0D;
     @(posedge clk);
     #2 $display("READ @%X = %h", addr, dout);

     addr = max_addr;
     @(posedge clk);
     #2 $display("READ @%X = %h", max_addr, dout);

     $display("==== SRAM Test Completed ====");
     $stop;
  end

endmodule
