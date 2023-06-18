module ex_reg(
  input        cpu_clk,
  input        cpu_rstn,
  input [31:0] alu_out,
  input        alu_of,
  input        stall,
  input        flush,
  input        int_detect,
  input [29:0] id_pc,
  input        id_en,
  input        id_br_flag,
  input [1:0]  id_mem_op,
  input [31:0] id_mem_wdata,
  input [1:0]  id_ctrl_op,
  input [4:0]  id_dst_addr,
  input        id_gpr_wen,
  input [2:0]  id_exp_code,
  output logic [29:0] ex_pc,
  output logic        ex_en,
  output logic        ex_br_flag,
  output logic [1:0]  ex_mem_op,
  output logic [31:0] ex_mem_wdata,
  output logic [1:0]  ex_ctrl_op,
  output logic [4:0]  ex_dst_addr,
  output logic        ex_gpr_wen,
  output logic [2:0]  ex_exp_code,
  output logic [31:0] ex_out
);


  localparam ISA_EXP_EXT_INT  = 'h1;
  localparam ISA_EXP_OVERFLOW = 'h3;
  localparam ENABLEN   = 'h0;
  localparam DISNABLEN = 'h1;


  always_ff @(posedge cpu_clk or negedge cpu_rstn) begin
    if(cpu_rstn) begin
      ex_pc        <= #1 'h0;
      ex_en        <= #1 'h0;
      ex_br_flag   <= #1 'h0;
      ex_mem_op    <= #1 'h0;
      ex_mem_wdata <= #1 'h0;
      ex_ctrl_op   <= #1 'h0;
      ex_dst_addr  <= #1 'h0;
      ex_gpr_wen   <= #1 'h0;
      ex_exp_code  <= #1 'h0;
      ex_out       <= #1 'h0;
    end else if(stall=='h0) begin
      if(flush=='h1) begin
        ex_pc        <= #1 'h0;
        ex_en        <= #1 'h0;
        ex_br_flag   <= #1 'h0;
        ex_mem_op    <= #1 'h0;
        ex_mem_wdata <= #1 'h0;
        ex_ctrl_op   <= #1 'h0;
        ex_dst_addr  <= #1 'h0;
        ex_gpr_wen   <= #1 'h0;
        ex_exp_code  <= #1 'h0;
        ex_out       <= #1 'h0;
      end else if(int_detect=='h1) begin
        ex_pc        <= #1 id_pc;
        ex_en        <= #1 id_en;
        ex_br_flag   <= #1 id_br_flag;
        ex_mem_op    <= #1 'h0;
        ex_mem_wdata <= #1 'h0;
        ex_ctrl_op   <= #1 'h0;
        ex_dst_addr  <= #1 'h0;
        ex_gpr_wen   <= #1 DISNABLEN;
        ex_exp_code  <= #1 ISA_EXP_EXT_INT;
        ex_out       <= #1 'h0;
      end else if(alu_of=='h1) begin
        ex_pc        <= #1 id_pc;
        ex_en        <= #1 id_en;
        ex_br_flag   <= #1 id_br_flag;
        ex_mem_op    <= #1 'h0;
        ex_mem_wdata <= #1 'h0;
        ex_ctrl_op   <= #1 'h0;
        ex_dst_addr  <= #1 'h0;
        ex_gpr_wen   <= #1 DISNABLEN;
        ex_exp_code  <= #1 ISA_EXP_OVERFLOW;
        ex_out       <= #1 'h0;
      end else begin
        ex_pc        <= #1 id_pc;
        ex_en        <= #1 id_en;
        ex_br_flag   <= #1 id_br_flag;
        ex_mem_op    <= #1 id_mem_op;
        ex_mem_wdata <= #1 id_mem_wdata;
        ex_ctrl_op   <= #1 id_ctrl_op;
        ex_dst_addr  <= #1 id_dst_addr;
        ex_gpr_wen   <= #1 id_gpr_wen;
        ex_exp_code  <= #1 id_exp_code;
        ex_out       <= #1 alu_out;
      end
    end
  end


endmodule
