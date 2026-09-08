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
     parameter              XLEN        = 32

    ,parameter              ALUOP_W     = 2
    ,parameter              ALU_CTRL_W  = 4

    ,parameter              OPCODE_W    = 7
    ,parameter              FUNCT7_W    = 7
    ,parameter              FUNCT3_W    = 3
) (
    ,input       [XLEN-1:0] instr_i

    ,input    [ALUOP_W-1:0] ctrl_ALUOp_i
    ,input                  ctrl_ALUSrc1_i
    ,input                  ctrl_ALUSrc2_i

    ,input       [XLEN-1:0] dec_rdata1_i
    ,input       [XLEN-1:0] pc_i

    ,input       [XLEN-1:0] dec_rdata2_i
    ,input       [XLEN-1:0] imm_ext_i

    ,output      [XLEN-1:0] result_o
    ,output                 branch_hit_o
);

`include "lovanus_alu_ctrl.vh"

wire opcode = instr_i[ 6: 0];
wire funct7 = instr_i[31:25];
wire funct3 = instr_i[14:12];

wire [ALU_CTRL_W-1:0] alu_ctrl;

wire [XLEN-1:0] op_a_muxed;
wire [XLEN-1:0] op_b_muxed;

//==============================================================================
// ALU Controller
//-------------------------------------------------------------------------*-*-*

lovanus_alu_ctrl u_lovanus_alu_ctrl (
     .ctrl_ALUOp_i          ( ctrl_ALUOp_i  )
    ,.funct7_i              ( funct7        )
    ,.funct3_i              ( funct3        )

    ,.alu_ctrl_o            ( alu_ctrl      )
);

//==============================================================================
// ALU calculation unit
//-------------------------------------------------------------------------*-*-*

assign op_a_muxed = ( ctrl_ALUSrc1_i    ) ? pc_i        : dec_rdata1_i;
assign op_b_muxed = ( ctrl_ALUSrc2_i    ) ? imm_ext_i   : dec_rdata2_i;

lovanus_alu_core u_lovanus_alu_core (
     .op_a_i                ( op_a_muxed    )
    ,.op_b_i                ( op_b_muxed    )

    ,.alu_ctrl_i            ( alu_ctrl      )

    ,.result_o              ( result_o      )
);

lovanus_branch_ctrl u_lovanus_branch_ctrl (
     .op_a_i                ( op_a_muxed    )
    ,.op_b_i                ( op_b_muxed    )

    ,.alu_ctrl_i            ( alu_ctrl      )
    ,.funct3_i              ( funct3        )

    ,.branch_hit_o          ( branch_hit_o  )
);

endmodule
