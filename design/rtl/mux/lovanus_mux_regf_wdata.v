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
//  * Module Name   : u_lovanus_mux_regf_wdata
//  * Author        : Jesper
//  * Purpose       : Calculate next value of PC
//
//  * Note          :
//      |   - JumpB, control signal
//          
//
//      |   - JumpJ, control signal
//
//  * Reference     :
//
//=================================================================* * * * *---*

module u_lovanus_mux_regf_wdata #(
     parameter              XLEN    = 32
) (
     input       [XLEN-1:0] alu_result_i                    // default
    ,input       [XLEN-1:0] mem_rdata_i                     // If MemtoReg
    ,input       [XLEN-1:0] pc_plus4_i                      // If LinktoReg

    ,input                  ctrl_MemtoReg_i
    ,input                  ctrl_LinktoReg_i

    ,output      [XLEN-1:0] regf_wdata_o
);

// Assign
assign regf_wdata_o = ( ctrl_LinktoReg_i    ) ? pc_plus4_i  :
                      ( ctrl_MemtoReg_i     ) ? mem_rdata_i : alu_result_i;

endmodule
