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
//  * Reference
//      1. [Hazard3] hazard3_core.v
//=================================================================* * * * *---*

module data_mem_ctrl #(
     parameter  MEM_DEPTH_W = 7
     
    ,parameter  XLEN        = 32
    ,parameter  DATA_W      = XLEN
    ,parameter  BYTES_W     = 4
) (
     input                          ctrl_MemWrite_i
    ,input                          ctrl_MemRead_i
    ,input              [XLEN-1:0]  haddr_i
    ,input                   [2:0]  hsize_i
    ,input              [XLEN-1:0]  hwdata_i
    ,output             [XLEN-1:0]  hrdata_o
    ,output                         hreadyout_o

    ,output                         mem_cs_o
    ,output                         mem_write_en_o
    ,output          [BYTES_W-1:0]  mem_byte_en_o
    ,output      [MEM_DEPTH_W-1:0]  mem_addr_o
    ,output           [DATA_W-1:0]  mem_wdata_o
    ,input            [DATA_W-1:0]  mem_rdata_i
);

localparam  ADDR_LSB_W          = 2;

localparam  HSIZE_BYTE          = 3'b000,
            HSIZE_HALFWORD      = 3'b001,
            HSIZE_WORD          = 3'b010;

wire [MEM_DEPTH_W-1:0]  haddr_row;
wire [ADDR_LSB_W-1:0]   haddr_offset;

reg  [BYTES_W-1:0]      mwrite_mask;
reg  [DATA_W-1:0]       mwdata_fmt;

//==============================================================================
// Generate control signal
//-------------------------------------------------------------------------*-*-*

assign haddr_row    = haddr_i[ADDR_LSB_W +: MEM_DEPTH_W];
assign haddr_offset = haddr_i[ADDR_LSB_W - 1 : 0];

//==============================================================================
// Generate Write Byte Enable Mask
//-------------------------------------------------------------------------*-*-*

always @(*) begin
    mwrite_mask = {BYTES_W{1'b0}};

    casez ({hsize_i, haddr_offset})
        {HSIZE_BYTE     , 2'b00}: mwrite_mask = 4'b0001;
        {HSIZE_BYTE     , 2'b01}: mwrite_mask = 4'b0010; 
        {HSIZE_BYTE     , 2'b10}: mwrite_mask = 4'b0100;
        {HSIZE_BYTE     , 2'b11}: mwrite_mask = 4'b1100;
        {HSIZE_HALFWORD , 2'b0z}: mwrite_mask = 4'b0011;
        {HSIZE_HALFWORD , 2'b1z}: mwrite_mask = 4'b1100;
        {HSIZE_WORD     , 2'bzz}: mwrite_mask = 4'b1111;
        default                 : mwrite_mask = 4'bxxxx;
    endcase
end

//==============================================================================
// Format Memory wdata
//-------------------------------------------------------------------------*-*-*

always @(*) begin
    case (hsize_i)
        HSIZE_BYTE      : mwdata_fmt = {4{hwdata_i[ 7:0]}};
        HSIZE_HALFWORD  : mwdata_fmt = {2{hwdata_i[15:0]}};
        HSIZE_WORD      : mwdata_fmt = hwdata_i;
        default         : mwdata_fmt = hwdata_i;
    endcase
end

//==============================================================================
// Output Data
//-------------------------------------------------------------------------*-*-*

assign hreadyout_o          =  1'b1;
assign hrdata_o             =  mem_rdata_i;

assign mem_cs_o             = (ctrl_MemWrite_i | ctrl_MemRead_i);
assign mem_write_en_o       =  ctrl_MemWrite_i ;
assign mem_byte_en_o        =  mwrite_mask;
assign mem_addr_o           =  haddr_i[ADDR_LSB_W +: MEM_DEPTH_W];
assign mem_wdata_o          =  mwdata_fmt;

endmodule
