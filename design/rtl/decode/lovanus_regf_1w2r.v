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
//  * Module Name   : u_lovanus_regf_1w2r
//  * Author        : Jesper
//  * Purpose       : 
//
//  * Note          :
//      | This module will be updated with core pipelining.
//
//  * Reference     :
//      1. [Hazard3] hazard3_regfile_1w2r.v
//
//=================================================================* * * * *---*

module lovanus_regf_1w2r #(
     parameter                  XLEN         = 32
) (
     input                      clk_i
    ,input                      rst_ni
    ,input                      write_en_i

    ,input                [4:0] waddr_i
    ,input           [XLEN-1:0] wdata_i

    ,input                [4:0] raddr1_i
    ,output reg      [XLEN-1:0] rdata1_o

    ,input                [4:0] raddr2_i
    ,output reg      [XLEN-1:0] rdata2_o
);

localparam REG_NUM      = 32;

//==============================================================================
// 1w2r Register File
//-------------------------------------------------------------------------*-*-*

reg [XLEN-1:0] r_mem_regf   [0:REG_NUM-1];

always @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
        for (integer i = 0; i < REG_NUM; i++)
            r_mem_regf[i] <= {XLEN{1'b0}};
    end
    else begin
        if (write_en_i)
            r_mem_regf <= #1 wdata_i;
    end
end

always @(*) begin
    rdata1_o = r_mem_regf[raddr1_i];
    rdata2_o = r_mem_regf[raddr2_i];
end

//==============================================================================
// Debug Wiring
//-------------------------------------------------------------------------*-*-*

wire [XLEN-1:0] _debug_regf_sp = r_mem_regf[2];

endmodule
