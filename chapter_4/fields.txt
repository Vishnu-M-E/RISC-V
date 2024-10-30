

\TLV
   
   $reset = *reset;
   
   $pc[31:0] = >>1$next_pc;
   $next_pc[31:0] = $reset ? 32'b0 : $pc + 32'd4;
   
   `READONLY_MEM($pc, $$instr[31:0]);
   
   $is_u_instr = $instr[6:2] ==? 5'b0x101;
   $is_i_instr = $instr[6:2] ==? 5'b0000x || $instr[6:2] ==? 5'b001x0 || $instr[6:2] == 5'b11001;
   $is_r_instr = $instr[6:2] ==? 5'b011x0 || $instr[6:2] == 5'b01011 || $instr[6:2] == 5'b10100;
   $is_s_instr = $instr[6:2] ==? 5'b0100x;
   $is_b_instr = $instr[6:2] == 5'b11000;
   $is_j_instr = $instr[6:2] == 5'b11011;

   
   
   $is_load = ($opcode ==? 7'b0x00011);
   
   $rs2[4:0] = $instr[24:20];
   $funct7[6:0] = $instr[31:25];
   $rs1[4:0] = $instr[19:15];
   $funct3[2:0] = $instr[14:12];
   $rd[4:0] = $instr[11:7];
   $opcode[6:0] = $instr[6:0];
   
   $rd_valid = ~($is_s_instr || $is_b_instr || $instr[11:7] == 5'b0);
   $imm_valid = ~$is_r_instr;
   $rs1_valid = ~($is_u_instr || $is_j_instr);
   $rs2_valid = ($is_r_instr || $is_s_instr || $is_b_instr);
   
   `BOGUS_USE($rd $rd_valid $rs1 $rs1_valid $rs2 $rs2_valid $funct3 $funct7 $imm $imm_valid);
   
   $imm[31:0] = $is_i_instr ? {{21{$instr[31]}}, $instr[30:20]} :
                $is_s_instr ? {{21{$instr[31]}}, $instr[30:25], $instr[11:8], $instr[7]} :
                $is_b_instr ? {{19{$instr[31]}}, {2{$instr[7]}}, $instr[30:25],$instr[11:8], 1'b0} :
                $is_u_instr ? {$instr[31], $instr[30:20], $instr[19:12], 12'b0} :
                $is_j_instr ? {{11{$instr[31]}}, $instr[19:12], {2{$instr[20]}}, $instr[30:21], 1'b0} :
                32'b0 ;
