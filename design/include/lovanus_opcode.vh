//=================================================================* * * * *---*
//
//     +                       +                                 +    
//    .         .         .        +          .          .         .         + .
// .    *       * *.  *      * **    **    * *    *   . * .   . *  .       .       
//      .      .    \  .    / .  \   . \   . .     \ *       +      *        . 
//  .   *     *      * *   *  * + *  *  *  * *      *  *    ---    *    .           .
//       .     \    .   . /  .     \  .   \ . \     .     *      *         .      .
// .     * -- *  * *     *   *      * *    **   *  *   *      +       *       .      .
//   .         .         .          .          .          .          + Lovanus-2 +  .
//             +                   +                      +                   +   
//
//  * File Name     : lovanus_opcode.vh
//  * Author        : Jesper
//  * Purpose       : Parameterize RISC-V Opcode's in a core designing module
//
//  * Note          :
//      | See '2.3 Immediate encoding variant' of the RISC-V unpriviliged document.  
//      | RV32I Base Inst set,
//          R-TYPE      // SLLI, SRLI, SRAI, ADD, SUB, SLL, SLT, SLTU, XOR, SLR, SRA, OR, AND
//          I-TYPE      // JALR, LW, ADDI, SLTI, SLTIU, XORI, ORI, ANDI
//          S-TYPE      // SW
//          B-TYPE      // BEQ, BNE, BLT, BGE, BLTU, BGEU
//          U-TYPE      // LUI, AUIPC
//          J-TYPE      // JAL
//          etc         // FENCE, ECALL, EBREAK
//
//  * Reference     :
//
//=================================================================* * * * *---*

// OPCODE I-TYPE
localparam  OPCODE_JALR             = 7'b1100111;
localparam  OPCODE_LW               = 7'b0000011;

localparam  OPCODE_ARITH_I_TYPE     = 7'b0010011;
localparam  OPCODE_ADDI             = 7'b0010011,
            OPCODE_SLTI             = 7'b0010011,
            OPCODE_SLTIU            = 7'b0010011,
            OPCODE_XORI             = 7'b0010011,
            OPCODE_ORI              = 7'b0010011,
            OPCODE_ANDI             = 7'b0010011;

// OPCODE S-TYPE
localparam  OPCODE_SW               = 7'b0100011;

// OPCODE B-TYPE
localparam  OPCODE_BRANCH_B_TYPE    = 7'b1100011;
localparam  OPCODE_BEQ              = 7'b1100011,
            OPCODE_BNE              = 7'b1100011,
            OPCODE_BLT              = 7'b1100011,
            OPCODE_BGE              = 7'b1100011,
            OPCODE_BLTU             = 7'b1100011,
            OPCODE_BGEU             = 7'b1100011;

// OPCODE U-TYPE
localparam  OPCODE_LUI              = 7'b0110111;
localparam  OPCODE_AUIPC            = 7'b0010111;

// OPCODE J-TYPE
localparam  OPCODE_JAL              = 7'b1101111;
