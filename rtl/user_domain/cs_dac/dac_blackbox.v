(* blackbox *)
module CS_DAC_10b(
`ifdef USE_POWER_PINS
		  VDD,
		  VSS,
`endif
		  X1, X2, X3, X4, X5, X6, X7, X8, X9, X10,
		  VBIAS, CLK, OUTP, OUTN);
`ifdef USE_POWER_PINS
   inout VDD;
   inout VSS;
`endif
   input X1;
   input X2;
   input X3;
   input X4;
   input X5;
   input X6;
   input X7;
   input X8;
   input X9;
   input X10;

   inout VBIAS;
   input CLK;
   output OUTP;
   output OUTN;

endmodule; // CS_DAC_10b
