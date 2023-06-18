module bus_slave_mux(
  input        s0_csn,
  input [31:0] s0_rdata,
  input        s0_rdyn,
  input        s1_csn,
  input [31:0] s1_rdata,
  input        s1_rdyn,
  input        s2_csn,
  input [31:0] s2_rdata,
  input        s2_rdyn,
  input        s3_csn,
  input [31:0] s3_rdata,
  input        s3_rdyn,
  input        s4_csn,
  input [31:0] s4_rdata,
  input        s4_rdyn,
  input        s5_csn,
  input [31:0] s5_rdata,
  input        s5_rdyn,
  input        s6_csn,
  input [31:0] s6_rdata,
  input        s6_rdyn,
  input        s7_csn,
  input [31:0] s7_rdata,
  input        s7_rdyn,
  output logic [31:0] m_rdata,
  output logic        m_rdyn
);


  localparam ENABLE      = 'b0;
  localparam RDY_DISABLE = 'b1;


  always_comb begin
    if(s0_csn==ENABLE) begin
      m_rdyn  = s0_rdyn;
      m_rdata = s0_rdata;
    end else if(s1_csn==ENABLE) begin
      m_rdyn  = s1_rdyn;
      m_rdata = s1_rdata;
    end else if(s2_csn==ENABLE) begin
      m_rdyn  = s2_rdyn;
      m_rdata = s2_rdata;
    end else if(s3_csn==ENABLE) begin
      m_rdyn  = s3_rdyn;
      m_rdata = s3_rdata;
    end else if(s4_csn==ENABLE) begin
      m_rdyn  = s4_rdyn;
      m_rdata = s4_rdata;
    end else if(s5_csn==ENABLE) begin
      m_rdyn  = s5_rdyn;
      m_rdata = s5_rdata;
    end else if(s6_csn==ENABLE) begin
      m_rdyn  = s6_rdyn;
      m_rdata = s6_rdata;
    end else if(s7_csn==ENABLE) begin
      m_rdyn  = s7_rdyn;
      m_rdata = s7_rdata;
    end else begin
      m_rdyn  = RDY_DISABLE;
      m_rdata = 'h0;
    end
  end


endmodule
