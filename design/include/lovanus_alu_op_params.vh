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
//  * File Name     : lovanus_alu_op_params.vh
//  * Author        : Jesper
//  * Purpose       :
//
//  * Note          :
//
//  * Reference     :
//
//=================================================================* * * * *---*

localparam  ALUOP_ADD       = 4'h00,        // a + b
            ALUOP_SUB       = 4'h01,        // a - b
            ALUOP_SLL       = 4'h02,        // a << b
            ALUOP_SLT       = 4'h03,        // $signed(a) < $signed(b)
            ALUOP_SLTU      = 4'h04,        // a < b (unsigned)
            ALUOP_SLTIU     = 4'h04,        // a < b (unsigned, equal to SLTU)
            ALUOP_XOR       = 4'h05,        // a ^ b
            ALUOP_SRL       = 4'h06,        // $signed(a) >>> b (arithmetic shift)
            ALUOP_SRA       = 4'h07,        // a >> b (logical shift)
            ALUOP_OR        = 4'h08,        // a | b
            ALUOP_AND       = 4'h09;        // a & b

localparam  ALUOP_BEQ       = 4'h0a,         // a == b
            ALUOP_BNE       = 4'h0b,         // a != b
            ALUOP_BGE       = 4'h0c,         // $signed(a) >= $signed(b)
            ALUOP_BGEU      = 4'h0d;         // a >= b (Unsigned)