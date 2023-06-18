module if_reg(
  input        cpu_clk,
  input        cpu_rstn,
  input [31:0] insn,
  input        stall,
  input        flush,
  input [29:0] new_pc,
  input        br_taken,
  input [29:0] br_addr,
  output logic [29:0] if_pc,
  output logic [31:0] if_insn,
  output        if_en
);


  always_ff @(posedge cpu_clk or negedge cpu_rstn) begin
    if(!cpu_rstn) begin
      if_pc   <= #1 'h0;
      if_insn <= #1 'h0;
      if_en   <= #1 'h0;
    end else if(stall=='b0) begin
      if(flush=='b1) begin
        if_pc   <= #1 new_pc;
        if_insn <= #1 'h0;
        if_en   <= #1 'h0;
      end else if(br_taken) begin
        if_pc   <= #1 br_addr;
        if_insn <= #1 insn;
        if_en   <= #1 'h1;
      end else begin
        if_pc   <= #1 if_pc + 1'h1;
        if_insn <= #1 insn;
        if_en   <= #1 'h1;
      end
  end

  
endmodule
