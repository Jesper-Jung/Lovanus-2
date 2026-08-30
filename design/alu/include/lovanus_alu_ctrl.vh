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
//  * File Name     : lovanus_alu_ctrl.vh
//  * Author        : Jesper
//  * Purpose       :
//
//  * Note          :
//
//  * Reference     :
//
//=================================================================* * * * *---*

localparam  ALU_CTRL_W          = 4;

localparam  ALU_CTRL_ADD        = 4'h00,        // a + b
            ALU_CTRL_SUB        = 4'h01,        // a - b
            ALU_CTRL_SLL        = 4'h02,        // a << b
            ALU_CTRL_SLT        = 4'h03,        // $signed(a) < $signed(b)
            ALU_CTRL_SLTU       = 4'h04,        // a < b (unsigned)
            ALU_CTRL_SLTIU      = 4'h04,        // a < b (unsigned, equal to SLTU)
            ALU_CTRL_XOR        = 4'h05,        // a ^ b
            ALU_CTRL_SRL        = 4'h06,        // $signed(a) >>> b (arithmetic shift)
            ALU_CTRL_SRA        = 4'h07,        // a >> b (logical shift)
            ALU_CTRL_OR         = 4'h08,        // a | b
            ALU_CTRL_AND        = 4'h09;        // a & b

localparam  ALU_CTRL_BEQ        = 4'ha,         // a == b
            ALU_CTRL_BNE        = 4'hb,         // a != b
            ALU_CTRL_BGE        = 4'hc,         // $signed(a) >= $signed(b)
            ALU_CTRL_BGEU       = 4'hd;         // a >= b (Unsigned)