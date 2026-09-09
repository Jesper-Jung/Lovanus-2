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
//      |   - JumpB, control signal
//          
//
//      |   - JumpJ, control signal
//
//  * Reference     :
//
//=================================================================* * * * *---*

module u_lovanus_mux_pc_next #(
     parameter              XLEN    = 32
) (
     input       [XLEN-1:0] pc_i
    ,input       [XLEN-1:0] imm_ext_i

    ,input                  branch_hit

    ,input                  ctrl_JumpB_i
    ,input                  ctrl_JumpJ_i

    ,output      [XLEN-1:0] pc_next_o
);

wire                jump_en;

wire     [XLEN-1:0] pc_jump;
wire     [XLEN-1:0] pc_add_4;

// Assign
assign jump_en      = ( ctrl_JumpJ_i    | ( ctrl_JumpB_i & branch_hit ));

assign pc_jump      = ( pc_i + imm_ext_i    );
assign pc_add_4     = ( pc_i + 32'h4        );

assign pc_next_o    = ( jump_en    ) ? pc_jump : pc_add_4;

endmodule
