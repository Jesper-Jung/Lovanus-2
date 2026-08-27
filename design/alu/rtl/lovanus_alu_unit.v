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
//  * Module Name   : u_lovanus_alu_unit
//  * Author        : Jesper
//  * Purpose       : Calculate with ~~~.
//
//  * Note          :
//      | RV32I Base Inst set,
//          R-TYPE      // ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
//
//  * Reference     :
//      1. [Hazard3] hazard3_regfile_1w2r.v
//
//=================================================================* * * * *---*

module lovanus_alu_unit #(
     parameter                  DATA_W = 32
) (
     input  aluop_i
    ,input  funct7_i
    ,input  funct3_i

    ,input  op_a_i
    ,input  op_b_i

    ,output result_o
);

//==============================================================================
// ALU Combinational Logic
//-------------------------------------------------------------------------*-*-*


//==============================================================================
// Debug Wiring
//-------------------------------------------------------------------------*-*-*

wire [XLEN-1:0] _debug_regf_sp = r_mem_regf[2];

endmodule
