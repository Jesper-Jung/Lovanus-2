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
//  * Module Name   : u_lovanus_wb_formatter
//  * Author        : Jesper
//  * Purpose       : Calculate next value of PC
//
//  * Note          :
//      |   - JumpB, control signal
//          
//
//      |   - JumpJ, control signal
//
//=================================================================* * * * *---*

module lovanus_wb_formatter #(
     parameter              XLEN    = 32
) (
     input       [XLEN-1:0] alu_result_i                    // default
    ,input       [XLEN-1:0] mem_rdata_i                     // If MemtoReg
    ,input       [XLEN-1:0] pc_plus4_i                      // If LinktoReg

    ,input                  ctrl_MemtoReg_i
    ,input                  mctrl_ZeroExt_i       //    Receive from mem_ctrl which module will be updated later
    ,input            [2:0] mctrl_DataSize_i      //    Receive from mem_ctrl which module will be updated later
    ,input            [1:0] addr_offset_i           // Receive from alu result port
    
    ,input                  ctrl_LinktoReg_i

    ,output      [XLEN-1:0] regf_wdata_o
);

localparam  HSIZE_BYTE          = 3'b000,
            HSIZE_HALFWORD      = 3'b001,
            HSIZE_WORD          = 3'b010;

reg [XLEN-1:0] mem_rdata_fmt;

//==============================================================================
// Read Data Formatting from Memory
//-------------------------------------------------------------------------*-*-*

always @(*) begin
    casez ({mctrl_DataSize_i, mctrl_ZeroExt_i, addr_offset_i})
        {HSIZE_BYTE, 1'b0, 2'b00}       : mem_rdata_fmt = {24{1'b0}, mem_rdata_i[7:0]};
        {HSIZE_BYTE, 1'b0, 2'b01}       : mem_rdata_fmt = {24{1'b0}, mem_rdata_i[15:8]};
        {HSIZE_BYTE, 1'b0, 2'b10}       : mem_rdata_fmt = {24{1'b0}, mem_rdata_i[23:16]};
        {HSIZE_BYTE, 1'b0, 2'b11}       : mem_rdata_fmt = {24{1'b0}, mem_rdata_i[31:24]};
        {HSIZE_BYTE, 1'b1, 2'b00}       : mem_rdata_fmt = {24{mem_rdata_i[7]}, mem_rdata_i[7:0]};
        {HSIZE_BYTE, 1'b1, 2'b01}       : mem_rdata_fmt = {24{mem_rdata_i[15]}, mem_rdata_i[15:8]};
        {HSIZE_BYTE, 1'b1, 2'b10}       : mem_rdata_fmt = {24{mem_rdata_i[23]}, mem_rdata_i[23:16]};
        {HSIZE_BYTE, 1'b1, 2'b11}       : mem_rdata_fmt = {24{mem_rdata_i[31]}, mem_rdata_i[31:24]};

        {HSIZE_HALFWORD, 1'b0, 2'b0z}   : mem_rdata_fmt = {16{1'b0}, mem_rdata_i[15:0]};
        {HSIZE_HALFWORD, 1'b0, 2'b1z}   : mem_rdata_fmt = {16{1'b0}, mem_rdata_i[31:16]};
        {HSIZE_HALFWORD, 1'b1, 2'b0z}   : mem_rdata_fmt = {16{mem_rdata_i[15]}, mem_rdata_i[15:0]};
        {HSIZE_HALFWORD, 1'b1, 2'b1z}   : mem_rdata_fmt = {16{mem_rdata_i[31]}, mem_rdata_i[31:16]};

        {HSIZE_WORD, 1'bz, 2'bzz}       : mem_rdata_fmt = mem_rdata_i;

        default                         : mem_rdata_fmt = mem_rdata_i;
    endcase
end

// Assign
assign regf_wdata_o = ( ctrl_LinktoReg_i    ) ? pc_plus4_i      :
                      ( ctrl_MemtoReg_i     ) ? mem_rdata_fmt   : alu_result_i;

endmodule
