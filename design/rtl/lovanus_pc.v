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
//  * Module Name   : u_lovanus_pc
//  * Author        : Jesper
//  * Purpose       :
//
//  * Note
//      |   See '2.3 Immediate encoding variant' of the RISC-V unpriviliged document.  
//
//  * Reference
//
//=================================================================* * * * *---*

module lovanus_pc #(
     parameter              XLEN        = 32
) (
     input                  clk_i
    ,input                  rst_ni

    ,input                  pc_next_i

    ,output                 pc_o
    ,output                 pc_plus4_o
);

reg [XLEN-1:0] pc_r;

always @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni ) pc_r <=    RESET_VECTOR;
    else          pc_r <= #1 pc_next_i;
end

assign pc_o         =  pc_r;
assign pc_plus_o    = (pc_r + 32'h4);

endmodule
