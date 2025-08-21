`timescale 1ns/1ps

module tb_sram_wrapper;

  parameter integer WORDS = 2048;
  parameter integer WIDTH = 64;
  localparam ADDR_WIDTH = $clog2(WORDS);

  // DUT Signals
  reg                   clk;
  reg                   cen;
  reg                   gwen;
  reg  [WIDTH-1:0]      wen;
  reg  [ADDR_WIDTH-1:0] addr;
  reg  [WIDTH-1:0]      din;
  wire [WIDTH-1:0]      dout;

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // DUT instantiation
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

  // Predictable byte-aligned data pattern
  function [WIDTH-1:0] gen_data(input integer seed);
    integer i;
    begin
      for (i = 0; i < WIDTH; i = i + 8)
        gen_data[i +: 8] = (seed + i) % 256;
    end
  endfunction

  // Task: compare actual and expected
  task automatic check_result(
    input [ADDR_WIDTH-1:0] raddr,
    input [WIDTH-1:0] expected,
    input [WIDTH-1:0] actual
  );
    begin
      if (expected === actual)
        $display("✅ PASS: Read @0x%0h = 0x%0h", raddr, actual);
      else
        $display("❌ FAIL: Read @0x%0h = 0x%0h (expected 0x%0h)", raddr, actual, expected);
    end
  endtask

  // Task: write → read → check, with 2-time unit delay before each clock
  task automatic write_read_check(
    input [ADDR_WIDTH-1:0] wr_addr,
    input [WIDTH-1:0]      wr_data,
    input [WIDTH-1:0]      wr_mask
  );
    begin
      addr = wr_addr;
      din  = wr_data;
      wen  = wr_mask;
      gwen = 0;
      #2;
      @(posedge clk);
      $display("✍️  WRITE @0x%0h : data = 0x%0h, mask = 0x%0h", addr, din, wen);

      gwen = 1;
      #2;
      @(posedge clk);
      check_result(addr, wr_data & ~wr_mask, dout & ~wr_mask);
    end
  endtask

  // Test execution
  initial begin
    $display("\n=== SRAM Testbench With Input Delays ===");
    cen = 1; gwen = 1; wen = {WIDTH{1'b1}}; addr = 0; din = 0;
    repeat(2) @(posedge clk);
    cen = 0;

    // Test 1: full write
    write_read_check(8'h10, gen_data(100), {WIDTH{1'b0}});

    // Test 2: half write, upper half masked
    write_read_check(8'h11, gen_data(200), {{WIDTH/2{1'b1}}, {WIDTH/2{1'b0}}});

    // Test 3: full write
    write_read_check({ADDR_WIDTH{1'b1}}, gen_data(101), {WIDTH{1'b0}});
    write_read_check({(ADDR_WIDTH-1){1'b1}}, gen_data(102), {WIDTH{1'b0}});
    write_read_check({(ADDR_WIDTH-2){1'b1}}, gen_data(103), {WIDTH{1'b0}});

    $display("=== All Tests Completed ===\n");
    $stop;
  end

endmodule

// `timescale 1ns/1ps

// module tb_sram_wrapper;

//    parameter WORDS = 64;
//    parameter WIDTH = 32;
//    localparam ADDR_WIDTH = $clog2(WORDS);

//   // DUT Signals
//    reg                   clk;
//    reg                   cen;
//    reg                   gwen;
//    reg [WIDTH-1:0] 	 wen;
//    reg [ADDR_WIDTH-1:0]  addr;
//    reg [WIDTH-1:0] 	 din;
//    wire [WIDTH-1:0] 	 dout;
//    wire [ADDR_WIDTH-1:0] max_addr;
//    assign max_addr = {ADDR_WIDTH{1'b1}};
//   // Clock Generation
//   initial clk = 0;
//   always #5 clk = ~clk;  // 100MHz

//   // DUT Instantiation
//   gf180mcu_sram_wrapper #(
//     .WORDS(WORDS),
//     .WIDTH(WIDTH)
//   ) dut (
//     .clk(clk),
//     .cen(cen),
//     .gwen(gwen),
//     .wen(wen),
//     .addr(addr),
//     .din(din),
//     .dout(dout)
//   );

//   // Test Procedure
//   initial begin
//      $display("==== SRAM Test Started ====");
//      cen  = 1; gwen = 1; wen = {WIDTH{1'b1}}; addr = 0; din = 0;

//      // Wait for reset-like condition
//      repeat(20) @(posedge clk);

//      // Enable Memory
//      #2 cen = 0;
//      @(posedge clk);
     
//      // Write All 1s with Full Mask
//      #2 addr = 8'h0A;
//      din  = 64'hFFFF_FFFF_FFFF_FFFF;
//      wen  = 64'h00_00_00_00_00_00_00_00;  // Enable all bits
//      gwen = 0;  // Write
//      $display("Write @%X = %h (mask=%X)", addr, din, wen);
//      @(posedge clk);
     
//      // Partial Mask Write (only upper 32 bits)
//      #2 addr = 8'h0B;
//      din  = 64'hDEAD_BEEF_FACE_CAFE;
//      wen  = 64'h00_00_00_00_FF_FF_FF_FF;  // Mask lower 32 bits
//      gwen = 0;
//      $display("Write @%X = %h (mask=%X)", addr, din, wen);
//      @(posedge clk);

//      // Partial Mask Write (only upper 32 bits)
//      #2 addr = 8'h0C;
//      din  = 64'hAAAA_AAAA_AAAA_AAAA;
//      wen  = 64'h0000_0000_FFFF_FFFF;  // Mask lower 32 bits
//      gwen = 0;
//      $display("Write @%X = %h (mask=%X)", addr, din, wen);
//      @(posedge clk);

//      #2 addr = 8'h0D;
//      din  = 64'h9999_9999_9999_9999;
//      wen  = 64'hFFFF_FFFF_0000_0000;  // Mask lower 32 bits
//      gwen = 0;
//      $display("Write @%X = %h (mask=%X)", addr, din, wen);
//      @(posedge clk);

//      #2 addr = max_addr;
//      din  = 64'h9999_9999_9999_9999;
//      wen  = 64'h0000_0000_0000_0000;  // Mask lower 32 bits
//      gwen = 0;
//      $display("Write @%X = %h (mask=%X)", addr, din, wen);
//      @(posedge clk);

//      // Readback
//      #2 gwen = 1; wen = {WIDTH{1'b1}};
//      addr = 8'h0A;
//      @(posedge clk);
//      #2 $display("READ @%X = %h", addr, dout);

//      addr = 8'h0B;
//      @(posedge clk);
//      #2 $display("READ @%X = %h", addr, dout);

//      addr = 8'h0C;
//      @(posedge clk);
//      #2 $display("READ @%X = %h", addr, dout);

//      addr = 8'h0D;
//      @(posedge clk);
//      #2 $display("READ @%X = %h", addr, dout);

//      addr = max_addr;
//      @(posedge clk);
//      #2 $display("READ @%X = %h", max_addr, dout);

//      $display("==== SRAM Test Completed ====");
//      $stop;
//   end

// endmodule
