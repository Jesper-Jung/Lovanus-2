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
     parameter              XLEN    = 32
) (
     input       [XLEN-1:0] pc_i
    ,input       [XLEN-1:0] imm_ext_i

    ,input                  branch_hit

    ,input                  ctrl_JumpB_i
    ,input                  ctrl_JumpJ_i

    ,output      [XLEN-1:0] pc_next_o
);

// Decode
lovanus_decoder u_lovanus_decoder (
     .instr_i               ()

    ,.rdata1_o              ()
    ,.rdata2_o              ()

    ,.imm_ext_o             ()

    ,.ctrl_ALUOp_o          ()
    ,.ctrl_ALUSrc1_o        ()
    ,.ctrl_ALUSrc2_o        ()
    ,.ctrl_MemRead_o        ()
    ,.ctrl_MemWrite_o       ()
    ,.ctrl_MemtoReg_o       ()
    ,.ctrl_LinktoReg_o      ()
    ,.ctrl_JumpB_o          ()
    ,.ctrl_JumpJ_o          ()
    ,.ctrl_RegWrite_o       ()

    ,.rd_o                  ()
    ,.rs1_o                 ()
    ,.rs2_o                 ()

    ,.rdata1_i              ()
    ,.rdata2_i              ()
);

// Execute
lovanus_alu u_lovanus_alu (

);

lovanus_mux_pc_next u_lovanus_mux_pc_next (

);

lovanus_mux_regf_wdata u_lovanus_mux_regf_wdata (

);


// Memory
lovanus_regf_1w2r u_lovanus_regf_1w2r (

);


endmodule
