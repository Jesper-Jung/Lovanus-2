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
//  * File Name     : lovanus_funct_params.vh
//  * Author        : Jesper
//  * Purpose       :
//
//  * Note          :
//      | See '2.3 Immediate encoding variant' of the RISC-V unpriviliged document.  
//
//  * Reference     :
//
//=================================================================* * * * *---*

/*
    Funct3 ----
*/

// Branch Instructions (B-Type)
localparam  F3_BEQ      = 3'b000,
            F3_BNE      = 3'b001,
            F3_BLT      = 3'b100,
            F3_BGE      = 3'b101,
            F3_BLTU     = 3'b110,
            F3_BGEU     = 3'b111;

// Jump and Link Register (I-Type)
localparam  F3_JALR     = 3'b000;

// Memory Load Instructions (I-Type)
localparam  F3_LB       = 3'b000,
            F3_LH       = 3'b001,
            F3_LW       = 3'b010,
            F3_LBU      = 3'b100,
            F3_LHU      = 3'b101;

// Integer Arithmetic Immediate (I-Type)
localparam  F3_ADDI     = 3'b000,
            F3_SLTI     = 3'b010,
            F3_SLTIU    = 3'b011,
            F3_XORI     = 3'b100,
            F3_ORI      = 3'b110,
            F3_ANDI     = 3'b111;

// Constant Shift Instructions (I-Type)
localparam  F3_SLLI     = 3'b001,
            F3_SRLI     = 3'b101,
            F3_SRAI     = 3'b101;

// Memory Store Instructions (S-Type)
localparam  F3_SB       = 3'b000,
            F3_SH       = 3'b001,
            F3_SW       = 3'b010;

// Integer Register-Register (R-Type)
localparam  F3_ADD      = 3'b000,
            F3_SUB      = 3'b000,
            F3_SLL      = 3'b001,
            F3_SLT      = 3'b010,
            F3_SLTU     = 3'b011,
            F3_XOR      = 3'b100,
            F3_SRL      = 3'b101,
            F3_SRA      = 3'b101,
            F3_OR       = 3'b110,
            F3_AND      = 3'b111;

/*
    Funct7 ----
*/

// Constant Shift Instructions (I-Type)
localparam  F7_SLLI     = 7'b0000000,
            F7_SRLI     = 7'b0000000,
            F7_SRAI     = 7'b0100000;

// Integer Register-Register (R-Type)
localparam  F7_ADD      = 7'b0000000,
            F7_SUB      = 7'b0100000,
            F7_SLL      = 7'b0000000,
            F7_SLT      = 7'b0000000,
            F7_SLTU     = 7'b0000000,
            F7_XOR      = 7'b0000000,
            F7_SRL      = 7'b0000000,
            F7_SRA      = 7'b0100000,
            F7_OR       = 7'b0000000,
            F7_AND      = 7'b0000000;
