//=================================================================* * * * *---*
//
//     +                       +                                 +    
//    .         .         .        +          .          .         .         + .
// .    *       * *.  *      * **    **    * *    *   . * .   . *  .       .       
//      .      .    \  .    / .  \   . \   . .     \ *       .      *        . 
//  .   *     *      * *   *  * + *  *  *  * *      *  *    ---    *    .           .
//       .     \    .   . /  .     \  .   \ . \     .     *      *        .      .
// .     * -- *  * *     *   *      * *    **   *  *   *      .      *       .      .
//   .         .         .          .          .          .          + Lovanus-2 +  .
//             +                   +                      +                   +   
//
//  * Module Name   : u_lovanus_alu_unit
//  * Author        : Jesper
//  * Purpose       : Calculate with ~~~.
//
//  * Note          :
//      | RV32I Base Inst set,
//          R-TYPE      // ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
//          I-TYPE      // JALR, LB, LH, LW, LBU, LHU, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
//          S-TYPE      // SB, SH, SW
//          B-TYPE      // BEQ, BNE, BLT, BGE, BLTU, BGEU
//          U-TYPE      // LUI, AUIPC
//          J-TYPE      // JAL
//          etc         // FENCE, ECALL, EBREAK
//
//  * Reference     :
//      1. [Hazard3] hazard3_regfile_1w2r.v
//
//=================================================================* * * * *---*

module lovanus_alu_unit #(
     parameter                  XLEN        = 32

    ,parameter                  ALU_CTRL_W  = 4
) (
     input          [XLEN-1:0]  op_a_i
    ,input          [XLEN-1:0]  op_b_i

    ,input    [ALU_CTRL_W-1:0]  alu_ctrl_i

    ,output         [XLEN-1:0]  alu_res_o
    ,output                     alu_zero_o
);

//==============================================================================
// ALU Combinational Logic
//-------------------------------------------------------------------------*-*-*
	`RVOPC_BEQ:       raw_aluop = ALUOP_SUB;
	`RVOPC_BNE:       raw_aluop = ALUOP_SUB;
	`RVOPC_BLT:       raw_aluop = ALUOP_LT; 
	`RVOPC_BGE:       raw_aluop = ALUOP_LT; 
	`RVOPC_BLTU:      raw_aluop = ALUOP_LTU;
	`RVOPC_BGEU:      raw_aluop = ALUOP_LTU;
	`RVOPC_JALR:      raw_aluop = ALUOP_ADD;
	`RVOPC_JAL:       raw_aluop = ALUOP_ADD;
	`RVOPC_LUI:       raw_aluop = ALUOP_RS2;
	`RVOPC_AUIPC:     raw_aluop = ALUOP_ADD;
	`RVOPC_ADDI:      raw_aluop = ALUOP_ADD;
	`RVOPC_SLLI:      raw_aluop = ALUOP_SLL;
	`RVOPC_SLTI:      raw_aluop = ALUOP_LT;
	`RVOPC_SLTIU:     raw_aluop = ALUOP_LTU;
	`RVOPC_XORI:      raw_aluop = ALUOP_XOR;
	`RVOPC_SRLI:      raw_aluop = ALUOP_SRL;
	`RVOPC_SRAI:      raw_aluop = ALUOP_SRA;
	`RVOPC_ORI:       raw_aluop = ALUOP_OR;
	`RVOPC_ANDI:      raw_aluop = ALUOP_AND;
	`RVOPC_ADD:       raw_aluop = ALUOP_ADD;
	`RVOPC_SUB:       raw_aluop = ALUOP_SUB;
	`RVOPC_SLL:       raw_aluop = ALUOP_SLL;
	`RVOPC_SLTU:      raw_aluop = ALUOP_LTU;
	`RVOPC_XOR:       raw_aluop = ALUOP_XOR;
	`RVOPC_SRL:       raw_aluop = ALUOP_SRL;
	`RVOPC_SRA:       raw_aluop = ALUOP_SRA;
	`RVOPC_OR:        raw_aluop = ALUOP_OR;
	`RVOPC_AND:       raw_aluop = ALUOP_AND;
	`RVOPC_LB:        begin raw_addr_is_regoffs = 1'b1; raw_rs2 = X0; raw_memop = MEMOP_LB;  end
	`RVOPC_LH:        begin raw_addr_is_regoffs = 1'b1; raw_rs2 = X0; raw_memop = MEMOP_LH;  end
	`RVOPC_LW:        begin raw_addr_is_regoffs = 1'b1; raw_rs2 = X0; raw_memop = MEMOP_LW;  end
	`RVOPC_LBU:       begin raw_addr_is_regoffs = 1'b1; raw_rs2 = X0; raw_memop = MEMOP_LBU; end
	`RVOPC_LHU:       begin raw_addr_is_regoffs = 1'b1; raw_rs2 = X0; raw_memop = MEMOP_LHU; end
	`RVOPC_SB:        begin raw_addr_is_regoffs = 1'b1; raw_aluop = ALUOP_RS2;
	`RVOPC_SH:        begin raw_addr_is_regoffs = 1'b1; raw_aluop = ALUOP_RS2;
	`RVOPC_SW:        begin raw_addr_is_regoffs = 1'b1; raw_aluop = ALUOP_RS2;

	`RVOPC_SLT:       begin
		raw_aluop = ALUOP_LT;
		if (|EXTENSION_XH3POWER && ~|raw_rd && ~|raw_rs1) begin
			if (raw_rs2 == 5'h00) begin
				// h3.block (power management hint)
				d_invalid_32bit = trap_wfi;
				raw_sleep_block = !trap_wfi;
			end else if (raw_rs2 == 5'h01) begin
				// h3.unblock (power management hint)
				d_invalid_32bit = trap_wfi;
				raw_sleep_unblock = !trap_wfi;
			end
		end
	end

//==============================================================================
// Debug Wiring
//-------------------------------------------------------------------------*-*-*

wire [XLEN-1:0] _debug_regf_sp = r_mem_regf[2];

endmodule
