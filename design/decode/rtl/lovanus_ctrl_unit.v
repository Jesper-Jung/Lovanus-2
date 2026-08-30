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
//  * Module Name   : u_lovanus_ctrl_unit
//  * Author        : Jesper
//  * Purpose       :
//
//  * Note          :
//      | See '2.3 Immediate encoding variant' of the RISC-V unpriviliged document.  
//
//  * Reference     :
//
//=================================================================* * * * *---*

module lovanus_ctrl_unit #(
     parameter      XLEN        = 32
    ,parameter      ALUOP_W     = 4
) (
     input                  instruction_i

    ,output                 ctrl_Branch
    ,output                 ctrl_MemRead
    ,output                 ctrl_MemtoReg
    ,output  [ALUOP_W-1:0]  ctrl_ALUOp
    ,output                 ctrl_MemWrite
    ,output                 ctrl_ALUSrc
    ,output                 ctrl_RegWrite

    ,output                 ctrl_AUIPC
    ,output                 ctrl_JAL
    ,output                 ctrl_JALr
    ,output                 ctrl_LUI
);

`include    "lovanus_alu_op.vh"

wire          [6:0] opcode;
wire          [6:0] funct7;
wire          [2:0] funct3;

reg                 Branch;  
reg                 MemRead; 
reg                 MemtoReg;
reg   [ALUOP_W-1:0] ALUOp;          // Control signals for ALU controller
reg                 MemWrite;
reg                 ALUSrc;  
reg                 RegWrite;
reg                 AUIPC;   
reg                 JAL;     
reg                 JALr;    
reg                 LUI;     

//==============================================================================
// Wire Assigning
//-------------------------------------------------------------------------*-*-*

assign opcode = instruction_i[ 6: 0];
assign funct7 = instruction_i[31:25];
assign funct3 = instruction_i[14:12];

//==============================================================================
// ALU calculation unit
//-------------------------------------------------------------------------*-*-*
/*
    ALUOp ----
*/
always @(*) begin
    case ({funct7, funct3, opcode})
        
    endcase
end




endmodule
