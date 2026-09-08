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
//  * Module Name   : u_lovanus_branch_ctrl
//  * Author        : Jesper
//  * Purpose       :
//
//  * Note          :
//      |   See '2.3 Immediate encoding variant' of the RISC-V unpriviliged document.  
//
//  * Reference     :
//
//=================================================================* * * * *---*

module lovanus_branch_ctrl #(
     parameter                  XLEN = 32

    ,parameter                  ALU_OP_W = 2
) (
     input           [XLEN-1:0] op_a_i
    ,input           [XLEN-1:0] op_b_i

    ,input       [ALU_OP_W-1:0] alu_op_i
    ,input       [FUNCT3_W-1:0] funct3_i

    ,output                     branch_hit_o
);

`include "lovanus_funct_params.vh"

wire signed [XLEN-1:0] op_a_sgn;
wire signed [XLEN-1:0] op_b_sgn;

reg branch_hit;

assign op_a_sgn = op_a_i;
assign op_b_sgn = op_b_i;

always @(*) begin
    branch_hit = 1'b0;
    if (alu_op_i == ALUOP_BRANCH) begin
        case (funct3_i)
            F3_BEQ      : branch_hit = (op_a_i      == op_b_i   );
            F3_BNE      : branch_hit = (op_a_i      != op_b_i   );
            F3_BLT      : branch_hit = (op_a_sgn    <  op_b_sgn );
            F3_BGE      : branch_hit = (op_a_sgn    >= op_b_sgn );
            F3_BLTU     : branch_hit = (op_a_i      <  op_b_i   );
            F3_BGEU     : branch_hit = (op_a_i      >= op_b_i   );
        endcase
    end
end

assign branch_hit_o = branch_hit;

endmodule
