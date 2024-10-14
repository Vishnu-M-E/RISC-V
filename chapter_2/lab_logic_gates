A multiplexer (mux)

\m5_TLV_version 1d: tl-x.org
\m5
\SV
   m5_makerchip_module
\TLV
   $reset = *reset;
   
   //...
   $xor = $in1 ^ $in2;
   $out = $xor ^ $carry_in;
   $carry_out = $carry_in & $xor) | ($in2 & $in1);
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

