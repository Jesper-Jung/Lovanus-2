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
//  * Module Name   : u_data_mem_ctrl
//  * Author        : Jesper
//  * Purpose       : Execute memory operations to control the data memory pins
//
//  ! Notice (26.09.25)
//      |   The bus interface used for this memory controller module is developed 
//      |   with a protocol similar to AHB, but there's not a phase which means
//      |   an address and data are in the same time.
//      |   This will be updated for AHB or AXI bus protocol completely.
//
//=================================================================* * * * *---*

module data_mem_ctrl #(
     parameter  MEM_DEPTH_W = 7
     
    ,parameter  XLEN        = 32
    ,parameter  DATA_W      = 32
) (
     input                          clk_i
    ,input                          rst_ni

    ,input                          ctrl_MemWrite_i
    ,input                          ctrl_MemRead_i
    ,input              [XLEN-1:0]  haddr_i
    ,input                   [2:0]  hsize_i
    ,input              [XLEN-1:0]  hwdata_i
    ,output             [XLEN-1:0]  hrdata_o
    ,output                         hreadyout_o

    ,output                         mem_cs_o
    ,output                         mem_write_en_o
    ,output      [MEM_DEPTH_W-1:0]  mem_addr_o
    ,output           [DATA_W-1:0]  mem_wdata_o
    ,input            [DATA_W-1:0]  mem_rdata_i
);

localparam ADDR_LSB_W = 2;





assign mem_cs_o             = ctrl_MemWrite_i | ctrl_MemRead_i;
assign mem_write_en_o       = ctrl_MemWrite_i ;
assign mem_addr_o           = haddr_i[ADDR_LSB_W +: MEM_DEPTH_W];




endmodule