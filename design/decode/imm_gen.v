//=================================================================* * * * *---*
//
//     +                       +                                 +    
//    .         .         .        +          .          .         .         + .
// .    *       * *.  *      * **    **    * *    *   . * .   . *  .       .       
//      .      .    \  .    / .  \   . \   . .     \ *       +      *        . 
//  .   *     *      * *   *  * + *  *  *  * *      *  *    ---    *    .           .
//       .     \    .   . /  .     \  .   \ . \     .     *      *         .      .
// .     * -- *  * *     *   *      * *    **   *  *   *      +       *       .      .
//   .         .         .          .          .          .          + Lovanus-2 +  .
//             +                   +                      +                   +   
//
//  * Module Name   : u_imm_gen
//  * Author        : Jesper
//  * Purpose       : Extend immediate from instruction
//
//  * Note          :
//      | See '2.3 Immediate encoding variant' of the RISC-V unpriviliged document.  
//      | RV32I Base Inst set,
//          R-TYPE      // SLLI, SRLI, SRAI, ADD, SUB, SLL, SLT, SLTU, XOR, SLR, SRA, OR, AND
//          I-TYPE      // JALR, LW, ADDI, SLTI, SLTIU, XORI, ORI, ANDI
//          S-TYPE      // SW
//          B-TYPE      // BEQ, BNE, BGE, BLTU, BGEU
//          U-TYPE      // LUI, AUIPC
//          J-TYPE      // JAL
//          etc         // FENCE, ECALL, EBREAK
//
//  * Reference     :
//
//=================================================================* * * * *---*

module imm_gen #(
     parameter      DATA_W   = 32
) (
     input     [DATA_W-1:0] instruction_i
    ,output    [DATA_W-1:0] imm_ext_o
);

`include "lovanus_opcode_params.vh"

localparam OPCODE_W     = 7;

wire [OPCODE_W-1:0] opcode;
wire                sign_msb;

reg    [DATA_W-1:0] imm_ext;
reg                 imm_I_match;
reg                 imm_S_match;
reg                 imm_B_match;
reg                 imm_U_match;
reg                 imm_J_match;

//==============================================================================
// Instruction Type Match
//-------------------------------------------------------------------------*-*-*

assign opcode = instruction_i[0 +: OPCODE_W];

always @(*) begin
    imm_I_match = 1'b0;
    imm_S_match = 1'b0;
    imm_B_match = 1'b0;
    imm_U_match = 1'b0;
    imm_J_match = 1'b0;

    (* parallel_case *) case (opcode)
        OPCODE_I_JALR, OPCODE_I_LW, OPCODE_I_ARITH  : imm_I_match = 1'b1;
        OPCODE_S_SW                                 : imm_S_match = 1'b1;
        OPCODE_B_TYPE                               : imm_B_match = 1'b1;
        OPCODE_U_LUI, OPCODE_U_AUIPC                : imm_U_match = 1'b1;
        OPCODE_J_JAL                                : imm_J_match = 1'b1;
        default                                     : ;
    endcase
end

//==============================================================================
// Immediate Extension
//-------------------------------------------------------------------------*-*-*

assign sign_msb = instruction_i[31];

always @(*) begin
    (* parallel_case *) case (1'b1)
        imm_I_match : imm_ext = {{20{sign_msb}}, instruction_i[31:20]};
        imm_S_match : imm_ext = {{20{sign_msb}}, instruction_i[31:25], instruction_i[11:7]};
        imm_B_match : imm_ext = {{20{sign_msb}}, instruction_i[7], instruction_i[30:25], instruction_i[11:8], 1'b0};
        imm_U_match : imm_ext = {instruction_i[31:12], 12'h0};
        imm_J_match : imm_ext = {{12{sign_msb}}, instruction_i[19:12], instruction_i[20], instruction_i[30:21], 1'b0};
        default     : imm_ext = 32'h0;
    endcase
end

assign imm_ext_o = imm_ext;

endmodule
