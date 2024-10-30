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
   
   $dec_bits[10:0] = {$funct7[5], $funct3, $opcode};
   
   $is_beq = $dec_bits ==? 11'bx0001100011;
   $is_bne = $dec_bits ==? 11'bx0011100011;
   $is_blt = $dec_bits ==? 11'bx1001100011;
   $is_bge = $dec_bits ==? 11'bx1011100011;
   $is_bltu = $dec_bits ==? 11'bx1101100011;
   $is_bgeu = $dec_bits ==? 11'bx1111100011;
   $is_addi = $dec_bits ==? 11'bx0000010011;
   $is_add = $dec_bits ==? 11'b00000110011;

   $is_slti = $dec_bits ==? 11'bx0100010011;

   $is_sltiu = $dec_bits ==? 11'bx0110010011;

   $is_xori = $dec_bits ==? 11'bx1000010011;

   $is_ori = $dec_bits ==? 11'bx1100010011;

   $is_andi = $dec_bits ==? 11'bx1110010011;

   $is_slli = $dec_bits ==? 11'b00010010011;

   $is_srli = $dec_bits ==? 11'b01010010011;

   $is_srai = $dec_bits ==? 11'b11010010011;

   $is_sub = $dec_bits ==? 11'b10000110011;

   $is_sll = $dec_bits ==? 11'b00010110011;

   $is_slt = $dec_bits ==? 11'b00100110011;

   $is_sltu = $dec_bits ==? 11'b00110110011;

   $is_xor = $dec_bits ==? 11'b01000110011;

   $is_srl = $dec_bits ==? 11'b01010110011;

   $is_sra = $dec_bits ==? 11'b11010110011;

   $is_or = $dec_bits ==? 11'b01100110011;

   $is_and = $dec_bits ==? 11'b01110110011;

   $is_lui = $dec_bits ==? 11'bxxxx0110111;

   $is_auipc = $dec_bits ==? 11'bxxxx0010111;

   $is_jal = $dec_bits ==? 11'bxxxx1101111;

   $is_jalr = $dec_bits ==? 11'bx0001100111;
   
   `BOGUS_USE($is_beq $is_bne $is_blt $is_bge $is_bltu $is_bgeu $is_addi $is_add);
