\TLV
   
   $reset = *reset;
   
   $pc[31:0] = >>1$next_pc;
   $next_pc[31:0] = $reset ? 32'b0 : $pc + 32'd4;
