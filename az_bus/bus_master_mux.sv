module bus_master_mux(
  input  [29:0] m0_addr,
  input         m0_asn,
  input         m0_rw,
  input  [31:0] m0_wdata,
  input         m0_grntn,
  input  [29:0] m1_addr,
  input         m1_asn,
  input         m1_rw,
  input  [31:0] m1_wdata,
  input         m1_grntn,
  input  [29:0] m2_addr,
  input         m2_asn,
  input         m2_rw,
  input  [31:0] m2_wdata,
  input         m2_grntn,
  input  [29:0] m3_addr,
  input         m3_asn,
  input         m3_rw,
  input  [31:0] m3_wdata,
  input         m3_grntn,
  output [29:0] s_addr,
  output        s_asn,
  output        s_rw,
  output [31:0] s_wdata,
);


  localparam ENABLE  = 'b0;
  localparam DISABLE = 'b1;
  localparam READ    = 'b1;


  always_comb begin
    if(m0_grntn==ENABLE) begin
      s_addr  = m0_addr;
      s_asn   = m0_asn;
      s_rw    = m0_rw;
      s_wdata = m0_wdata;
    end else if(m1_grntn==ENABLE) begin
      s_addr  = m1_addr;
      s_asn   = m1_asn;
      s_rw    = m1_rw;
      s_wdata = m1_wdata;
    end else if(m2_grntn==ENABLE) begin
      s_addr  = m2_addr;
      s_asn   = m2_asn;
      s_rw    = m2_rw;
      s_wdata = m2_wdata;
    end else if(m3_grntn==ENABLE) begin
      s_addr  = m3_addr;
      s_asn   = m3_asn;
      s_rw    = m3_rw;
      s_wdata = m3_wdata;
    end else begin
      s_addr  = 'h0;
      s_asn   = DISABLE;
      s_rw    = READ;
      s_wdata = 'h0;
    end
  end


endmodule
