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
//  * Module Name   : u_lovanus_alu_ctrl
//  * Author        : Jesper
//  * Purpose       : Calculate with ~~~.
//
//  * Note          :
//      | ALUOp <--> alu_ctrl   relation list
//
//          ALUOp       mnemonic            alu_ctrl_o
//          00          Default             4'b0010 (ADD)
//          01          Branch (B-type)     4'b0110 (SUB)
//          10          ADD                 
//          10          SUB                 
//          10          SLL                 
//          10          SLT                 
//          10          SLTU                
//          10          XOR                 
//          10          SRL                 
//          10          SRA                 
//          10          OR                  
//          10          AND                 
//
//=================================================================* * * * *---*

module lovanus_alu_ctrl #(
     parameter                  XLEN        = 32

    ,parameter                  ALUOP_W     = 2
    ,parameter                  ALU_CTRL_W  = 4
) (
     input           [XLEN-1:0] instr_i
    ,input        [ALUOP_W-1:0] ctrl_ALUOp_i

    ,output    [ALU_CTRL_W-1:0] alu_ctrl_o
);

`include "lovanus_alu_params.vh"

//==============================================================================
// ALU Combinational Logic
//-------------------------------------------------------------------------*-*-*

reg [ALU_CTRL_W-1:0] alu_ctrl;

always @(*) begin
    alu_ctrl = ALU_CTRL_ADD;

    if      ( ctrl_ALUOP_i == 2'b00 ) alu_ctrl = ALU_CTRL_ADD;
    else if ( ctrl_ALUOP_i == 2'b01 ) alu_ctrl = ALU_CTRL_SUB;
    else if ( ctrl_ALUOP_i == 2'b10 ) begin
        case ({funct7_i, funct3_i})
            ADD     : alu_ctrl = ALU_CTRL_ADD;
            SUB     : alu_ctrl = ALU_CTRL_SUB;
            SLL     : alu_ctrl = ALU_CTRL_SLL;
            SLT     : alu_ctrl = ALU_CTRL_SLT;
            SLTU    : alu_ctrl = ALU_CTRL_SLTU;
            XOR     : alu_ctrl = ALU_CTRL_XOR;
            SRL     : alu_ctrl = ALU_CTRL_SRL;
            SRA     : alu_ctrl = ALU_CTRL_SRA;
            OR      : alu_ctrl = ALU_CTRL_OR;
            AND     : alu_ctrl = ALU_CTRL_AND;
        endcase
    end
end

assign alu_ctrl_o = alu_ctrl;

endmodule
