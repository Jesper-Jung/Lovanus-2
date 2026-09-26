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
//  * Module Name   : u_lovanus_mem_op_ctrl
//  * Author        : Jesper
//  * Purpose       : Decide zero-extension and data size for current memory operation
//
//  * Note
//
//=================================================================* * * * *---*

module lovanus_mem_op_ctrl (
    input ctrl_MemWrite_i
    input ctrl_MemtoReg_i
    input funct7_i
    input funct3_i

    output mctrl_ZeroExt_o
    output mctrl_DataSize_o
);

if MemWrite?        // Decide Mask signal for the mem controller
    foreach case of funct7_i, funct3_i
        decide mctrl_datasize_o

if MemtoReg?        // Format read data on the write back stage
    foreach case of funct7_i, funct3_i
        decide mctrl_ZeroExt_o, mctrl_datasize_o

endmodule
