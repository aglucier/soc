module id_reg(
  input        cpu_clk,
  input        cpu_rstn,
  input [3:0]  alu_op,
  input [31:0] alu_in_0,
  input [31:0] alu_in_1,
  input        br_flag,
  input [1:0]  mem_op,
  input [31:0] mem_wdata,
  input [1:0]  ctrl_op,
  input [4:0]  dst_addr,
  input        gpr_wen,
  input [2:0]  exp_code,
  input        stall,
  input        flush,
  input [29:0] if_pc,
  input        if_en,
  output logic [29:0] id_pc,
  output logic        id_en,
  output logic [3:0]  id_alu_op,
  output logic [31:0] id_alu_in_0,
  output logic [31:0] id_alu_in_1,
  output logic        id_br_flag,
  output logic [1:0]  id_mem_op,
  output logic [31:0] id_mem_wdata,
  output logic [1:0]  id_ctrl_op,
  output logic [4:0]  id_dst_addr,
  output logic        id_gpr_wen,
  output logic [2:0]  id_exp_code,
);


  localparam ALU_OP_NOP     = 'h0;
  localparam MEM_OP_NOP     = 'h0;
  localparam CTRL_OP_NOP    = 'h0;
  localparam ISA_EXP_NO_EXP = 'h0;
  localparam ENABLEN        = 'h0;
  localparam DISENABLEN     = 'h1;


  always_ff @(posedge cpu_clk or negedge cpu_rstn) begin
    if(!cpu_rstn) begin
      id_pc        <= #1 'h0;
      id_en        <= #1 'h0;
      id_alu_op    <= #1 ALU_OP_NOP;
      id_alu_in_0  <= #1 'h0;
      id_alu_in_1  <= #1 'h0;
      id_br_flag   <= #1 'h0;
      id_mem_op    <= #1 MEM_OP_NOP;
      id_mem_wdata <= #1 'h0;
      id_ctrl_op   <= #1 CTRL_OP_NOP;
      id_dst_addr  <= #1 'h0;
      id_gpr_wen   <= #1 DISENABLEN;
      id_exp_code  <= #1 ISA_EXP_NO_EXP;
    end else if(stall) begin
      if(flush=='h1) begin
        id_pc        <= #1 'h0;
        id_en        <= #1 'h0;
        id_alu_op    <= #1 ALU_OP_NOP;
        id_alu_in_0  <= #1 'h0;
        id_alu_in_1  <= #1 'h0;
        id_br_flag   <= #1 'h0;
        id_mem_op    <= #1 MEM_OP_NOP;
        id_mem_wdata <= #1 'h0;
        id_ctrl_op   <= #1 CTRL_OP_NOP;
        id_dst_addr  <= #1 'h0;
        id_gpr_wen   <= #1 DISENABLEN;
        id_exp_code  <= #1 ISA_EXP_NO_EXP;
      end else begin
        id_pc        <= #1 if_pc;
        id_en        <= #1 if_en;
        id_alu_op    <= #1 alu_op;
        id_alu_in_0  <= #1 alu_in_0;
        id_alu_in_1  <= #1 alu_in_1;
        id_br_flag   <= #1 br_flag;
        id_mem_op    <= #1 mem_op;
        id_mem_wdata <= #1 mem_wdata;
        id_ctrl_op   <= #1 ctrl_op;
        id_dst_addr  <= #1 dst_addr;
        id_gpr_wen   <= #1 gpr_wen;
        id_exp_code  <= #1 exp_code;
      end
    end
  end 


endmodule
