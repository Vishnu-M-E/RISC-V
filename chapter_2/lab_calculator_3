This lab improves on the rudamentary calculator by adding a $reset which enables the calculator to add to its previous
result and allows the calculator to be reset to 0;

\m5_TLV_version 1d: tl-x.org
\m5
   
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)

        /* verilator lint_on WIDTH */
\TLV
   $reset = *reset;
   
   //...
   $val1[31:0] = >>1$out;
   $val2[31:0] = {28'b0, $val2_rand[3:0]};
   
   $sum[31:0] = $val1 + $val2[31:0];
   $diff[31:0] = $val1 - $val2;
   $prod[31:0] = $val1 * $val2;
   $quot[31:0] = $val1 / $val2;
   
   $out[31:0] = $op == 2'b00 ? $sum :
   $op == 2'b01 ? $diff :
   $op == 2'b10 ? $prod :
   $quot;
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
 
