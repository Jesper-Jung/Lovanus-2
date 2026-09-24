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
//  * Module Name   : u_inst_mem
//  * Author        : Jesper
//  * Purpose       :
//
//  * Note
//      |   See '2.3 Immediate encoding variant' of the RISC-V unpriviliged document.  
//
//  * Reference
//
//=================================================================* * * * *---*

module inst_mem #(
     parameter              DEPTH_W     = 7

    ,parameter              ADDR_W      = 32
    ,parameter              DATA_W      = 32
) (
     input     [ADDR_W-1:0] raddr_i
    ,output    [DATA_W-1:0] rdata_o
);

localparam DEPTH        = (1 << DEPTH_W);
localparam ADDR_LSB_W   = 2;

reg [DATA_W-1:0] r_mem [0:DEPTH-1];
initial begin
    for (integer i = 0; i < DEPTH; i++)
        r_mem = {DATA_W{1'b0}};
end

wire [DEPTH_W-1:0] raddr_row;

assign raddr_row    = raddr_i[ADDR_LSB_W +: DEPTH_W];

//==============================================================================
// Memory Logic
//-------------------------------------------------------------------------*-*-*

assign rdata_o      = r_mem[raddr_row];

endmodule
