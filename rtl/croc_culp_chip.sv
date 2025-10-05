// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Philippe Sauter <phsauter@iis.ee.ethz.ch>

module croc_culp_chip (
  // inout wire VDD,
  // inout wire VSS,
  input wire  clk_i,
  input wire  rst_ni,
  input wire  ref_clk_i,

  input wire  jtag_tck_i,
  input wire  jtag_trst_ni,
  input wire  jtag_tms_i,
  input wire  jtag_tdi_i,
  output wire jtag_tdo_o,

  input wire  uart_rx_i,
  output wire uart_tx_o,

  input wire  fetch_en_i,
  output wire status_o,

  inout wire  gpio0_io,
  inout wire  gpio1_io,
  inout wire  gpio2_io,
  inout wire  gpio3_io,
  inout wire  gpio4_io,
  inout wire  gpio5_io,
  inout wire  gpio6_io,
  inout wire  gpio7_io,
  inout wire  gpio8_io,
  inout wire  gpio9_io,
  inout wire  gpio10_io,
  inout wire  gpio11_io,
  inout wire  gpio12_io,
  inout wire  gpio13_io,
  inout wire  gpio14_io,
  inout wire  gpio15_io,
  output wire pll_clk_o,
  input wire  osc_clk_i
//  inout wire  dac_outp_o,
//  inout wire  dac_outn_o,
//  inout wire  dac_vbias_i
  // inout wire  adc_inp_i,
  // inout wire  adc_inn_i       
); 
   logic soc_clk_i;
   logic soc_rst_ni;
   logic soc_ref_clk_i;

   logic soc_jtag_tck_i;
   logic soc_jtag_trst_ni;
   logic soc_jtag_tms_i;
   logic soc_jtag_tdi_i;
   logic soc_jtag_tdo_o;

   logic soc_fetch_en_i;
   logic soc_status_o;

   logic  soc_osc_clk_i;
   logic  dpll_en;
   logic  dpll_rstn;
   logic  dpll_dco;
   logic [4:0] dpll_div;
   logic [26:0] dpll_extrim;


   localparam int unsigned GpioCount = 16;

   logic [GpioCount-1:0] soc_gpio_i;             
   logic [GpioCount-1:0] soc_gpio_o;            
   logic [GpioCount-1:0] soc_gpio_ie_o;            
   logic [GpioCount-1:0] soc_gpio_en_o; // Output enable signal; 0 -> input, 1 -> output
   
   wire 		  dac_outp_o;
   wire 		  dac_outn_o;
   wire 		  dac_vbias_i;
   wire 		  adc_inp_i;
   wire 		  adc_inn_i;

`ifdef ENABLE_CS_DAC

    wire [10:1] 		  dac_in;
    (* dont_touch = "true" *)
    CS_DAC_10b i_dac(.X1(dac_in[1]),
 		    .X2(dac_in[2]),
 		    .X3(dac_in[3]),
 		    .X4(dac_in[4]),
 		    .X5(dac_in[5]),
 		    .X6(dac_in[6]),
 		    .X7(dac_in[7]),
 		    .X8(dac_in[8]),
 		    .X9(dac_in[9]),
 		    .X10(dac_in[10]),
 		    .CLK(dac_clk),
 		    .VBIAS(dac_vbias_i),
 		    .OUTP(dac_outp_o),
 		    .OUTN(dac_outn_o));
`endif

   digital_pll
     i_pll(.resetb(dpll_rstn)
	   ,.enable(dpll_en)
	   ,.osc(soc_osc_clk_i)
	   ,.clockp(pll_clk_o)
	   ,.div(dpll_div)
	   ,.dco(dpll_dco)
	   ,.ext_trim(dpll_extrim));
   
   croc_culp
     i_croc_soc (
    .clk_i		( soc_clk_i		),
    .rst_ni		( soc_rst_ni		),
    .ref_clk_i		( soc_ref_clk_i		),
    .fetch_en_i		( soc_fetch_en_i	),
    .status_o		( soc_status_o		),
`ifdef ENABLE_CS_DAC
    .dac_clk_o		( dac_clk		),
    .dac_val_o		( dac_in		),
`endif
    .dpll_en_o		( dpll_en		),
    .dpll_dco_o		( dpll_dco		),
    .dpll_rstn_o	( dpll_rstn		),
    .dpll_div_o 	( dpll_div		),
    .dpll_extrim_o	( dpll_extrim		),

    .jtag_tck_i		( soc_jtag_tck_i	),
    .jtag_tdi_i		( soc_jtag_tdi_i	),
    .jtag_tdo_o		( soc_jtag_tdo_o	),
    .jtag_tms_i		( soc_jtag_tms_i	),
    .jtag_trst_ni	( soc_jtag_trst_ni	),

    .uart_rx_i		( soc_uart_rx_i		),
    .uart_tx_o		( soc_uart_tx_o		),

    .gpio_i		( soc_gpio_i		),
    .gpio_o		( soc_gpio_o		),
    .gpio_en_o		( soc_gpio_en_o	)
  );

   logic      jtag_tdo_dummy;
   logic      uart_tx_dummy;
   logic      status_dummy;
   logic      pll_clk_dummy;
   logic      soc_tie_l;
   logic      soc_tie_h;
   

   assign soc_tie_l = 1'b0;
   assign soc_tie_h = 1'b1;
   assign soc_gpio_ie_o = ~soc_gpio_en_o;
   
    gf180mcu_fd_io__in_c     pad_clk_i        (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(clk_i),
					       .Y(soc_clk_i),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
    gf180mcu_fd_io__in_c     pad_rst_ni       (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(rst_ni),
					       .Y(soc_rst_ni),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
    gf180mcu_fd_io__in_c     pad_ref_clk_i    (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(ref_clk_i),
					       .Y(soc_ref_clk_i),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
  
    gf180mcu_fd_io__in_c     pad_jtag_tck_i   (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(jtag_tck_i),
					       .Y(soc_jtag_tck_i),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
    gf180mcu_fd_io__in_c     pad_jtag_trst_ni (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(jtag_trst_ni),
					       .Y(soc_jtag_trst_ni),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
    gf180mcu_fd_io__in_c     pad_jtag_tms_i   (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(jtag_tms_i),
					       .Y(soc_jtag_tms_i),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
    gf180mcu_fd_io__in_c     pad_jtag_tdi_i   (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(jtag_tdi_i),
					       .Y(soc_jtag_tdi_i),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));

    gf180mcu_fd_io__bi_t     pad_jtag_tdo_o   (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(jtag_tdo_o),
					       .A(soc_jtag_tdo_o),
					       .CS(soc_tie_l),
					       .SL(soc_tie_l),
					       .IE(soc_tie_l),
					       .OE(soc_tie_h),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h),
					       .Y(tdo_dummy));

    gf180mcu_fd_io__in_c     pad_uart_rx_i    (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(uart_rx_i),
					       .Y(soc_uart_rx_i),
					       .PU(soc_tie_h),
					       .PD(soc_tie_l));
    gf180mcu_fd_io__bi_t     pad_uart_tx_o    (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(uart_tx_o),
					       .A(soc_uart_tx_o),
					       .OE(soc_tie_h),
					       .CS(soc_tie_l),
					       .SL(soc_tie_l),
					       .IE(soc_tie_l),
					       .PU(soc_tie_h),
					       .PD(soc_tie_l),
					       .Y(uart_tx_dummy));

    gf180mcu_fd_io__in_c     pad_fetch_en_i   (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(fetch_en_i),
					       .Y(soc_fetch_en_i));
    gf180mcu_fd_io__bi_t     pad_status_o     (
					       .DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(status_o),
					       .A(soc_status_o),
					       .OE(soc_tie_h),
					       .CS(soc_tie_l),
					       .SL(soc_tie_l),
					       .IE(soc_tie_l),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h),
					       .Y(status_dummy));
 // `define GPIO_PAD (instname, pad, c2p, p2c, c2en) \
 //   gf180mcu_fd_io__bi_t ``instname``     (.PAD(pad), .A(c2p), .Y(p2c) .OE(c2en), \
 // 					    .CS(soc_tie_l), .SL(soc_tie_l), .IE(~c2en), .PU(soc_tie_l), \
 // 					    .PD(soc_tie_h));

 // `define OUTPUT_PAD (id, pad, c2p) \
 //   gf180mcu_fd_io__bi_t pad_gpio_``id``     (.PAD(pad), .A(c2p), .Y() .OE(soc_tie_h), \
 // 					    .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_tie_l), .PU(soc_tie_l), \
 // 					    .PD(soc_tie_h));
  
   gf180mcu_fd_io__bi_t pad_gpio0_io (
				      .DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio0_io),
				      .A(soc_gpio_o[0]),
				      .Y(soc_gpio_i[0]),
				      .OE(soc_gpio_en_o[0]), 
				      .CS(soc_tie_l),
				      .SL(soc_tie_l),
				      .IE(~soc_gpio_ie_o[0]),
				      .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio1_io (
				      .DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio1_io), .A(soc_gpio_o[1]), .Y(soc_gpio_i[1]), .OE(soc_gpio_en_o[1]), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[1]), .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio2_io (
				      .DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio2_io), .A(soc_gpio_o[2]), .Y(soc_gpio_i[2]), .OE(soc_gpio_en_o[2]), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[2]), .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio3_io (
				      .DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio3_io), .A(soc_gpio_o[3]), .Y(soc_gpio_i[3]), .OE(soc_gpio_en_o[3]), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[3]), .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio4_io (
				      .DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio4_io), .A(soc_gpio_o[4]), .Y(soc_gpio_i[4]), .OE(soc_gpio_en_o[4]), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[4]), .PU(soc_tie_l),
				      .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio5_io (
				      .DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio5_io), .A(soc_gpio_o[5]), .Y(soc_gpio_i[5]), .OE(soc_gpio_en_o[5]), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[5]), .PU(soc_tie_l),
				      .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio6_io (
				      .DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio6_io), .A(soc_gpio_o[6]), .Y(soc_gpio_i[6]), .OE(soc_gpio_en_o[6]), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[6]), .PU(soc_tie_l),
				      .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio7_io (
				      .DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio7_io), .A(soc_gpio_o[7]), .Y(soc_gpio_i[7]), .OE(soc_gpio_en_o[7]), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[7]), .PU(soc_tie_l),
				      .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio8_io (
				      .DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio8_io), .A(soc_gpio_o[8]), .Y(soc_gpio_i[8]), .OE(soc_gpio_en_o[8]), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[8]), .PU(soc_tie_l),
				      .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio9_io (
				      .DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio9_io), .A(soc_gpio_o[9]), .Y(soc_gpio_i[9]), .OE(soc_gpio_en_o[9]), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[9]), .PU(soc_tie_l),
				      .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio10_io (
				       .DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(gpio10_io), .A(soc_gpio_o[10]), .Y(soc_gpio_i[10]), .OE(soc_gpio_en_o[10]), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[10]), .PU(soc_tie_l),
				       .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio11_io (
				       .DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(gpio11_io), .A(soc_gpio_o[11]), .Y(soc_gpio_i[11]), .OE(soc_gpio_en_o[11]), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[11]), .PU(soc_tie_l),
				       .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio12_io (
				       .DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(gpio12_io), .A(soc_gpio_o[12]), .Y(soc_gpio_i[12]), .OE(soc_gpio_en_o[12]), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[12]), .PU(soc_tie_l),
				       .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio13_io (
				       .DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(gpio13_io), .A(soc_gpio_o[13]), .Y(soc_gpio_i[13]), .OE(soc_gpio_en_o[13]), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[13]), .PU(soc_tie_l),
				       .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio14_io (
				       .DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(gpio14_io), .A(soc_gpio_o[14]), .Y(soc_gpio_i[14]), .OE(soc_gpio_en_o[14]), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[14]), .PU(soc_tie_l),
				       .PD(soc_tie_h));
   gf180mcu_fd_io__bi_t pad_gpio15_io (
				       .DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(gpio15_io), .A(soc_gpio_o[15]), .Y(soc_gpio_i[15]), .OE(soc_gpio_en_o[15]), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio_ie_o[15]), .PU(soc_tie_l),
				       .PD(soc_tie_h));
    
   (* dont_touch = "true" *)
    gf180mcu_fd_io__bi_t pad_pll_clk_o     (.DVDD(VDD),
					    .DVSS(VSS),
					    .VSS(VSS),
					    .VDD(VDD),
					    .PAD(pll_clk_o),     .A(soc_pll_clk_o), .OE(soc_tie_h),
					    .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_tie_l), .PU(soc_tie_l),
					    .PD(soc_tie_h), .Y(pll_clk_dummy));
   
   (* dont_touch = "true" *)
   gf180mcu_fd_io__in_c     pad_osc_clk_i        (
						  .DVDD(VDD),
						  .DVSS(VSS),
						  .VSS(VSS),
						  .VDD(VDD),
						  .PAD(osc_clk_i),        .Y(soc_osc_clk_i),        .PU(soc_tie_l), .PD(soc_tie_h));
`ifdef ENABLE_CS_DAC
   (* dont_touch = "true" *) gf180mcu_fd_io__asig_5p0 pad_dac_outp_o (.DVDD(VDD),
								      .DVSS(VSS),
								      .VSS(VSS),
								      .VDD(VDD),
								      .ASIG5V(dac_outp_o));
   (* dont_touch = "true" *) gf180mcu_fd_io__asig_5p0 pad_dac_outn_o (.DVDD(VDD),
								      .DVSS(VSS),
								      .VSS(VSS),
								      .VDD(VDD),
								      .ASIG5V(dac_outn_o));
   (* dont_touch = "true" *) gf180mcu_fd_io__asig_5p0 pad_dac_vbias_i (.DVDD(VDD),
								       .DVSS(VSS),
								       .VSS(VSS),
								       .VDD(VDD),
								       .ASIG5V(dac_vbias_i));
//   (* dont_touch = "true" *) gf180mcu_fd_io__asig_5p0 pad_adc_inp_i (.DVDD(VDD),
//								     .DVSS(VSS),
//								     .VSS(VSS),
//								     .VDD(VDD),
//								     .ASIG5V(adc_inp_i));
//   (* dont_touch = "true" *) gf180mcu_fd_io__asig_5p0 pad_adc_inn_i (.DVDD(VDD),
//								     .DVSS(VSS),
//								     .VSS(VSS),
//								     .VDD(VDD),
//								     .ASIG5V(adc_inn_i));
`endif

    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vdd0(.DVDD(VDD),
							   .DVSS(VSS),
							   .VSS(VSS));
    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vdd1(.DVDD(VDD),
							   .DVSS(VSS),
							   .VSS(VSS));
    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vdd2(.DVDD(VDD),
							   .DVSS(VSS),
							   .VSS(VSS));
    (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vdd3(.DVDD(VDD),
							   .DVSS(VSS),
							   .VSS(VSS));

    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vss0(.DVDD(VDD),
							   .DVSS(VSS),
							   .VDD(VDD));
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vss1(.DVDD(VDD),
							   .DVSS(VSS),
							   .VDD(VDD));
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vss2(.DVDD(VDD),
							   .DVSS(VSS),
							   .VDD(VDD));
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vss3(.DVDD(VDD),
							   .DVSS(VSS),
							   .VDD(VDD));

   (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vddio0(.DVDD(VDD),
							    .DVSS(VSS),
							    .VSS(VSS));
   (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vddio1(.DVDD(VDD),
							    .DVSS(VSS),
							    .VSS(VSS));
   (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vddio2(.DVDD(VDD),
							    .DVSS(VSS),
							    .VSS(VSS));
   (* dont_touch = "true" *)gf180mcu_fd_io__dvdd pad_vddio3(.DVDD(VDD),
							    .DVSS(VSS),
							    .VSS(VSS));

    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vssio0(.DVDD(VDD),
							     .DVSS(VSS),
							     .VDD(VDD));
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vssio1(.DVDD(VDD),
							     .DVSS(VSS),
							     .VDD(VDD));
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vssio2(.DVDD(VDD),
							     .DVSS(VSS),
							     .VDD(VDD));
    (* dont_touch = "true" *)gf180mcu_fd_io__dvss pad_vssio3(.DVDD(VDD),
							     .DVSS(VSS),
							     .VDD(VDD));

endmodule
