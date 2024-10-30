Instantiating a Verilog macro that accepts a byte address as input, and produces the 32-bit read data as output.

\TLV
   
   $reset = *reset;
   
   $pc[31:0] = >>1$next_pc;
   $next_pc[31:0] = $reset ? 32'b0 : $pc + 32'd4;
   
   `READONLY_MEM($pc, $$instr[31:0]);
