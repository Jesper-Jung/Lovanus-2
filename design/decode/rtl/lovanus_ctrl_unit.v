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
//      | 1. doc/RISC-V_RV32I_inst_set.png
//
//=================================================================* * * * *---*

module lovanus_ctrl_unit #(
     parameter      XLEN        = 32
    ,parameter      ALUOP_W     = 4
) (
     input                  instruction_i

    ,output                 ctrl_Branch_o
    ,output                 ctrl_MemRead_o
    ,output                 ctrl_MemtoReg_o
    ,output  [ALUOP_W-1:0]  ctrl_ALUOp_o
    ,output                 ctrl_MemWrite_o
    ,output                 ctrl_ALUSrc_o
    ,output                 ctrl_RegWrite_o

    ,output                 ctrl_AUIPC_o
    ,output                 ctrl_JAL_o
    ,output                 ctrl_JALr_o
    ,output                 ctrl_LUI_o
);

`include    "lovanus_alu_op_params.vh"
`include    "lovanus_funct_params.vh"

wire          [6:0] opcode;
wire          [6:0] funct7;
wire          [2:0] funct3;

reg                 Branch;     // PC
reg                 RegWrite;   // Dec
reg   [ALUOP_W-1:0] ALUOp;      // Exe, Control signals for ALU controller
reg                 ALUSrc;     // Exe
reg                 MemRead;    // Mem
reg                 MemWrite;   // Mem
reg                 MemtoReg;   // Mem
reg                 AUIPC;      // Inst
reg                 JAL;        // Inst
reg                 JALr;       // Inst
reg                 LUI;        // Inst

//==============================================================================
// Wire Assigning
//-------------------------------------------------------------------------*-*-*

assign opcode = instruction_i[ 6: 0];
assign funct7 = instruction_i[31:25];
assign funct3 = instruction_i[14:12];

//==============================================================================
// Decoder Stage
//-------------------------------------------------------------------------*-*-*
// RegWrite
//-------------------------------------------------------------------------*-*-*

//==============================================================================
// Execute Stage
//-------------------------------------------------------------------------*-*-*
// ALUOp, ALUSrc
//-------------------------------------------------------------------------*-*-*
/*
    ALUOp ----
*/

/*
    ALUSrc ----
*/

//==============================================================================
// Memory Stage
//-------------------------------------------------------------------------*-*-*
// MemRead, MemWrite, MemtoReg
//-------------------------------------------------------------------------*-*-*


//==============================================================================
// Instruction Specific for Signal Muxing
//-------------------------------------------------------------------------*-*-*
// AUIPC, JAL, JALr, LUI
//-------------------------------------------------------------------------*-*-*



endmodule

// always @(*) begin
//     casez ({opcode, funct7, funct3})
//         {OPCODE_U_LUI,      7'b???????, 3'b???  }:
//         {OPCODE_U_AUIPC,    7'b???????, 3'b???  }:
//         {OPCODE_J_JAL,      7'b???????, 3'b???  }:

//         {OPCODE_B_TYPE,     7'b???????, F3_BEQ }:
//         {OPCODE_B_TYPE,     7'b???????, F3_BNE }:
//         {OPCODE_B_TYPE,     7'b???????, F3_BLT }:
//         {OPCODE_B_TYPE,     7'b???????, F3_BGE }:
//         {OPCODE_B_TYPE,     7'b???????, F3_BLTU}:
//         {OPCODE_B_TYPE,     7'b???????, F3_BGEU}:

//         {OPCODE_I_JALR,     7'b???????, F3_JALR }:

//         {OPCODE_I_LOAD,     7'b???????, F3_LB   }:
//         {OPCODE_I_LOAD,     7'b???????, F3_LH   }:
//         {OPCODE_I_LOAD,     7'b???????, F3_LW   }:
//         {OPCODE_I_LOAD,     7'b???????, F3_LBU  }:
//         {OPCODE_I_LOAD,     7'b???????, F3_LHU  }:

//         {OPCODE_I_ARITH,    7'b???????, F3_ADDI }:
//         {OPCODE_I_ARITH,    7'b???????, F3_SLTI }:
//         {OPCODE_I_ARITH,    7'b???????, F3_SLTIU}:
//         {OPCODE_I_ARITH,    7'b???????, F3_XORI }:
//         {OPCODE_I_ARITH,    7'b???????, F3_ORI  }:
//         {OPCODE_I_ARITH,    7'b???????, F3_ANDI }:

//         {OPCODE_S_TYPE,     7'b???????, F3_SB   }:
//         {OPCODE_S_TYPE,     7'b???????, F3_SH   }:
//         {OPCODE_S_TYPE,     7'b???????, F3_SW   }:

//         {OPCODE_I_SHIFT,    F7_SLLI,    F3_SLLI }:
//         {OPCODE_I_SHIFT,    F7_SRLI,    F3_SRLI }:
//         {OPCODE_I_SHIFT,    F7_SRAI,    F3_SRAI }:

//         {OPCODE_R_ARITH,    F7_ADD,     F3_ADD  }:
//         {OPCODE_R_ARITH,    F7_SUB,     F3_SUB  }:
//         {OPCODE_R_ARITH,    F7_SLL,     F3_SLL  }:
//         {OPCODE_R_ARITH,    F7_SLT,     F3_SLT  }:
//         {OPCODE_R_ARITH,    F7_SLTU,    F3_SLTU }:
//         {OPCODE_R_ARITH,    F7_XOR,     F3_XOR  }:
//         {OPCODE_R_ARITH,    F7_SRL,     F3_SRL  }:
//         {OPCODE_R_ARITH,    F7_SRA,     F3_SRA  }:
//         {OPCODE_R_ARITH,    F7_OR,      F3_OR   }:
//         {OPCODE_R_ARITH,    F7_AND,     F3_AND  }:
//     endcase
// end
