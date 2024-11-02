Learnt about sequential logic and flip-flops

\m5_TLV_version 1d: tl-x.org
\m5
   
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;
   
   //...
   $cnt[15:0] = $reset ? 16'b0 : >>1$cnt + 1;
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

