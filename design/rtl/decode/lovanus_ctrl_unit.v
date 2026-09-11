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
//  * Purpose       : Generate control signal following instruction
//
//  * Note          :
//      | Each control signals generates depending on the opcode.
//      | Control Signal Look-up Table ----
//
//      INST        ALUOp       ALUSrcPC ALUSrcImm      Branch  Jump
//      R-ARITH     arith       0       0               0       0
//      I-ARITH     arith       0       1               0       0
//      I-LOAD      default     0       1               0       0
//      I-JALR      default     0       1               0       1
//      S-STORE     default     0       1               0       0
//      B-BRANCH    branch      1       1               1       0
//      J-JAL       default     1       1               0       1
//      U-LUI       default     0       1               0       0
//      U-AUIPC     default     1       1               0       0
//      
//      INST        MemRead MemWrite    RegWrite    MemtoReg LinktoReg
//      R-ARITH     0       0           1           0        0
//      I-ARITH     0       0           1           0        0
//      I-LOAD      1       0           1           1        0
//      I-JALR      0       0           1           0        1
//      S-STORE     0       1           0           0        0
//      B-BRANCH    0       0           0           0        0
//      J-JAL       0       0           1           0        1
//      U-LUI       0       0           1           0        0
//      U-AUIPC     0       0           1           0        0
//=================================================================* * * * *---*

module lovanus_ctrl_unit #(
     parameter              XLEN        = 32

    ,parameter              ALUOP_W     = 2
    ,parameter              OPCODE_W    = 7
) (
     input   [OPCODE_W-1:0] opcode_i;

    ,output   [ALUOP_W-1:0] ctrl_ALUOp_o        // Select ALU operation
    ,output                 ctrl_ALUSrcPC_o     // Mux rs1 and pc 
    ,output                 ctrl_ALUSrcImm_o    // Mux rs2 and imm_ext
    ,output                 ctrl_MemRead_o      // Validate to read from the Data Memory
    ,output                 ctrl_MemWrite_o     // Validate to write rs2 on the Data Memory
    ,output                 ctrl_MemtoReg_o     // Select rdata from the Data Memory to write back
    ,output                 ctrl_LinktoReg_o    // Select pc+4 to write back
    ,output                 ctrl_Branch_o       // Validate to branch conditional jump PC
    ,output                 ctrl_Jump_o         // Validate to jump PC
    ,output                 ctrl_RegWrite_o     // Validate to write back on the regfile
);

`include    "lovanus_alu_params.vh"

reg   [ALUOP_W-1:0] ALUOp;
reg                 ALUSrcPC;
reg                 ALUSrcImm;
reg                 MemRead;
reg                 MemWrite;
reg                 MemtoReg;
reg                 LinktoReg;
reg                 Branch;
reg                 Jump;
reg                 RegWrite;

always @(*) begin
    ALUOp       = ALUOP_DEFAULT;
    ALUSrcPC    = 1'b0;
    ALUSrcImm   = 1'b0;
    Branch      = 1'b0;
    Jump        = 1'b0;
    MemRead     = 1'b0;
    MemWrite    = 1'b0;
    RegWrite    = 1'b0;
    MemtoReg    = 1'b0;
    LinktoReg   = 1'b0;

    case (opcode_i)
        OPCODE_R_ARITH: begin
            ALUOp     = ALUOP_ARITH;
            RegWrite  = 1'b1;
        end

        OPCODE_I_ARITH: begin
            ALUOp     = ALUOP_ARITH;
            ALUSrcImm = 1'b1;
            RegWrite  = 1'b1;
        end

        OPCODE_I_LOAD: begin
            ALUSrcImm = 1'b1;
            MemRead   = 1'b1;
            RegWrite  = 1'b1;
            MemtoReg  = 1'b1;
        end

        OPCODE_S_STORE: begin
            ALUSrcImm = 1'b1;
            MemWrite  = 1'b1;
        end

        OPCODE_B_BRANCH: begin
            ALUOp     = ALUOP_BRANCH;
            ALUSrcPC  = 1'b1;
            ALUSrcImm = 1'b1;
            Branch    = 1'b1;
        end

        OPCODE_J_JAL: begin
            ALUSrcPC  = 1'b1;
            ALUSrcImm = 1'b1;
            Jump      = 1'b1;
            RegWrite  = 1'b1;
            LinktoReg = 1'b1;
        end

        OPCODE_I_JALR: begin
            ALUSrcImm = 1'b1;
            Jump      = 1'b1;
            RegWrite  = 1'b1;
            LinktoReg = 1'b1;
        end

        OPCODE_U_LUI: begin
            ALUSrcImm = 1'b1;
            RegWrite  = 1'b1;
        end

        OPCODE_U_AUIPC: begin
            ALUSrcPC  = 1'b1;
            ALUSrcImm = 1'b1;
            RegWrite  = 1'b1;
        end
    endcase
end

assign ctrl_ALUOp_o         = ALUOp;
assign ctrl_ALUSrcPC_o      = ALUSrcPC;
assign ctrl_ALUSrcImm_o     = ALUSrcImm;
assign ctrl_MemRead_o       = MemRead;
assign ctrl_MemWrite_o      = MemWrite;
assign ctrl_MemtoReg_o      = MemtoReg;
assign ctrl_LinktoReg_o     = LinktoReg;
assign ctrl_Branch_o        = Branch;
assign ctrl_Jump_o          = Jump;
assign ctrl_RegWrite_o      = RegWrite;

endmodule
