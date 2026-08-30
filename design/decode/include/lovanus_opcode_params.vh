//=================================================================* * * * *---*
//
//     +                       +                                 +    
//    .         .         .        +          .          .         .         + .
// .    *       * *.  *      * **    **    * *    *   . * .   . *  .       .       
//      .      .    \  .    / .  \   . \   . .     \ *       .      *        . 
//  .   *     *      * *   *  * + *  *  *  * *      *  *    ---    *    .           .
//       .     \    .   . /  .     \  .   \ . \     .     *      *        .      .
// .     * -- *  * *     *   *      * *    **   *  *   *      .       *       .      .
//   .         .         .          .          .          .          + Lovanus-2 +  .
//             +                   +                      +                   +   
//
//  * File Name     : lovanus_opcode_params.vh
//  * Author        : Jesper
//  * Purpose       : Parameterize RISC-V Opcode's in a core designing module
//
//  * Note          :
//      | See '2.3 Immediate encoding variant' of the RISC-V unpriviliged document.  
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
//
//=================================================================* * * * *---*
/* verilator lint_off UNUSEDPARAM */

// OPCODE R-TYPE
localparam  OPCODE_R_ARITH      = 7'b0110011;
localparam  OPCODE_R_ADD        = 7'b0110011,
            OPCODE_R_SUB        = 7'b0110011,
            OPCODE_R_SLL        = 7'b0110011,
            OPCODE_R_SLT        = 7'b0110011,
            OPCODE_R_SLTU       = 7'b0110011,
            OPCODE_R_XOR        = 7'b0110011,
            OPCODE_R_SRL        = 7'b0110011,
            OPCODE_R_SRA        = 7'b0110011,
            OPCODE_R_OR         = 7'b0110011,
            OPCODE_R_AND        = 7'b0110011;

// OPCODE I-TYPE
localparam  OPCODE_I_ARITH      = 7'b0010011;
localparam  OPCODE_I_ADDI       = 7'b0010011,
            OPCODE_I_SLTI       = 7'b0010011,
            OPCODE_I_SLTIU      = 7'b0010011,
            OPCODE_I_XORI       = 7'b0010011,
            OPCODE_I_ORI        = 7'b0010011,
            OPCODE_I_ANDI       = 7'b0010011,
            OPCODE_I_SLLI       = 7'b0010011,
            OPCODE_I_SRLI       = 7'b0010011,
            OPCODE_I_SRAI       = 7'b0010011;

localparam  OPCODE_I_LOAD       = 7'b0000011;
localparam  OPCODE_I_LB         = 7'b0000011,
            OPCODE_I_LH         = 7'b0000011,
            OPCODE_I_LW         = 7'b0000011,
            OPCODE_I_LBU        = 7'b0000011,
            OPCODE_I_LHU        = 7'b0000011;

localparam  OPCODE_I_JALR       = 7'b1100111;

// OPCODE S-TYPE
localparam  OPCODE_S_TYPE       = 7'b0100011;
localparam  OPCODE_S_SB         = 7'b0100011,
            OPCODE_S_SH         = 7'b0100011,
            OPCODE_S_SW         = 7'b0100011;

// OPCODE B-TYPE
localparam  OPCODE_B_TYPE       = 7'b1100011;
localparam  OPCODE_B_BEQ        = 7'b1100011,
            OPCODE_B_BNE        = 7'b1100011,
            OPCODE_B_BLT        = 7'b1100011,
            OPCODE_B_BGE        = 7'b1100011,
            OPCODE_B_BLTU       = 7'b1100011,
            OPCODE_B_BGEU       = 7'b1100011;

// OPCODE U-TYPE
localparam  OPCODE_U_LUI        = 7'b0110111;
localparam  OPCODE_U_AUIPC      = 7'b0010111;

// OPCODE J-TYPE
localparam  OPCODE_J_JAL        = 7'b1101111;

// OPCODE SYSTEM & MISC-MEM (etc)
localparam  OPCODE_SYSTEM       = 7'b1110011;
localparam  OPCODE_SYS_ECALL    = 7'b1110011,
            OPCODE_SYS_EBREAK   = 7'b1110011;

localparam  OPCODE_MISC_MEM     = 7'b0001111;
localparam  OPCODE_FENCE        = 7'b0001111;

/* verilator lint_on UNUSEDPARAM */