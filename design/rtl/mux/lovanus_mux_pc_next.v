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
     input       [XLEN-1:0] pc_i
    ,input       [XLEN-1:0] alu_result_i

    ,input                  branch_taken_i
    ,input                  ctrl_Jump_i

    ,output      [XLEN-1:0] pc_next_o
    ,output      [XLEN-1:0] pc_plus4_o
);

wire                jump_en;

wire     [XLEN-1:0] pc_jump;
wire     [XLEN-1:0] pc_plus4;

// Assign
assign jump_en      = ( ctrl_Jump_i | branch_taken_i );

assign pc_jump      = ( pc_i + imm_ext_i    );
assign pc_plus4     = ( pc_i + 32'h4        );

assign pc_next_o    = ( jump_en    ) ?  pc_jump   : pc_plus4;
assign pc_plus4_o   =                   pc_plus4            ;

endmodule
