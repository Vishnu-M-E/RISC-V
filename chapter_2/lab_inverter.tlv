An inverter, used to invert the input signals

TL-Verilog code:

\m5_TLV_version 1d: tl-x.org
\m5
\SV
   m5_makerchip_module
\TLV
   $reset = *reset;
   
   //...
   $out = ! $in;
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

