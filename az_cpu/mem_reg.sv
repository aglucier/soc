module mem_reg(
  input         cpu_clk,
  input         cpu_rstn,
  input [31:0]  out,
  input         miss_align,
  input         stall,
  input         flush,
  input [29:0]  ex_pc,
  input         ex_en,
  input         ex_br_flag,
  input [1:0]   ex_ctrl_op,
  input [4:0]   ex_dst_addr,
  input         ex_gpr_wen,
  input [2:0]   ex_exp_code,
  output logic [29:0] mem_pc,
  output logic        mem_en,
  output logic        mem_br_flag,
  output logic [1:0]  mem_ctrl_op,
  output logic [4:0]  mem_dst_addr,
  output logic        mem_gpr_wen,
  output logic [2:0]  mem_ctrl_op,
  output logic [2:0]  mem_exp_code,
  output logic [31:0] mem_out
);


  localparam ENABLEN            = 'h0;
  localparam DISENABLEN         = 'h1;
  localparam ISA_EXP_MISS_ALIGN = 'h4;

  always_ff @(posedge cpu_clk or negedge cpu_rstn) begin
    if(!cpu_rstn) begin
      mem_pc       <= #1 'h0;
      mem_en       <= #1 'h0;
      mem_br_flag  <= #1 'h0;
      mem_ctrl_op  <= #1 'h0;
      mem_dst_addr <= #1 'h0;
      mem_gpr_wen  <= #1 DISENABLEN;
      mem_exp_code <= #1 'h0;
      mem_out      <= #1 'h0;
    end else if(stall=='h0) begin
      if(flush=='h1) begin
        mem_pc       <= #1 'h0;
        mem_en       <= #1 'h0;
        mem_br_flag  <= #1 'h0;
        mem_ctrl_op  <= #1 'h0;
        mem_dst_addr <= #1 'h0;
        mem_gpr_wen  <= #1 DISENABLEN;
        mem_exp_code <= #1 'h0;
        mem_out      <= #1 'h0;
      end else if(miss_align) begin
        mem_pc       <= #1 ex_pc;
        mem_en       <= #1 ex_en;
        mem_br_flag  <= #1 ex_br_flag;
        mem_ctrl_op  <= #1 'h0;
        mem_dst_addr <= #1 'h0;
        mem_gpr_wen  <= #1 DISENABLEN;
        mem_exp_code <= #1 ISA_EXP_MISS_ALIGN;
        mem_out      <= #1 'h0;
      end else begin
        mem_pc       <= #1 ex_pc;
        mem_en       <= #1 ex_en;
        mem_br_flag  <= #1 ex_br_flag;
        mem_ctrl_op  <= #1 ex_ctrl_op;
        mem_dst_addr <= #1 ex_dst_addr;
        mem_gpr_wen  <= #1 ex_gpr_wen;
        mem_exp_code <= #1 ex_exp_code;
        mem_out      <= #1 out;
      end
    end
  end


endmodule
