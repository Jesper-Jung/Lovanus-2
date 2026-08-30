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
//  * Module Name   : u_lovanus_alu_ctrl
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

module lovanus_alu_ctrl #(
     parameter                  DATA_W      = 32
     parameter                  ALU_CTRL_W  = 4
) (
     input         [`XLEN-1:0]  op_a_i
    ,input         [`XLEN-1:0]  op_b_i

    ,input    [ALU_CTRL_W-1:0]  alu_ctrl_i

    ,output        [`XLEN-1:0]  alu_res_o
    ,output                     alu_zero_o
);

//==============================================================================
// ALU Combinational Logic
//-------------------------------------------------------------------------*-*-*




//==============================================================================
// Debug Wiring
//-------------------------------------------------------------------------*-*-*


endmodule
