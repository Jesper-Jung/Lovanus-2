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
//  * Module Name   : u_lovanus_mux_pc_next
//  * Author        : Jesper
//  * Purpose       : Calculate next value of PC
//
//  * Note          :
//      | - `branch_taken_i`
//        Branch comparator determines if the branch be taken or not, which
//        asserts this signal if the branch is taken.     
//
//      | - `ctrl_Jump_i`
//        If `JAL` or `JALr` currently execute, assert this signal to move PC
//        to the jump address.
//
//  * Reference     :
//
//=================================================================* * * * *---*

module u_lovanus_mux_pc_next #(
     parameter              XLEN    = 32
) (
     input       [XLEN-1:0] pc_plus4_i            // Default
    ,input       [XLEN-1:0] alu_result_i          // Always `pc + imm` which is selected when branch or jump

    ,input                  branch_taken_i        // Assert if branch is taken from branch comparator
    ,input                  ctrl_Jump_i           // Assert if the current instruction executes jump (JAL, JALR)

    ,output      [XLEN-1:0] pc_next_o
);

// Assign
assign pc_next_o    = ( ctrl_Jump_i | branch_taken_i ) ?  alu_result_i   : pc_plus4_i;

endmodule
