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
//  * Module Name   : u_lovanus_alu_core
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
//=================================================================* * * * *---*

module lovanus_alu_core #(
     parameter                  XLEN        = 32

    ,parameter                  ALUOP_W  	= 2
    ,parameter                  ALU_CTRL_W  = 4
	,parameter					SHAMT_W		= 4
) (
     input           [XLEN-1:0] op_a_i
    ,input           [XLEN-1:0] op_b_i

    ,input     [ALU_CTRL_W-1:0] alu_ctrl_i

    ,output          [XLEN-1:0] result_o
);

reg [XLEN-1:0] result;

wire signed [XLEN-1:0] 		op_a_sgn;
wire signed [XLEN-1:0] 		op_b_sgn;
wire		[SHAMT_W-1:0]	shamt;

assign op_a_sgn = op_a_i;
assign op_b_sgn = op_b_i;
assign shamt 	= op_b_i[0 +: SHAMT_W];

always @(*) begin
	result = {XLEN{1'b0}};
	case (alu_ctrl_i)
		ALU_CTRL_ADD 	: result = (op_a_i   +   op_b_i  );
		ALU_CTRL_SUB 	: result = (op_a_i   -   op_b_i  );
		ALU_CTRL_AND 	: result = (op_a_i   &   op_b_i  );
		ALU_CTRL_OR  	: result = (op_a_i   |   op_b_i  );
		ALU_CTRL_XOR 	: result = (op_a_i   ^   op_b_i  );
		ALU_CTRL_SLL 	: result = (op_a_i   <<  shamt   );
		ALU_CTRL_SRL 	: result = (op_a_i   >>  shamt   );
		ALU_CTRL_SRA 	: result = (op_a_sgn >>> shamt   );
		ALU_CTRL_SLT 	: result = (op_a_sgn <   op_b_sgn);
		ALU_CTRL_SLTU	: result = (op_a_i   <   op_b_i  );
	endcase
end

assign result_o = result;

endmodule
