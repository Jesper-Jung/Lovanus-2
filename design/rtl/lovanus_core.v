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
//  * Module Name   : u_lovanus_mux_pc_next
//  * Author        : Jesper
//  * Purpose       : Calculate next value of PC
//
//  * Note          :
//      |   - JumpB, control signal
//          
//
//      |   - JumpJ, control signal
//
//  * Reference     :
//
//=================================================================* * * * *---*

module u_lovanus_core #(
     parameter              XLEN        = 32

    ,parameter              ALUOP_W     = 2
    ,parameter              FUNCT7_W    = 7
    ,parameter              FUNCT3_W    = 3
) (
     input                  clk_i
    ,input                  rst_ni
);

//==============================================================================
// ALU Controller
//-------------------------------------------------------------------------*-*-*

wire         [XLEN-1:0] instr;

wire         [XLEN-1:0] pc;
wire         [XLEN-1:0] pc_plus4;
wire         [XLEN-1:0] pc_next_muxed;

wire              [4:0] regf_rd;
wire         [XLEN-1:0] regf_wdata_muxed;
wire              [4:0] regf_rs1;
wire         [XLEN-1:0] regf_rdata1;
wire              [4:0] regf_rs2;
wire         [XLEN-1:0] regf_rdata2;

wire         [XLEN-1:0] alu_result;
wire         [XLEN-1:0] mem_rdata;
wire         [XLEN-1:0] pc_plus4;

wire      [ALUOP_W-1:0] ctrl_ALUOp;
wire                    ctrl_ALUSrc1;
wire                    ctrl_ALUSrc2;
wire                    ctrl_MemRead;
wire                    ctrl_MemWrite;
wire                    ctrl_MemtoReg;
wire                    ctrl_LinktoReg;
wire                    ctrl_Branch;
wire                    ctrl_Jump;
wire                    ctrl_RegWrite;

wire     [FUNCT7_W-1:0] funct7;
wire     [FUNCT3_W-1:0] funct3;

wire                    branch_taken;

wire         [XLEN-1:0] dec_rdata1;
wire         [XLEN-1:0] dec_rdata2;
wire         [XLEN-1:0] imm_ext;

//==============================================================================
// Instances
//-------------------------------------------------------------------------*-*-*

lovanus_pc u_lovanus_pc (
     .clk_i                     ( clk_i             )
    ,.rst_ni                    ( rst_ni            )

    ,.pc_next_i                 ( pc_next_muxed     )

    ,.pc_o                      ( pc                )
    ,.pc_plus4_o                ( pc_plus4          )
);

inst_mem u_inst_mem (
    ,.raddr                     ( pc                )
    ,.rdata                     ( instr             )
);

// Decode
lovanus_decoder u_lovanus_decoder (
     .instr_i                   ( instr             )

    ,.rdata1_o                  ( dec_rdata1        )
    ,.rdata2_o                  ( dec_rdata2        )

    ,.imm_ext_o                 ( imm_ext           )

    ,.ctrl_ALUOp_o              ( ctrl_ALUOp        )
    ,.ctrl_ALUSrc1_o            ( ctrl_ALUSrc1      )
    ,.ctrl_ALUSrc2_o            ( ctrl_ALUSrc2      )
    ,.ctrl_MemRead_o            ( ctrl_MemRead      )
    ,.ctrl_MemWrite_o           ( ctrl_MemWrite     )
    ,.ctrl_MemtoReg_o           ( ctrl_MemtoReg     )
    ,.ctrl_LinktoReg_o          ( ctrl_LinktoReg    )
    ,.ctrl_Branch_o             ( ctrl_Branch       )
    ,.ctrl_Jump_o               ( ctrl_Jump         )
    ,.ctrl_RegWrite_o           ( ctrl_RegWrite     )

    ,.funct7_o                  ( funct7            )
    ,.funct3_o                  ( funct3            )

    // Connect to Register File
    ,.rd_o                      ( regf_rd           )
    ,.rs1_o                     ( regf_rs1          )
    ,.rs2_o                     ( regf_rs2          )

    ,.rdata1_i                  ( regf_rdata1       )
    ,.rdata2_i                  ( regf_rdata2       )
);


lovanus_regf_1w2r u_lovanus_regf_1w2r (
     .clk_i                     ( clk_i             )
    ,.rst_ni                    ( rst_ni            )

    ,.write_en_i                ( ctrl_RegWrite     )
    ,.waddr_i                   ( regf_rd           )
    ,.wdata_i                   ( regf_wdata_muxed  )

    ,.raddr1_i                  ( regf_rs1          )
    ,.rdata1_o                  ( regf_rdata1       )

    ,.raddr2_i                  ( regf_rs2          )
    ,.rdata2_o                  ( regf_rdata2       )
);

// Execute
lovanus_alu u_lovanus_alu (
     .funct7_i                  ( funct7            )
    ,.funct3_i                  ( funct3            )

    ,.ctrl_ALUOp_i              ( ctrl_ALUOp        )
    ,.ctrl_ALUSrcPC_i           ( ctrl_ALUSrcPC     )
    ,.ctrl_ALUSrcImm_i          ( ctrl_ALUSrcImm    )
    ,.ctrl_Branch_i             ( ctrl_Branch       )

    ,.dec_rdata1_i              ( dec_rdata1        )
    ,.pc_i                      ( pc                )

    ,.dec_rdata2_i              ( dec_rdata2        )
    ,.imm_ext_i                 ( imm_ext           )

    ,.result_o                  ( alu_result        )
    ,.branch_taken_o            ( branch_taken      )
);

lovanus_mux_pc_next u_lovanus_mux_pc_next (
     .pc_plus4_i                ( pc_plus4          )
    ,.alu_result_i              ( alu_result        )

    ,.branch_taken_i            ( branch_taken      )
    ,.ctrl_Jump_i               ( ctrl_Jump         )

    ,.pc_next_o                 ( pc_next_muxed     )
);

// Memory
data_mem u_data_mem (
     .clk_i                     ( clk_i             )
    ,.rst_ni                    ( rst_ni            )

    ,.write_en_i                ( ctrl_MemWrite     )
    ,.read_en_i                 ( ctrl_MemRead      )

    ,.addr_i                    ( alu_result        )
    ,.wdata_i                   ( dec_rdata2        )
    ,.rdata_o                   ( mem_rdata         )
);

lovanus_mux_regf_wdata u_lovanus_mux_regf_wdata (
     .alu_result_i              ( alu_result        )
    ,.mem_rdata_i               ( mem_rdata         )
    ,.pc_plus4_i                ( pc_plus4          )

    ,.ctrl_MemtoReg_i           ( ctrl_MemtoReg     )
    ,.ctrl_LinktoReg_i          ( ctrl_LinktoReg    )

    ,.regf_wdata_o              ( regf_wdata_muxed  )
);

endmodule
