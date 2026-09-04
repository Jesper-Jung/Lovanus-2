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
//  * Module Name   : u_lovanus_alu
//  * Author        : Jesper
//  * Purpose       : Calculate .
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

`include "lovanus_def.vh"

module lovanus_alu #(
     parameter              XLEN    = 32
) (
    ,input      [XLEN-1:0]  instruction_i

    ,input                  ctrl_AUIPC_i
    ,input           [1:0]  ctrl_ALUOp_i
    ,input                  ctrl_ALUSrc_i

    ,input      [XLEN-1:0]  decode_rs1_i
    ,input      [XLEN-1:0]  pc_i

    ,input      [XLEN-1:0]  decode_rs2_i
    ,input      [XLEN-1:0]  imm_ext_i

    ,output     [XLEN-1:0]  alu_res_o
    ,output                 alu_zero_o
);

`include "lovanus_alu_ctrl.vh"

wire [ALU_CTRL_W-1:0] alu_ctrl;

wire [XLEN-1:0] op_a_muxed;
wire [XLEN-1:0] op_b_muxed;

//==============================================================================
// ALU Controller
//-------------------------------------------------------------------------*-*-*

lovanus_alu_ctrl u_lovanus_alu_ctrl (
     .instruction_i         ( instruction_i )
    ,.ctrl_ALUOp_i          ( ctrl_ALUOp_i  )

    ,.alu_ctrl_o            ( alu_ctrl      )
);

//==============================================================================
// ALU calculation unit
//-------------------------------------------------------------------------*-*-*

assign op_a_muxed = (ctrl_AUIPC_i   ) ? pc_i        : decode_rs1_i;
assign op_b_muxed = (ctrl_AUISrc_i  ) ? imm_ext_i   : decode_rs2_i;

lovanus_alu_core u_lovanus_alu_core (
     .op_a_i                ( op_a_muxed    )
    ,.op_b_i                ( op_b_muxed    )

    ,.alu_ctrl_i            ( alu_ctrl      )

    ,.alu_res_o             ( alu_res_o     )
    ,.alu_zero_o            ( alu_zero_o    )
);

endmodule
