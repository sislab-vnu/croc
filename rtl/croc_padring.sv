
module croc_padring (
  output wire soc_clk_i,
  output wire soc_rst_ni,
  output wire soc_ref_clk_i,

  output wire soc_jtag_tck_i,
  output wire soc_jtag_trst_ni,
  output wire soc_jtag_tms_i,
  output wire soc_jtag_tdi_i,
  input wire  soc_jtag_tdo_o,

  output wire soc_uart_rx_i,
  input wire  soc_uart_tx_o,

  output wire soc_fetch_en_i,
  output wire soc_osc_clk_i,
  input wire  soc_status_o,
  input wire  soc_pll_clk_o,
  // input wire  soc_tie_h,
  // input wire  soc_tie_l,

  output wire soc_gpio0_i,
  output wire soc_gpio1_i,
  output wire soc_gpio2_i,
  output wire soc_gpio3_i,
  output wire soc_gpio4_i,
  output wire soc_gpio5_i,
  output wire soc_gpio6_i,
  output wire soc_gpio7_i,
  output wire soc_gpio8_i,
  output wire soc_gpio9_i,
  output wire soc_gpio10_i,
  output wire soc_gpio11_i,
  output wire soc_gpio12_i,
  output wire soc_gpio13_i,
  output wire soc_gpio14_i,
  output wire soc_gpio15_i,
  input wire  soc_gpio0_o,
  input wire  soc_gpio1_o,
  input wire  soc_gpio2_o,
  input wire  soc_gpio3_o,
  input wire  soc_gpio4_o,
  input wire  soc_gpio5_o,
  input wire  soc_gpio6_o,
  input wire  soc_gpio7_o,
  input wire  soc_gpio8_o,
  input wire  soc_gpio9_o,
  input wire  soc_gpio10_o,
  input wire  soc_gpio11_o,
  input wire  soc_gpio12_o,
  input wire  soc_gpio13_o,
  input wire  soc_gpio14_o,
  input wire  soc_gpio15_o,
  input wire  soc_gpio0_en_o,
  input wire  soc_gpio1_en_o,
  input wire  soc_gpio2_en_o,
  input wire  soc_gpio3_en_o,
  input wire  soc_gpio4_en_o,
  input wire  soc_gpio5_en_o,
  input wire  soc_gpio6_en_o,
  input wire  soc_gpio7_en_o,
  input wire  soc_gpio8_en_o,
  input wire  soc_gpio9_en_o,
  input wire  soc_gpio10_en_o,
  input wire  soc_gpio11_en_o,
  input wire  soc_gpio12_en_o,
  input wire  soc_gpio13_en_o,
  input wire  soc_gpio14_en_o,
  input wire  soc_gpio15_en_o,
  // input wire  soc_gpio0_ie_o,
  // input wire  soc_gpio1_ie_o,
  // input wire  soc_gpio2_ie_o,
  // input wire  soc_gpio3_ie_o,
  // input wire  soc_gpio4_ie_o,
  // input wire  soc_gpio5_ie_o,
  // input wire  soc_gpio6_ie_o,
  // input wire  soc_gpio7_ie_o,
  // input wire  soc_gpio8_ie_o,
  // input wire  soc_gpio9_ie_o,
  // input wire  soc_gpio10_ie_o,
  // input wire  soc_gpio11_ie_o,
  // input wire  soc_gpio12_ie_o,
  // input wire  soc_gpio13_ie_o,
  // input wire  soc_gpio14_ie_o,
  // input wire  soc_gpio15_ie_o,
  // pad
  input wire  p_clk_i,
  input wire  p_rst_ni,
  input wire  p_ref_clk_i,

  input wire  p_jtag_tck_i,
  input wire  p_jtag_trst_ni,
  input wire  p_jtag_tms_i,
  input wire  p_jtag_tdi_i,
  output wire p_jtag_tdo_o,

  input wire  p_uart_rx_i,
  output wire p_uart_tx_o,

  input wire  p_fetch_en_i,
  output wire p_status_o,

  inout wire  p_gpio0_io,
  inout wire  p_gpio1_io,
  inout wire  p_gpio2_io,
  inout wire  p_gpio3_io,
  inout wire  p_gpio4_io,
  inout wire  p_gpio5_io,
  inout wire  p_gpio6_io,
  inout wire  p_gpio7_io,
  inout wire  p_gpio8_io,
  inout wire  p_gpio9_io,
  inout wire  p_gpio10_io,
  inout wire  p_gpio11_io,
  inout wire  p_gpio12_io,
  inout wire  p_gpio13_io,
  inout wire  p_gpio14_io,
  inout wire  p_gpio15_io,

  // custom IP
  output wire p_pll_clk_o,
  input wire  p_osc_clk_i,
  inout wire  p_dac_outp_o,
  inout wire  p_dac_outn_o,
  inout wire  p_dac_vbias_i,
  inout wire  p_adc_inp_i,
  inout wire  p_adc_inn_i       
);

   logic      jtag_tdo_dummy;
   logic      uart_tx_dummy;
   logic      status_dummy;
   logic      pll_clk_dummy;
   logic      soc_tie_l;
   
   wire       soc_gpio0_ie_o;
   wire       soc_gpio1_ie_o;
   wire       soc_gpio2_ie_o;
   wire       soc_gpio3_ie_o;
   wire       soc_gpio4_ie_o;
   wire       soc_gpio5_ie_o;
   wire       soc_gpio6_ie_o;
   wire       soc_gpio7_ie_o;
   wire       soc_gpio8_ie_o;
   wire       soc_gpio9_ie_o;
   wire       soc_gpio10_ie_o;
   wire       soc_gpio11_ie_o;
   wire       soc_gpio12_ie_o;
   wire       soc_gpio13_ie_o;
   wire       soc_gpio14_ie_o;
   wire       soc_gpio15_ie_o;

   assign soc_tie_l = 1'b0;
   assign soc_tie_h = 1'b1;
   assign soc_gpio0_ie_o = ~soc_gpio0_en_o;
   assign soc_gpio1_ie_o = ~soc_gpio1_en_o;
   assign soc_gpio2_ie_o = ~soc_gpio2_en_o;
   assign soc_gpio3_ie_o = ~soc_gpio3_en_o;
   assign soc_gpio4_ie_o = ~soc_gpio4_en_o;
   assign soc_gpio5_ie_o = ~soc_gpio5_en_o;
   assign soc_gpio6_ie_o = ~soc_gpio6_en_o;
   assign soc_gpio7_ie_o = ~soc_gpio7_en_o;
   assign soc_gpio8_ie_o = ~soc_gpio8_en_o;
   assign soc_gpio9_ie_o = ~soc_gpio9_en_o;
   assign soc_gpio10_ie_o = ~soc_gpio10_en_o;
   assign soc_gpio11_ie_o = ~soc_gpio11_en_o;
   assign soc_gpio12_ie_o = ~soc_gpio12_en_o;
   assign soc_gpio13_ie_o = ~soc_gpio13_en_o;
   assign soc_gpio14_ie_o = ~soc_gpio14_en_o;
   assign soc_gpio15_ie_o = ~soc_gpio15_en_o;
   
    gf180mcu_fd_io__in_c     pad_clk_i        (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_clk_i),
					       .Y(soc_clk_i),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
    gf180mcu_fd_io__in_c     pad_rst_ni       (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_rst_ni),
					       .Y(soc_rst_ni),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
    gf180mcu_fd_io__in_c     pad_ref_clk_i    (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_ref_clk_i),
					       .Y(soc_ref_clk_i),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
  
    gf180mcu_fd_io__in_c     pad_jtag_tck_i   (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_jtag_tck_i),
					       .Y(soc_jtag_tck_i),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
    gf180mcu_fd_io__in_c     pad_jtag_trst_ni (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_jtag_trst_ni),
					       .Y(soc_jtag_trst_ni),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
    gf180mcu_fd_io__in_c     pad_jtag_tms_i   (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_jtag_tms_i),
					       .Y(soc_jtag_tms_i),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));
    gf180mcu_fd_io__in_c     pad_jtag_tdi_i   (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_jtag_tdi_i),
					       .Y(soc_jtag_tdi_i),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h));

    gf180mcu_fd_io__bi_t     pad_jtag_tdo_o   (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_jtag_tdo_o),
					       .A(soc_jtag_tdo_o),
					       .CS(soc_tie_l),
					       .SL(soc_tie_l),
					       .IE(soc_tie_l),
					       .OE(soc_tie_h),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h),
					       .Y(tdo_dummy));

    gf180mcu_fd_io__in_c     pad_uart_rx_i    (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_uart_rx_i),
					       .Y(soc_uart_rx_i),
					       .PU(soc_tie_h),
					       .PD(soc_tie_l));
    gf180mcu_fd_io__bi_t     pad_uart_tx_o    (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_uart_tx_o),
					       .A(soc_uart_tx_o),
					       .OE(soc_tie_h),
					       .CS(soc_tie_l),
					       .SL(soc_tie_l),
					       .IE(soc_tie_l),
					       .PU(soc_tie_h),
					       .PD(soc_tie_l),
					       .Y(uart_tx_dummy));

    gf180mcu_fd_io__in_c     pad_fetch_en_i   (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_fetch_en_i),
					       .Y(soc_fetch_en_i));
    gf180mcu_fd_io__bi_t     pad_status_o     (.DVDD(VDD),
					       .DVSS(VSS),
					       .VSS(VSS),
					       .VDD(VDD),
					       .PAD(p_status_o),
					       .A(soc_status_o),
					       .OE(soc_tie_h),
					       .CS(soc_tie_l),
					       .SL(soc_tie_l),
					       .IE(soc_tie_l),
					       .PU(soc_tie_l),
					       .PD(soc_tie_h),
					       .Y(status_dummy));
 // `define GPIO_PAD (instname, pad, c2p, p2c, c2p_en) \
 //   gf180mcu_fd_io__bi_t p_``instname``     (.PAD(pad), .A(c2p), .Y(p2c) .OE(c2p_en), \
 // 					    .CS(soc_tie_l), .SL(soc_tie_l), .IE(~c2p_en), .PU(soc_tie_l), \
 // 					    .PD(soc_tie_h));

 // `define OUTPUT_PAD (id, pad, c2p) \
 //   gf180mcu_fd_io__bi_t pad_gpio_``id``     (.PAD(pad), .A(c2p), .Y() .OE(soc_tie_h), \
 // 					    .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_tie_l), .PU(soc_tie_l), \
 // 					    .PD(soc_tie_h));
  
   gf180mcu_fd_io__bi_t pad_gpio0_io (.DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(gpio0_io),
				      .A(soc_gpio0_o),
				      .Y(soc_gpio0_i),
				      .OE(soc_gpio0_en_o), 
				      .CS(soc_tie_l),
				      .SL(soc_tie_l),
				      .IE(~soc_gpio0_ie_o),
				      .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio1_io (.PAD(p_gpio1_io),
				      .A(soc_gpio1_o),
				      .Y(soc_gpio1_i),
				      .OE(soc_gpio1_en_o), 
				      .CS(soc_tie_l),
				      .SL(soc_tie_l),
				      .IE(soc_gpio1_ie_o),
				      .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio2_io (.DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(p_gpio2_io),
				      .A(soc_gpio2_o),
				      .Y(soc_gpio2_i),
				      .OE(soc_gpio2_en_o), 
				      .CS(soc_tie_l),
				      .SL(soc_tie_l),
				      .IE(soc_gpio2_ie_o),
				      .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio3_io (.DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(p_gpio3_io),
				      .A(soc_gpio3_o),
				      .Y(soc_gpio3_i),
				      .OE(soc_gpio3_en_o), 
				      .CS(soc_tie_l),
				      .SL(soc_tie_l),
				      .IE(soc_gpio3_ie_o),
				      .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio4_io (.DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(p_gpio4_io),
				      .A(soc_gpio4_o),
				      .Y(soc_gpio4_i),
				      .OE(soc_gpio4_en_o), 
				      .CS(soc_tie_l),
				      .SL(soc_tie_l),
				      .IE(soc_gpio4_ie_o),
				      .PU(soc_tie_l),
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio5_io (.DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(p_gpio5_io),
				      .A(soc_gpio5_o),
				      .Y(soc_gpio5_i),
				      .OE(soc_gpio5_en_o), 
				      .CS(soc_tie_l),
				      .SL(soc_tie_l),
				      .IE(soc_gpio5_ie_o),
				      .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio6_io (.DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(p_gpio6_io),
				      .A(soc_gpio6_o),
				      .Y(soc_gpio6_i),
				      .OE(soc_gpio6_en_o), 
				      .CS(soc_tie_l),
				      .SL(soc_tie_l),
				      .IE(soc_gpio6_ie_o),
				      .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio7_io (.DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(p_gpio7_io),
				      .A(soc_gpio7_o), .Y(soc_gpio7_i), .OE(soc_gpio7_en_o), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio7_ie_o), .PU(soc_tie_l), 
					    .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio8_io (.DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(p_gpio8_io), .A(soc_gpio8_o), .Y(soc_gpio8_i), .OE(soc_gpio8_en_o), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio8_ie_o), .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio9_io (.DVDD(VDD),
				      .DVSS(VSS),
				      .VSS(VSS),
				      .VDD(VDD),
				      .PAD(p_gpio9_io), .A(soc_gpio9_o), .Y(soc_gpio9_i), .OE(soc_gpio9_en_o), 
				      .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio9_ie_o), .PU(soc_tie_l), 
				      .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio10_io (.DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(p_gpio10_io), .A(soc_gpio10_o), .Y(soc_gpio10_i), .OE(soc_gpio10_en_o), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio10_ie_o), .PU(soc_tie_l), 
				       .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio11_io (.DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(p_gpio11_io), .A(soc_gpio11_o), .Y(soc_gpio11_i), .OE(soc_gpio11_en_o), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio11_ie_o), .PU(soc_tie_l), 
				       .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio12_io (.DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(p_gpio12_io), .A(soc_gpio12_o), .Y(soc_gpio12_i), .OE(soc_gpio12_en_o), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio12_ie_o), .PU(soc_tie_l), 
				       .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio13_io (.DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(p_gpio13_io), .A(soc_gpio13_o), .Y(soc_gpio13_i), .OE(soc_gpio13_en_o), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio13_ie_o), .PU(soc_tie_l), 
				       .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio14_io (.DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(p_gpio14_io), .A(soc_gpio14_o), .Y(soc_gpio14_i), .OE(soc_gpio14_en_o), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio14_ie_o), .PU(soc_tie_l), 
				       .PD(soc_tie_h));
    

   gf180mcu_fd_io__bi_t pad_gpio15_io (.DVDD(VDD),
				       .DVSS(VSS),
				       .VSS(VSS),
				       .VDD(VDD),
				       .PAD(p_gpio15_io), .A(soc_gpio15_o), .Y(soc_gpio15_i), .OE(soc_gpio15_en_o), 
				       .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_gpio15_ie_o), .PU(soc_tie_l), 
				       .PD(soc_tie_h));
    
   (* dont_touch = "true" *)
    gf180mcu_fd_io__bi_t pad_pll_clk_o     (.DVDD(VDD),
					    .DVSS(VSS),
					    .VSS(VSS),
					    .VDD(VDD),
					    .PAD(p_pll_clk_o),     .A(soc_pll_clk_o), .OE(soc_tie_h),
					    .CS(soc_tie_l), .SL(soc_tie_l), .IE(soc_tie_l), .PU(soc_tie_l),
					    .PD(soc_tie_h), .Y(pll_clk_dummy));
   
   (* dont_touch = "true" *)
   gf180mcu_fd_io__in_c     pad_osc_clk_i        (.DVDD(VDD),
						  .DVSS(VSS),
						  .VSS(VSS),
						  .VDD(VDD),
						  .PAD(p_osc_clk_i),
						  .Y(soc_osc_clk_i),
						  .PU(soc_tie_l),
						  .PD(soc_tie_h));

   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvdd pad_vdd0(.DVDD(VDD),
				 .DVSS(VSS),
				 .VSS(VSS));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvdd pad_vdd1(.DVDD(VDD),
				 .DVSS(VSS),
				 .VSS(VSS));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvdd pad_vdd2(.DVDD(VDD),
				 .DVSS(VSS),
				 .VSS(VSS));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvdd pad_vdd3(.DVDD(VDD),
				 .DVSS(VSS),
				 .VSS(VSS));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvss pad_vss0(.DVDD(VDD),
				 .DVSS(VSS),
				 .VDD(VDD));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvss pad_vss1(.DVDD(VDD),
				 .DVSS(VSS),
				 .VDD(VDD));
    (* dont_touch = "true" *)
   gf180mcu_fd_io__dvss pad_vss2(.DVDD(VDD),
				 .DVSS(VSS),
				 .VDD(VDD));
    (* dont_touch = "true" *)
   gf180mcu_fd_io__dvss pad_vss3(.DVDD(VDD),
				 .DVSS(VSS),
				 .VDD(VDD));

   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvdd pad_vddio0(.DVDD(VDD),
				   .DVSS(VSS),
				   .VSS(VSS));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvdd pad_vddio1(.DVDD(VDD),
				   .DVSS(VSS),
				   .VSS(VSS));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvdd pad_vddio2(.DVDD(VDD),
				   .DVSS(VSS),
				   .VSS(VSS));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvdd pad_vddio3(.DVDD(VDD),
				   .DVSS(VSS),
				   .VSS(VSS));
   
   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvss pad_vssio0(.DVDD(VDD),
				   .DVSS(VSS),
				   .VDD(VDD));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__dvss pad_vssio1(.DVDD(VDD),
				   .DVSS(VSS),
				   .VDD(VDD));
    (* dont_touch = "true" *)
   gf180mcu_fd_io__dvss pad_vssio2(.DVDD(VDD),
				   .DVSS(VSS),
				   .VDD(VDD));
    (* dont_touch = "true" *)
   gf180mcu_fd_io__dvss pad_vssio3(.DVDD(VDD),
				   .DVSS(VSS),
				   .VDD(VDD));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__asig_5p0 pad_dac_outp_o (.DVDD(VDD),
					    .DVSS(VSS),
					    .VSS(VSS),
					    .VDD(VDD),
					    .ASIG5V(p_dac_outp_o));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__asig_5p0 pad_dac_outn_o (.DVDD(VDD),
					    .DVSS(VSS),
					    .VSS(VSS),
					    .VDD(VDD),
					    .ASIG5V(p_dac_outn_o));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__asig_5p0 pad_dac_vbias_i (.DVDD(VDD),
					     .DVSS(VSS),
					     .VSS(VSS),
					     .VDD(VDD),
					     .ASIG5V(p_dac_vbias_i));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__asig_5p0 pad_adc_inp_i (.DVDD(VDD),
					   .DVSS(VSS),
					   .VSS(VSS),
					   .VDD(VDD),
					   .ASIG5V(p_adc_inp_i));
   (* dont_touch = "true" *)
   gf180mcu_fd_io__asig_5p0 pad_adc_inn_i (.DVDD(VDD),
					   .DVSS(VSS),
					   .VSS(VSS),
					   .VDD(VDD),
					   .ASIG5V(p_adc_inn_i));
endmodule // croc_padring

