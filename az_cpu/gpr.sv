module gpr(
  input cpu_clk,
  input cpu_rstn,
  input wen,
  input [31:0] waddr,
  input [31:0] wdata,
  input [4:0]  raddr0,
  input [4:0]  raddr1,
  output logic [31:0] rdata0,
  output logic [31:0] rdata1
);


  logic [31:0] gpr[0:31];
  integer i;


  // write after read
  assign rdata0 = (wen=='b0 & waddr==raddr0) ? wdata : gpr[raddr0];
  assign rdata1 = (wen=='b0 & waddr==raddr1) ? wdata : gpr[raddr1];


  always_ff @(posedge cpu_clk or negedge cpu_rstn) begin
    if(!cpu_rstn) begin
      for(i=0;i<32;i=i+1) begin
        gpr[i] <= #1 'h0;
      end
    end else if(we) begin
      gpr[waddr] <= #1 wdata;
    end
  end


endmodule
