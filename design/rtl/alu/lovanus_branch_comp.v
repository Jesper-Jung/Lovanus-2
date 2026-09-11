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
//  * Module Name   : u_lovanus_branch_comp
//  * Author        : Jesper
//  * Purpose       : Decide if the current branch is taken or not
//
//  * Note
//      |   This comparator is independent module of the ALU core.
//          The ALU core calculates branch address as pc + offset.
//
//=================================================================* * * * *---*

module lovanus_branch_comp #(
     parameter                  XLEN        = 32

    ,parameter                  ALU_OP_W    = 2
    ,parameter                  FUNCT3_W    = 3
) (
     input           [XLEN-1:0] dec_rdata1_i
    ,input           [XLEN-1:0] dec_rdata2_i

    ,input       [ALU_OP_W-1:0] ctrl_Branch_i
    ,input       [FUNCT3_W-1:0] funct3_i

    ,output                     branch_taken_o
);

`include "lovanus_funct_params.vh"

wire signed [XLEN-1:0] rdata1_sgn;
wire signed [XLEN-1:0] rdata2_sgn;

reg branch_taken;

assign rdata1_sgn = dec_rdata1_i;
assign rdata2_sgn = dec_rdata2_i;

always @(*) begin
    branch_taken = 1'b0;
    if (ctrl_Branch_i) begin
        case (funct3_i)
            F3_BEQ      : branch_taken = (dec_rdata1_i == dec_rdata2_i );
            F3_BNE      : branch_taken = (dec_rdata1_i != dec_rdata2_i );
            F3_BLT      : branch_taken = (rdata1_sgn   <  rdata2_sgn   );
            F3_BGE      : branch_taken = (rdata1_sgn   >= rdata2_sgn   );
            F3_BLTU     : branch_taken = (dec_rdata1_i <  dec_rdata2_i );
            F3_BGEU     : branch_taken = (dec_rdata1_i >= dec_rdata2_i );
        endcase
    end
end

assign branch_taken_o = branch_taken;

endmodule
