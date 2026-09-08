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
//  * File Name     : lovanus_alu_params.vh
//  * Author        : Jesper
//  * Purpose       :
//
//  * Note          :
//
//  * Reference     :
//
//=================================================================* * * * *---*

localparam  ALUOP_DEFAULT      = 2'h00,         // In default, ALU operates ADD
            ALUOP_BRANCH       = 2'h01,         // To decide to take branch, ALU operates SUB
            ALUOP_ARITH        = 2'h10;         // In this case, ALU operates appropriate operator following :sig:`alu_ctrl`

localparam  ALU_CTRL_ADD       = 4'h00,         // a + b
            ALU_CTRL_SUB       = 4'h01,         // a - b
            ALU_CTRL_AND       = 4'h02,         // a & b
            ALU_CTRL_OR        = 4'h03,         // a | b
            ALU_CTRL_XOR       = 4'h04,         // a ^ b
            ALU_CTRL_SLL       = 4'h05,         // a << b
            ALU_CTRL_SRL       = 4'h06,         // a >> b
            ALU_CTRL_SRA       = 4'h07,         // $signed(a) >>> b
            ALU_CTRL_SLT       = 4'h08,         // $signed(a) < $signed(b)
            ALU_CTRL_SLTU      = 4'h09;         // a < b
