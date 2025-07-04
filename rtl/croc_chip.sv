// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>

module croc_chip import croc_pkg::*; #() (
  input  wire clk_i,
  input  wire rst_ni,
  input  wire ref_clk_i,

  input  wire jtag_tck_i,
  input  wire jtag_trst_ni,
  input  wire jtag_tms_i,
  input  wire jtag_tdi_i,
  output wire jtag_tdo_o,

  input  wire uart_rx_i,
  output wire uart_tx_o,

  input  wire fetch_en_i,
  output wire status_o,

  inout  wire gpio0_io,
  inout  wire gpio1_io,
  inout  wire gpio2_io,
  inout  wire gpio3_io,
  inout  wire gpio4_io,
  inout  wire gpio5_io,
  inout  wire gpio6_io,
  inout  wire gpio7_io,
  inout  wire gpio8_io,
  inout  wire gpio9_io,
  inout  wire gpio10_io,
  inout  wire gpio11_io,
  inout  wire gpio12_io,
  inout  wire gpio13_io,
  inout  wire gpio14_io,
  inout  wire gpio15_io,
  inout  wire gpio16_io,
  inout  wire gpio17_io,
  inout  wire gpio18_io,
  inout  wire gpio19_io,
  inout  wire gpio20_io,
  inout  wire gpio21_io,
  inout  wire gpio22_io,
  inout  wire gpio23_io,
  inout  wire gpio24_io,
  inout  wire gpio25_io,
  inout  wire gpio26_io,
  inout  wire gpio27_io,
  inout  wire gpio28_io,
  inout  wire gpio29_io,
  inout  wire gpio30_io,
  inout  wire gpio31_io,
  output wire unused0_o,
  output wire unused1_o,
  output wire unused2_o,
  output wire unused3_o
); 
    logic soc_clk_i;
    logic soc_rst_ni;
    logic soc_ref_clk_i;
    logic soc_testmode;

    logic soc_jtag_tck_i;
    logic soc_jtag_trst_ni;
    logic soc_jtag_tms_i;
    logic soc_jtag_tdi_i;
    logic soc_jtag_tdo_o;

    logic soc_fetch_en_i;
    logic soc_status_o;

    localparam int unsigned GpioCount = 32;

    logic [GpioCount-1:0] soc_gpio_i;             
    logic [GpioCount-1:0] soc_gpio_o;            
    logic [GpioCount-1:0] soc_gpio_out_en_o; // Output enable signal; 0 -> input, 1 -> output

`ifdef TARGET_IHP13
    sg13g2_IOPadIn        pad_clk_i        (.pad(clk_i),        .p2c(soc_clk_i));
    sg13g2_IOPadIn        pad_rst_ni       (.pad(rst_ni),       .p2c(soc_rst_ni));
    sg13g2_IOPadIn        pad_ref_clk_i    (.pad(ref_clk_i),    .p2c(soc_ref_clk_i));
    assign soc_testmode_i = '0;

    sg13g2_IOPadIn        pad_jtag_tck_i   (.pad(jtag_tck_i),   .p2c(soc_jtag_tck_i));
    sg13g2_IOPadIn        pad_jtag_trst_ni (.pad(jtag_trst_ni), .p2c(soc_jtag_trst_ni));
    sg13g2_IOPadIn        pad_jtag_tms_i   (.pad(jtag_tms_i),   .p2c(soc_jtag_tms_i));
    sg13g2_IOPadIn        pad_jtag_tdi_i   (.pad(jtag_tdi_i),   .p2c(soc_jtag_tdi_i));
    sg13g2_IOPadOut16mA   pad_jtag_tdo_o   (.pad(jtag_tdo_o),   .c2p(soc_jtag_tdo_o));

    sg13g2_IOPadIn        pad_uart_rx_i    (.pad(uart_rx_i),    .p2c(soc_uart_rx_i));
    sg13g2_IOPadOut16mA   pad_uart_tx_o    (.pad(uart_tx_o),    .c2p(soc_uart_tx_o));

    sg13g2_IOPadIn        pad_fetch_en_i   (.pad(fetch_en_i),   .p2c(soc_fetch_en_i));
    sg13g2_IOPadOut16mA   pad_status_o     (.pad(status_o),     .c2p(soc_status_o));

    sg13g2_IOPadInOut30mA pad_gpio0_io     (.pad(gpio0_io),     .c2p(soc_gpio_o[0]),  .p2c(soc_gpio_i[0]),   .c2p_en(soc_gpio_out_en_o[0]));
    sg13g2_IOPadInOut30mA pad_gpio1_io     (.pad(gpio1_io),     .c2p(soc_gpio_o[1]),  .p2c(soc_gpio_i[1]),   .c2p_en(soc_gpio_out_en_o[1]));
    sg13g2_IOPadInOut30mA pad_gpio2_io     (.pad(gpio2_io),     .c2p(soc_gpio_o[2]),  .p2c(soc_gpio_i[2]),   .c2p_en(soc_gpio_out_en_o[2]));
    sg13g2_IOPadInOut30mA pad_gpio3_io     (.pad(gpio3_io),     .c2p(soc_gpio_o[3]),  .p2c(soc_gpio_i[3]),   .c2p_en(soc_gpio_out_en_o[3]));
    sg13g2_IOPadInOut30mA pad_gpio4_io     (.pad(gpio4_io),     .c2p(soc_gpio_o[4]),  .p2c(soc_gpio_i[4]),   .c2p_en(soc_gpio_out_en_o[4]));
    sg13g2_IOPadInOut30mA pad_gpio5_io     (.pad(gpio5_io),     .c2p(soc_gpio_o[5]),  .p2c(soc_gpio_i[5]),   .c2p_en(soc_gpio_out_en_o[5]));
    sg13g2_IOPadInOut30mA pad_gpio6_io     (.pad(gpio6_io),     .c2p(soc_gpio_o[6]),  .p2c(soc_gpio_i[6]),   .c2p_en(soc_gpio_out_en_o[6]));
    sg13g2_IOPadInOut30mA pad_gpio7_io     (.pad(gpio7_io),     .c2p(soc_gpio_o[7]),  .p2c(soc_gpio_i[7]),   .c2p_en(soc_gpio_out_en_o[7]));
    sg13g2_IOPadInOut30mA pad_gpio8_io     (.pad(gpio8_io),     .c2p(soc_gpio_o[8]),  .p2c(soc_gpio_i[8]),   .c2p_en(soc_gpio_out_en_o[8]));
    sg13g2_IOPadInOut30mA pad_gpio9_io     (.pad(gpio9_io),     .c2p(soc_gpio_o[9]),  .p2c(soc_gpio_i[9]),   .c2p_en(soc_gpio_out_en_o[9]));
    sg13g2_IOPadInOut30mA pad_gpio10_io    (.pad(gpio10_io),    .c2p(soc_gpio_o[10]), .p2c(soc_gpio_i[10]),  .c2p_en(soc_gpio_out_en_o[10]));
    sg13g2_IOPadInOut30mA pad_gpio11_io    (.pad(gpio11_io),    .c2p(soc_gpio_o[11]), .p2c(soc_gpio_i[11]),  .c2p_en(soc_gpio_out_en_o[11]));
    sg13g2_IOPadInOut30mA pad_gpio12_io    (.pad(gpio12_io),    .c2p(soc_gpio_o[12]), .p2c(soc_gpio_i[12]),  .c2p_en(soc_gpio_out_en_o[12]));
    sg13g2_IOPadInOut30mA pad_gpio13_io    (.pad(gpio13_io),    .c2p(soc_gpio_o[13]), .p2c(soc_gpio_i[13]),  .c2p_en(soc_gpio_out_en_o[13]));
    sg13g2_IOPadInOut30mA pad_gpio14_io    (.pad(gpio14_io),    .c2p(soc_gpio_o[14]), .p2c(soc_gpio_i[14]),  .c2p_en(soc_gpio_out_en_o[14]));
    sg13g2_IOPadInOut30mA pad_gpio15_io    (.pad(gpio15_io),    .c2p(soc_gpio_o[15]), .p2c(soc_gpio_i[15]),  .c2p_en(soc_gpio_out_en_o[15]));
    sg13g2_IOPadInOut30mA pad_gpio16_io    (.pad(gpio16_io),    .c2p(soc_gpio_o[16]), .p2c(soc_gpio_i[16]),  .c2p_en(soc_gpio_out_en_o[16]));
    sg13g2_IOPadInOut30mA pad_gpio17_io    (.pad(gpio17_io),    .c2p(soc_gpio_o[17]), .p2c(soc_gpio_i[17]),  .c2p_en(soc_gpio_out_en_o[17]));
    sg13g2_IOPadInOut30mA pad_gpio18_io    (.pad(gpio18_io),    .c2p(soc_gpio_o[18]), .p2c(soc_gpio_i[18]),  .c2p_en(soc_gpio_out_en_o[18]));
    sg13g2_IOPadInOut30mA pad_gpio19_io    (.pad(gpio19_io),    .c2p(soc_gpio_o[19]), .p2c(soc_gpio_i[19]),  .c2p_en(soc_gpio_out_en_o[19]));
    sg13g2_IOPadInOut30mA pad_gpio20_io    (.pad(gpio20_io),    .c2p(soc_gpio_o[20]), .p2c(soc_gpio_i[20]),  .c2p_en(soc_gpio_out_en_o[20]));
    sg13g2_IOPadInOut30mA pad_gpio21_io    (.pad(gpio21_io),    .c2p(soc_gpio_o[21]), .p2c(soc_gpio_i[21]),  .c2p_en(soc_gpio_out_en_o[21]));
    sg13g2_IOPadInOut30mA pad_gpio22_io    (.pad(gpio22_io),    .c2p(soc_gpio_o[22]), .p2c(soc_gpio_i[22]),  .c2p_en(soc_gpio_out_en_o[22]));
    sg13g2_IOPadInOut30mA pad_gpio23_io    (.pad(gpio23_io),    .c2p(soc_gpio_o[23]), .p2c(soc_gpio_i[23]),  .c2p_en(soc_gpio_out_en_o[23]));
    sg13g2_IOPadInOut30mA pad_gpio24_io    (.pad(gpio24_io),    .c2p(soc_gpio_o[24]), .p2c(soc_gpio_i[24]),  .c2p_en(soc_gpio_out_en_o[24]));
    sg13g2_IOPadInOut30mA pad_gpio25_io    (.pad(gpio25_io),    .c2p(soc_gpio_o[25]), .p2c(soc_gpio_i[25]),  .c2p_en(soc_gpio_out_en_o[25]));
    sg13g2_IOPadInOut30mA pad_gpio26_io    (.pad(gpio26_io),    .c2p(soc_gpio_o[26]), .p2c(soc_gpio_i[26]),  .c2p_en(soc_gpio_out_en_o[26]));
    sg13g2_IOPadInOut30mA pad_gpio27_io    (.pad(gpio27_io),    .c2p(soc_gpio_o[27]), .p2c(soc_gpio_i[27]),  .c2p_en(soc_gpio_out_en_o[27]));
    sg13g2_IOPadInOut30mA pad_gpio28_io    (.pad(gpio28_io),    .c2p(soc_gpio_o[28]), .p2c(soc_gpio_i[28]),  .c2p_en(soc_gpio_out_en_o[28]));
    sg13g2_IOPadInOut30mA pad_gpio29_io    (.pad(gpio29_io),    .c2p(soc_gpio_o[29]), .p2c(soc_gpio_i[29]),  .c2p_en(soc_gpio_out_en_o[29]));
    sg13g2_IOPadInOut30mA pad_gpio30_io    (.pad(gpio30_io),    .c2p(soc_gpio_o[30]), .p2c(soc_gpio_i[30]),  .c2p_en(soc_gpio_out_en_o[30]));
    sg13g2_IOPadInOut30mA pad_gpio31_io    (.pad(gpio31_io),    .c2p(soc_gpio_o[31]), .p2c(soc_gpio_i[31]),  .c2p_en(soc_gpio_out_en_o[31]));
    sg13g2_IOPadOut16mA pad_unused0_o      (.pad(unused0_o),    .c2p(soc_status_o));
    sg13g2_IOPadOut16mA pad_unused1_o      (.pad(unused1_o),    .c2p(soc_status_o));
    sg13g2_IOPadOut16mA pad_unused2_o      (.pad(unused2_o),    .c2p(soc_status_o));
    sg13g2_IOPadOut16mA pad_unused3_o      (.pad(unused3_o),    .c2p(soc_status_o));

    (* dont_touch = "true" *)sg13g2_IOPadVdd pad_vdd0();
    (* dont_touch = "true" *)sg13g2_IOPadVdd pad_vdd1();
    (* dont_touch = "true" *)sg13g2_IOPadVdd pad_vdd2();
    (* dont_touch = "true" *)sg13g2_IOPadVdd pad_vdd3();

    (* dont_touch = "true" *)sg13g2_IOPadVss pad_vss0();
    (* dont_touch = "true" *)sg13g2_IOPadVss pad_vss1();
    (* dont_touch = "true" *)sg13g2_IOPadVss pad_vss2();
    (* dont_touch = "true" *)sg13g2_IOPadVss pad_vss3();

    (* dont_touch = "true" *)sg13g2_IOPadIOVdd pad_vddio0();
    (* dont_touch = "true" *)sg13g2_IOPadIOVdd pad_vddio1();
    (* dont_touch = "true" *)sg13g2_IOPadIOVdd pad_vddio2();
    (* dont_touch = "true" *)sg13g2_IOPadIOVdd pad_vddio3();

    (* dont_touch = "true" *)sg13g2_IOPadIOVss pad_vssio0();
    (* dont_touch = "true" *)sg13g2_IOPadIOVss pad_vssio1();
    (* dont_touch = "true" *)sg13g2_IOPadIOVss pad_vssio2();
    (* dont_touch = "true" *)sg13g2_IOPadIOVss pad_vssio3();
`elsif TARGET_GF180MCU
   
    gf180mcu_fd_io__in_c     pad_clk_i        (.PAD(clk_i),        .Y(soc_clk_i), .PU(1'b0), .PD(1'b1));
    gf180mcu_fd_io__in_c     pad_rst_ni       (.PAD(rst_ni),       .Y(soc_rst_ni), .PU(1'b0), .PD(1'b1));
    gf180mcu_fd_io__in_c     pad_ref_clk_i    (.PAD(ref_clk_i),    .Y(soc_ref_clk_i), .PU(1'b0), .PD(1'b1));
    // sg13g2_IOPadIn        pad_clk_i        (.pad(clk_i),        .p2c(soc_clk_i));
    // sg13g2_IOPadIn        pad_rst_ni       (.pad(rst_ni),       .p2c(soc_rst_ni));
    // sg13g2_IOPadIn        pad_ref_clk_i    (.pad(ref_clk_i),    .p2c(soc_ref_clk_i));
    assign soc_testmode_i = '0;

    gf180mcu_fd_io__in_c     pad_jtag_tck_i   (.PAD(jtag_tck_i),   .Y(soc_jtag_tck_i), .PU(1'b0), .PD(1'b1));
    gf180mcu_fd_io__in_c     pad_jtag_trst_ni (.PAD(jtag_trst_ni), .Y(soc_jtag_trst_ni), .PU(1'b0), .PD(1'b1));
    gf180mcu_fd_io__in_c     pad_jtag_tms_i   (.PAD(jtag_tms_i),   .Y(soc_jtag_tms_i), .PU(1'b0), .PD(1'b1));
    gf180mcu_fd_io__in_c     pad_jtag_tdi_i   (.PAD(jtag_tdi_i),   .Y(soc_jtag_tdi_i), .PU(1'b0), .PD(1'b1));
    gf180mcu_fd_io__bi_24t   pad_jtag_tdo_o   (.PAD(jtag_tdo_o),   .A(soc_jtag_tdo_o), .CS(1'b0),
					       .SL(1'b0), .IE(1'b0), .OE(1'b1), .PU(1'b0), .PD(1'b0), .Y());
    // sg13g2_IOPadIn        pad_jtag_tck_i   (.pad(jtag_tck_i),   .p2c(soc_jtag_tck_i));
    // sg13g2_IOPadIn        pad_jtag_trst_ni (.pad(jtag_trst_ni), .p2c(soc_jtag_trst_ni));
    // sg13g2_IOPadIn        pad_jtag_tms_i   (.pad(jtag_tms_i),   .p2c(soc_jtag_tms_i));
    // sg13g2_IOPadIn        pad_jtag_tdi_i   (.pad(jtag_tdi_i),   .p2c(soc_jtag_tdi_i));
    // sg13g2_IOPadOut16mA   pad_jtag_tdo_o   (.pad(jtag_tdo_o),   .c2p(soc_jtag_tdo_o));

    gf180mcu_fd_io__in_c     pad_uart_rx_i    (.PAD(uart_rx_i),    .Y(soc_uart_rx_i), .PU(1'b0), .PD(1'b1));
    gf180mcu_fd_io__bi_24t   pad_uart_tx_o    (.PAD(uart_tx_o),    .A(soc_uart_tx_o), .OE(1'b1),
					       .CS(1'b0), .SL(1'b0), .IE(1'b0), .PU(1'b0), .PD(1'b0), .Y());

    gf180mcu_fd_io__in_c  pad_fetch_en_i   (.PAD(fetch_en_i),   .Y(soc_fetch_en_i));
    gf180mcu_fd_io__bi_24t pad_status_o     (.PAD(status_o),     .A(soc_status_o), .OE(1'b1),
					    .CS(1'b0), .SL(1'b0), .IE(1'b0), .PU(1'b0),
					    .PD(1'b1), .Y());
 `define GPIO_PAD (instname, pad, c2p, p2c, c2p_en) \
   gf180mcu_fd_io__bi_24t p_``instname``     (.PAD(pad), .A(c2p), .Y(p2c) .OE(c2p_en), \
					    .CS(1'b0), .SL(1'b0), .IE(~c2p_en), .PU(1'b0), \
					    .PD(1'b1));

 `define OUTPUT_PAD (id, pad, c2p) \
   gf180mcu_fd_io__bi_24t pad_gpio_``id``     (.PAD(pad), .A(c2p), .Y() .OE(1'b1), \
					    .CS(1'b0), .SL(1'b0), .IE(1'b0), .PU(1'b0), \
					    .PD(1'b1));
   
   // GPIO_PAD(0, gpio0_io, soc_gpio_o[0], soc_gpio_i[0], soc_gpio_out_en_o[0]);
   // GPIO_PAD(pad_gpio1_io, gpio1_io, soc_gpio_o[1], soc_gpio_i[1], soc_gpio_out_en_o[1]);
   // GPIO_PAD(pad_gpio2_io, gpio2_io, soc_gpio_o[2], soc_gpio_i[2], soc_gpio_out_en_o[2]);
   // GPIO_PAD(pad_gpio3_io, gpio3_io, soc_gpio_o[3], soc_gpio_i[3], soc_gpio_out_en_o[3]);
   // GPIO_PAD(pad_gpio4_io, gpio4_io, soc_gpio_o[4], soc_gpio_i[4], soc_gpio_out_en_o[4]);
   // GPIO_PAD(pad_gpio5_io, gpio5_io, soc_gpio_o[5], soc_gpio_i[5], soc_gpio_out_en_o[5]);
   // GPIO_PAD(pad_gpio6_io, gpio6_io, soc_gpio_o[6], soc_gpio_i[6], soc_gpio_out_en_o[6]);
   // GPIO_PAD(pad_gpio7_io, gpio7_io, soc_gpio_o[7], soc_gpio_i[7], soc_gpio_out_en_o[7]);
   // GPIO_PAD(pad_gpio8_io, gpio8_io, soc_gpio_o[8], soc_gpio_i[8], soc_gpio_out_en_o[8]);
   // GPIO_PAD(pad_gpio9_io, gpio9_io, soc_gpio_o[9], soc_gpio_i[9], soc_gpio_out_en_o[9]);
   // GPIO_PAD(pad_gpio10_io, gpio10_io, soc_gpio_o[10], soc_gpio_i[10], soc_gpio_out_en_o[10]);
   // GPIO_PAD(pad_gpio11_io, gpio11_io, soc_gpio_o[11], soc_gpio_i[11], soc_gpio_out_en_o[11]);
   // GPIO_PAD(pad_gpio12_io, gpio12_io, soc_gpio_o[12], soc_gpio_i[12], soc_gpio_out_en_o[12]);
   // GPIO_PAD(pad_gpio13_io, gpio13_io, soc_gpio_o[13], soc_gpio_i[13], soc_gpio_out_en_o[13]);
   // GPIO_PAD(pad_gpio14_io, gpio14_io, soc_gpio_o[14], soc_gpio_i[14], soc_gpio_out_en_o[14]);
   // GPIO_PAD(pad_gpio15_io, gpio15_io, soc_gpio_o[15], soc_gpio_i[15], soc_gpio_out_en_o[15]);
   // GPIO_PAD(pad_gpio16_io, gpio16_io, soc_gpio_o[16], soc_gpio_i[16], soc_gpio_out_en_o[16]);
   // GPIO_PAD(pad_gpio17_io, gpio17_io, soc_gpio_o[17], soc_gpio_i[17], soc_gpio_out_en_o[17]);
   // GPIO_PAD(pad_gpio18_io, gpio18_io, soc_gpio_o[18], soc_gpio_i[18], soc_gpio_out_en_o[18]);
   // GPIO_PAD(pad_gpio19_io, gpio19_io, soc_gpio_o[19], soc_gpio_i[19], soc_gpio_out_en_o[19]);
   // GPIO_PAD(pad_gpio20_io, gpio20_io, soc_gpio_o[20], soc_gpio_i[20], soc_gpio_out_en_o[20]);
   // GPIO_PAD(pad_gpio21_io, gpio21_io, soc_gpio_o[21], soc_gpio_i[21], soc_gpio_out_en_o[21]);
   // GPIO_PAD(pad_gpio22_io, gpio22_io, soc_gpio_o[22], soc_gpio_i[22], soc_gpio_out_en_o[22]);
   // GPIO_PAD(pad_gpio23_io, gpio23_io, soc_gpio_o[23], soc_gpio_i[23], soc_gpio_out_en_o[23]);
   // GPIO_PAD(pad_gpio24_io, gpio24_io, soc_gpio_o[24], soc_gpio_i[24], soc_gpio_out_en_o[24]);
   // GPIO_PAD(pad_gpio25_io, gpio25_io, soc_gpio_o[25], soc_gpio_i[25], soc_gpio_out_en_o[25]);
   // GPIO_PAD(pad_gpio26_io, gpio26_io, soc_gpio_o[26], soc_gpio_i[26], soc_gpio_out_en_o[26]);
   // GPIO_PAD(pad_gpio27_io, gpio27_io, soc_gpio_o[27], soc_gpio_i[27], soc_gpio_out_en_o[27]);
   // GPIO_PAD(pad_gpio28_io, gpio28_io, soc_gpio_o[28], soc_gpio_i[28], soc_gpio_out_en_o[28]);
   // GPIO_PAD(pad_gpio29_io, gpio29_io, soc_gpio_o[29], soc_gpio_i[29], soc_gpio_out_en_o[29]);
   // GPIO_PAD(pad_gpio30_io, gpio30_io, soc_gpio_o[30], soc_gpio_i[30], soc_gpio_out_en_o[30]);
   // GPIO_PAD(pad_gpio31_io, gpio31_io, soc_gpio_o[31], soc_gpio_i[31], soc_gpio_out_en_o[31]);


   gf180mcu_fd_io__bi_24t pad_gpio0_io (.PAD(gpio0_io), .A(soc_gpio_o[0]), .Y(soc_gpio_i[0]), .OE(soc_gpio_out_en_o[0]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[0]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio1_io (.PAD(gpio1_io), .A(soc_gpio_o[1]), .Y(soc_gpio_i[1]), .OE(soc_gpio_out_en_o[1]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[1]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio2_io (.PAD(gpio2_io), .A(soc_gpio_o[2]), .Y(soc_gpio_i[2]), .OE(soc_gpio_out_en_o[2]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[2]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio3_io (.PAD(gpio3_io), .A(soc_gpio_o[3]), .Y(soc_gpio_i[3]), .OE(soc_gpio_out_en_o[3]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[3]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio4_io (.PAD(gpio4_io), .A(soc_gpio_o[4]), .Y(soc_gpio_i[4]), .OE(soc_gpio_out_en_o[4]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[4]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio5_io (.PAD(gpio5_io), .A(soc_gpio_o[5]), .Y(soc_gpio_i[5]), .OE(soc_gpio_out_en_o[5]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[5]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio6_io (.PAD(gpio6_io), .A(soc_gpio_o[6]), .Y(soc_gpio_i[6]), .OE(soc_gpio_out_en_o[6]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[6]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio7_io (.PAD(gpio7_io), .A(soc_gpio_o[7]), .Y(soc_gpio_i[7]), .OE(soc_gpio_out_en_o[7]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[7]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio8_io (.PAD(gpio8_io), .A(soc_gpio_o[8]), .Y(soc_gpio_i[8]), .OE(soc_gpio_out_en_o[8]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[8]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio9_io (.PAD(gpio9_io), .A(soc_gpio_o[9]), .Y(soc_gpio_i[9]), .OE(soc_gpio_out_en_o[9]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[9]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio10_io (.PAD(gpio10_io), .A(soc_gpio_o[10]), .Y(soc_gpio_i[10]), .OE(soc_gpio_out_en_o[10]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[10]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio11_io (.PAD(gpio11_io), .A(soc_gpio_o[11]), .Y(soc_gpio_i[11]), .OE(soc_gpio_out_en_o[11]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[11]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio12_io (.PAD(gpio12_io), .A(soc_gpio_o[12]), .Y(soc_gpio_i[12]), .OE(soc_gpio_out_en_o[12]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[12]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio13_io (.PAD(gpio13_io), .A(soc_gpio_o[13]), .Y(soc_gpio_i[13]), .OE(soc_gpio_out_en_o[13]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[13]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio14_io (.PAD(gpio14_io), .A(soc_gpio_o[14]), .Y(soc_gpio_i[14]), .OE(soc_gpio_out_en_o[14]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[14]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio15_io (.PAD(gpio15_io), .A(soc_gpio_o[15]), .Y(soc_gpio_i[15]), .OE(soc_gpio_out_en_o[15]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[15]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio16_io (.PAD(gpio16_io), .A(soc_gpio_o[16]), .Y(soc_gpio_i[16]), .OE(soc_gpio_out_en_o[16]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[16]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio17_io (.PAD(gpio17_io), .A(soc_gpio_o[17]), .Y(soc_gpio_i[17]), .OE(soc_gpio_out_en_o[17]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[17]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio18_io (.PAD(gpio18_io), .A(soc_gpio_o[18]), .Y(soc_gpio_i[18]), .OE(soc_gpio_out_en_o[18]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[18]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio19_io (.PAD(gpio19_io), .A(soc_gpio_o[19]), .Y(soc_gpio_i[19]), .OE(soc_gpio_out_en_o[19]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[19]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio20_io (.PAD(gpio20_io), .A(soc_gpio_o[20]), .Y(soc_gpio_i[20]), .OE(soc_gpio_out_en_o[20]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[20]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio21_io (.PAD(gpio21_io), .A(soc_gpio_o[21]), .Y(soc_gpio_i[21]), .OE(soc_gpio_out_en_o[21]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[21]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio22_io (.PAD(gpio22_io), .A(soc_gpio_o[22]), .Y(soc_gpio_i[22]), .OE(soc_gpio_out_en_o[22]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[22]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio23_io (.PAD(gpio23_io), .A(soc_gpio_o[23]), .Y(soc_gpio_i[23]), .OE(soc_gpio_out_en_o[23]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[23]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio24_io (.PAD(gpio24_io), .A(soc_gpio_o[24]), .Y(soc_gpio_i[24]), .OE(soc_gpio_out_en_o[24]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[24]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio25_io (.PAD(gpio25_io), .A(soc_gpio_o[25]), .Y(soc_gpio_i[25]), .OE(soc_gpio_out_en_o[25]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[25]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio26_io (.PAD(gpio26_io), .A(soc_gpio_o[26]), .Y(soc_gpio_i[26]), .OE(soc_gpio_out_en_o[26]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[26]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio27_io (.PAD(gpio27_io), .A(soc_gpio_o[27]), .Y(soc_gpio_i[27]), .OE(soc_gpio_out_en_o[27]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[27]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio28_io (.PAD(gpio28_io), .A(soc_gpio_o[28]), .Y(soc_gpio_i[28]), .OE(soc_gpio_out_en_o[28]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[28]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio29_io (.PAD(gpio29_io), .A(soc_gpio_o[29]), .Y(soc_gpio_i[29]), .OE(soc_gpio_out_en_o[29]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[29]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio30_io (.PAD(gpio30_io), .A(soc_gpio_o[30]), .Y(soc_gpio_i[30]), .OE(soc_gpio_out_en_o[30]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[30]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_gpio31_io (.PAD(gpio31_io), .A(soc_gpio_o[31]), .Y(soc_gpio_i[31]), .OE(soc_gpio_out_en_o[31]), 
					    .CS(1'b0), .SL(1'b0), .IE(~soc_gpio_out_en_o[31]), .PU(1'b0), 
					    .PD(1'b1));
    

   gf180mcu_fd_io__bi_24t pad_unused0_0 (.PAD(unused0_0), .A(soc_status_o),
					 .Y(), .OE(1'b1),
					 .CS(1'b0), .SL(1'b0), .IE(1'b0), .PU(1'b0),
					 .PD(1'b1));
   gf180mcu_fd_io__bi_24t pad_unused1_0 (.PAD(unused0_0), .A(soc_status_o),
					 .Y(), .OE(1'b1),
					 .CS(1'b0), .SL(1'b0), .IE(1'b0), .PU(1'b0),
					 .PD(1'b1));
   gf180mcu_fd_io__bi_24t pad_unused2_0 (.PAD(unused0_0), .A(soc_status_o),
					 .Y(), .OE(1'b1),
					 .CS(1'b0), .SL(1'b0), .IE(1'b0), .PU(1'b0),
					 .PD(1'b1));
   gf180mcu_fd_io__bi_24t pad_unused3_0 (.PAD(unused0_0), .A(soc_status_o),
					 .Y(), .OE(1'b1),
					 .CS(1'b0), .SL(1'b0), .IE(1'b0), .PU(1'b0),
					 .PD(1'b1));
    

    // sg13g2_IOPadInOut30mA pad_gpio0_io     (.pad(gpio0_io),     .c2p(soc_gpio_o[0]),  .p2c(soc_gpio_i[0]),   .c2p_en(soc_gpio_out_en_o[0]));
    // sg13g2_IOPadInOut30mA pad_gpio1_io     (.pad(gpio1_io),     .c2p(soc_gpio_o[1]),  .p2c(soc_gpio_i[1]),   .c2p_en(soc_gpio_out_en_o[1]));
    // sg13g2_IOPadInOut30mA pad_gpio2_io     (.pad(gpio2_io),     .c2p(soc_gpio_o[2]),  .p2c(soc_gpio_i[2]),   .c2p_en(soc_gpio_out_en_o[2]));
    // sg13g2_IOPadInOut30mA pad_gpio3_io     (.pad(gpio3_io),     .c2p(soc_gpio_o[3]),  .p2c(soc_gpio_i[3]),   .c2p_en(soc_gpio_out_en_o[3]));
    // sg13g2_IOPadInOut30mA pad_gpio4_io     (.pad(gpio4_io),     .c2p(soc_gpio_o[4]),  .p2c(soc_gpio_i[4]),   .c2p_en(soc_gpio_out_en_o[4]));
    // sg13g2_IOPadInOut30mA pad_gpio5_io     (.pad(gpio5_io),     .c2p(soc_gpio_o[5]),  .p2c(soc_gpio_i[5]),   .c2p_en(soc_gpio_out_en_o[5]));
    // sg13g2_IOPadInOut30mA pad_gpio6_io     (.pad(gpio6_io),     .c2p(soc_gpio_o[6]),  .p2c(soc_gpio_i[6]),   .c2p_en(soc_gpio_out_en_o[6]));
    // sg13g2_IOPadInOut30mA pad_gpio7_io     (.pad(gpio7_io),     .c2p(soc_gpio_o[7]),  .p2c(soc_gpio_i[7]),   .c2p_en(soc_gpio_out_en_o[7]));
    // sg13g2_IOPadInOut30mA pad_gpio8_io     (.pad(gpio8_io),     .c2p(soc_gpio_o[8]),  .p2c(soc_gpio_i[8]),   .c2p_en(soc_gpio_out_en_o[8]));
    // sg13g2_IOPadInOut30mA pad_gpio9_io     (.pad(gpio9_io),     .c2p(soc_gpio_o[9]),  .p2c(soc_gpio_i[9]),   .c2p_en(soc_gpio_out_en_o[9]));
    // sg13g2_IOPadInOut30mA pad_gpio10_io    (.pad(gpio10_io),    .c2p(soc_gpio_o[10]), .p2c(soc_gpio_i[10]),  .c2p_en(soc_gpio_out_en_o[10]));
    // sg13g2_IOPadInOut30mA pad_gpio11_io    (.pad(gpio11_io),    .c2p(soc_gpio_o[11]), .p2c(soc_gpio_i[11]),  .c2p_en(soc_gpio_out_en_o[11]));
    // sg13g2_IOPadInOut30mA pad_gpio12_io    (.pad(gpio12_io),    .c2p(soc_gpio_o[12]), .p2c(soc_gpio_i[12]),  .c2p_en(soc_gpio_out_en_o[12]));
    // sg13g2_IOPadInOut30mA pad_gpio13_io    (.pad(gpio13_io),    .c2p(soc_gpio_o[13]), .p2c(soc_gpio_i[13]),  .c2p_en(soc_gpio_out_en_o[13]));
    // sg13g2_IOPadInOut30mA pad_gpio14_io    (.pad(gpio14_io),    .c2p(soc_gpio_o[14]), .p2c(soc_gpio_i[14]),  .c2p_en(soc_gpio_out_en_o[14]));
    // sg13g2_IOPadInOut30mA pad_gpio15_io    (.pad(gpio15_io),    .c2p(soc_gpio_o[15]), .p2c(soc_gpio_i[15]),  .c2p_en(soc_gpio_out_en_o[15]));
    // sg13g2_IOPadInOut30mA pad_gpio16_io    (.pad(gpio16_io),    .c2p(soc_gpio_o[16]), .p2c(soc_gpio_i[16]),  .c2p_en(soc_gpio_out_en_o[16]));
    // sg13g2_IOPadInOut30mA pad_gpio17_io    (.pad(gpio17_io),    .c2p(soc_gpio_o[17]), .p2c(soc_gpio_i[17]),  .c2p_en(soc_gpio_out_en_o[17]));
    // sg13g2_IOPadInOut30mA pad_gpio18_io    (.pad(gpio18_io),    .c2p(soc_gpio_o[18]), .p2c(soc_gpio_i[18]),  .c2p_en(soc_gpio_out_en_o[18]));
    // sg13g2_IOPadInOut30mA pad_gpio19_io    (.pad(gpio19_io),    .c2p(soc_gpio_o[19]), .p2c(soc_gpio_i[19]),  .c2p_en(soc_gpio_out_en_o[19]));
    // sg13g2_IOPadInOut30mA pad_gpio20_io    (.pad(gpio20_io),    .c2p(soc_gpio_o[20]), .p2c(soc_gpio_i[20]),  .c2p_en(soc_gpio_out_en_o[20]));
    // sg13g2_IOPadInOut30mA pad_gpio21_io    (.pad(gpio21_io),    .c2p(soc_gpio_o[21]), .p2c(soc_gpio_i[21]),  .c2p_en(soc_gpio_out_en_o[21]));
    // sg13g2_IOPadInOut30mA pad_gpio22_io    (.pad(gpio22_io),    .c2p(soc_gpio_o[22]), .p2c(soc_gpio_i[22]),  .c2p_en(soc_gpio_out_en_o[22]));
    // sg13g2_IOPadInOut30mA pad_gpio23_io    (.pad(gpio23_io),    .c2p(soc_gpio_o[23]), .p2c(soc_gpio_i[23]),  .c2p_en(soc_gpio_out_en_o[23]));
    // sg13g2_IOPadInOut30mA pad_gpio24_io    (.pad(gpio24_io),    .c2p(soc_gpio_o[24]), .p2c(soc_gpio_i[24]),  .c2p_en(soc_gpio_out_en_o[24]));
    // sg13g2_IOPadInOut30mA pad_gpio25_io    (.pad(gpio25_io),    .c2p(soc_gpio_o[25]), .p2c(soc_gpio_i[25]),  .c2p_en(soc_gpio_out_en_o[25]));
    // sg13g2_IOPadInOut30mA pad_gpio26_io    (.pad(gpio26_io),    .c2p(soc_gpio_o[26]), .p2c(soc_gpio_i[26]),  .c2p_en(soc_gpio_out_en_o[26]));
    // sg13g2_IOPadInOut30mA pad_gpio27_io    (.pad(gpio27_io),    .c2p(soc_gpio_o[27]), .p2c(soc_gpio_i[27]),  .c2p_en(soc_gpio_out_en_o[27]));
    // sg13g2_IOPadInOut30mA pad_gpio28_io    (.pad(gpio28_io),    .c2p(soc_gpio_o[28]), .p2c(soc_gpio_i[28]),  .c2p_en(soc_gpio_out_en_o[28]));
    // sg13g2_IOPadInOut30mA pad_gpio29_io    (.pad(gpio29_io),    .c2p(soc_gpio_o[29]), .p2c(soc_gpio_i[29]),  .c2p_en(soc_gpio_out_en_o[29]));
    // sg13g2_IOPadInOut30mA pad_gpio30_io    (.pad(gpio30_io),    .c2p(soc_gpio_o[30]), .p2c(soc_gpio_i[30]),  .c2p_en(soc_gpio_out_en_o[30]));
    // sg13g2_IOPadInOut30mA pad_gpio31_io    (.pad(gpio31_io),    .c2p(soc_gpio_o[31]), .p2c(soc_gpio_i[31]),  .c2p_en(soc_gpio_out_en_o[31]));
    // sg13g2_IOPadOut16mA pad_unused0_o      (.pad(unused0_o),    .c2p(soc_status_o));
    // sg13g2_IOPadOut16mA pad_unused1_o      (.pad(unused1_o),    .c2p(soc_status_o));
    // sg13g2_IOPadOut16mA pad_unused2_o      (.pad(unused2_o),    .c2p(soc_status_o));
    // sg13g2_IOPadOut16mA pad_unused3_o      (.pad(unused3_o),    .c2p(soc_status_o));

    // (* dont_touch = "true" *)sg13g2_IOPadVdd pad_vdd0();
    // (* dont_touch = "true" *)sg13g2_IOPadVdd pad_vdd1();
    // (* dont_touch = "true" *)sg13g2_IOPadVdd pad_vdd2();
    // (* dont_touch = "true" *)sg13g2_IOPadVdd pad_vdd3();

    // (* dont_touch = "true" *)sg13g2_IOPadVss pad_vss0();
    // (* dont_touch = "true" *)sg13g2_IOPadVss pad_vss1();
    // (* dont_touch = "true" *)sg13g2_IOPadVss pad_vss2();
    // (* dont_touch = "true" *)sg13g2_IOPadVss pad_vss3();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vdd0();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vdd1();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vdd2();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vdd3();

    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vss0();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vss1();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vss2();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vss3();

    // (* dont_touch = "true" *)sg13g2_IOPadIOVdd pad_vddio0();
    // (* dont_touch = "true" *)sg13g2_IOPadIOVdd pad_vddio1();
    // (* dont_touch = "true" *)sg13g2_IOPadIOVdd pad_vddio2();
    // (* dont_touch = "true" *)sg13g2_IOPadIOVdd pad_vddio3();

    // (* dont_touch = "true" *)sg13g2_IOPadIOVss pad_vssio0();
    // (* dont_touch = "true" *)sg13g2_IOPadIOVss pad_vssio1();
    // (* dont_touch = "true" *)sg13g2_IOPadIOVss pad_vssio2();
    // (* dont_touch = "true" *)sg13g2_IOPadIOVss pad_vssio3();

    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vddio0();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vddio1();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vddio2();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vddio3();

    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vssio0();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vssio1();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vssio2();
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vssio3();
`endif

  croc_soc #(
    .GpioCount( GpioCount )
  )
  i_croc_soc (
    .clk_i          ( soc_clk_i      ),
    .rst_ni         ( soc_rst_ni     ),
    .ref_clk_i      ( soc_ref_clk_i  ),
    .testmode_i     ( soc_testmode_i ),
    .fetch_en_i     ( soc_fetch_en_i ),
    .status_o       ( soc_status_o   ),

    .jtag_tck_i     ( soc_jtag_tck_i   ),
    .jtag_tdi_i     ( soc_jtag_tdi_i   ),
    .jtag_tdo_o     ( soc_jtag_tdo_o   ),
    .jtag_tms_i     ( soc_jtag_tms_i   ),
    .jtag_trst_ni   ( soc_jtag_trst_ni ),

    .uart_rx_i      ( soc_uart_rx_i ),
    .uart_tx_o      ( soc_uart_tx_o ),

    .gpio_i         ( soc_gpio_i        ),             
    .gpio_o         ( soc_gpio_o        ),            
    .gpio_out_en_o  ( soc_gpio_out_en_o )
  );

endmodule
