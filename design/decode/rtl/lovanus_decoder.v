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
//  * Module Name   : u_lovanus_decoder
//  * Author        : Jesper
//  * Purpose       : Read operands from the register file and
//  *                 generate control signals to execute the instruction.
//
//  * Note          :
//      |   The RISC-V Register file is placed outside of this module
//          since of the convenience.
//
//=================================================================* * * * *---*

module lovanus_decoder #(
     parameter              XLEN        = 32

    ,parameter              ALUOP_W     = 2
    ,parameter              OPCODE_W    = 7
    ,parameter              FUNCT7_W    = 7
    ,parameter              FUNCT3_W    = 3
) (
    //--------------------------------------
    // ## Decoder Main ##

    ,input       [XLEN-1:0] instr_i

    ,output      [XLEN-1:0] rdata1_o
    ,output      [XLEN-1:0] rdata2_o

    ,output      [XLEN-1:0] imm_ext_o

    ,output   [ALUOP_W-1:0] ctrl_ALUOp_o
    ,output                 ctrl_ALUSrc1_o
    ,output                 ctrl_ALUSrc2_o
    ,output                 ctrl_MemRead_o
    ,output                 ctrl_MemWrite_o
    ,output                 ctrl_MemtoReg_o
    ,output                 ctrl_LinktoReg_o
    ,output                 ctrl_JumpB_o
    ,output                 ctrl_JumpJ_o
    ,output                 ctrl_RegWrite_o

    //--------------------------------------
    // ## Register File, 1w2r ##

    ,output                 rd_o
    ,output                 rs1_o
    ,output                 rs2_o

    ,input       [XLEN-1:0] rdata1_i
    ,input       [XLEN-1:0] rdata2_i
);

wire [OPCODE_W-1:0] opcode;
wire [FUNCT7_W-1:0] funct7;
wire [FUNCT3_W-1:0] funct3;

//==============================================================================
// Register File Interface
//-------------------------------------------------------------------------*-*-*

assign rd_o         = instr_i[11:7];
assign rs1_o        = instr_i[19:15];
assign rs2_o        = instr_i[24:20];

assign rdata1_o     = rdata1_i;
assign rdata2_o     = rdata2_i;

assign opcode       = instr_i[0 +: OPCODE_W];
assign funct7       = instr_i[0 +: FUNCT7_W];
assign funct3       = instr_i[0 +: FUNCT3_W];

//==============================================================================
// Imm Gen
//-------------------------------------------------------------------------*-*-*

lovanus_imm_gen #(
     .XLEN              ( XLEN              )
) u_lovanus_imm_gen (
     .opcode_i          ( opcode            )

    ,.imm_ext_o         ( imm_ext_o         )
);

//==============================================================================
// Control Unit
//-------------------------------------------------------------------------*-*-*

lovanus_ctrl_unit #(
     .XLEN              ( XLEN              )
) u_lovanus_ctrl_unit (
     .opcode_i          ( opcode            )
    ,.funct7_i          ( funct7            )
    ,.funct3_i          ( funct3            )

    ,.ctrl_ALUOp_o      ( ctrl_ALUOp_o      )
    ,.ctrl_ALUSrc1_o    ( ctrl_ALUSrc1_o    )
    ,.ctrl_ALUSrc2_o    ( ctrl_ALUSrc2_o    )
    ,.ctrl_MemRead_o    ( ctrl_MemRead_o    )
    ,.ctrl_MemWrite_o   ( ctrl_MemWrite_o   )
    ,.ctrl_MemtoReg_o   ( ctrl_MemtoReg_o   )
    ,.ctrl_LinktoReg_o  ( ctrl_LinktoReg_o  )
    ,.ctrl_JumpB_o      ( ctrl_JumpB_o      )
    ,.ctrl_JumpJ_o      ( ctrl_JumpJ_o      )
    ,.ctrl_RegWrite_o   ( ctrl_RegWrite_o   )
);

endmodule
