module bus_slave_mux(
  input        s0_csn,
  input [31:0] s0_rdata,
  input        s0_rdy,
  input        s1_csn,
  input [31:0] s1_rdata,
  input        s1_rdy,
  input        s2_csn,
  input [31:0] s2_rdata,
  input        s2_rdy,
  input        s3_csn,
  input [31:0] s3_rdata,
  input        s3_rdy,
  input        s4_csn,
  input [31:0] s4_rdata,
  input        s4_rdy,
  input        s5_csn,
  input [31:0] s5_rdata,
  input        s5_rdy,
  input        s6_csn,
  input [31:0] s6_rdata,
  input        s6_rdy,
  input        s7_csn,
  input [31:0] s7_rdata,
  input        s7_rdy,
  output logic [31:0] m_rdata,
  output logic        m_rdy
);


  localparam ENABLE      = 'b0;
  localparam RDY_DISABLE = 'b0;


  always_comb begin
    if(s0_csn==ENABLE) begin
      m_rdy   = s0_rdy;
      m_rdata = s0_rdata;
    end else if(s1_csn==ENABLE) begin
      m_rdy   = s1_rdy;
      m_rdata = s1_rdata;
    end else if(s2_csn==ENABLE) begin
      m_rdy   = s2_rdy;
      m_rdata = s2_rdata;
    end else if(s3_csn==ENABLE) begin
      m_rdy   = s3_rdy;
      m_rdata = s3_rdata;
    end else if(s4_csn==ENABLE) begin
      m_rdy   = s4_rdy;
      m_rdata = s4_rdata;
    end else if(s5_csn==ENABLE) begin
      m_rdy   = s5_rdy;
      m_rdata = s5_rdata;
    end else if(s6_csn==ENABLE) begin
      m_rdy   = s6_rdy;
      m_rdata = s6_rdata;
    end else if(s7_csn==ENABLE) begin
      m_rdy   = s7_rdy;
      m_rdata = s7_rdata;
    end else begin
      m_rdy   = RDY_DISABLE;
      m_rdata = 'h0;
    end
  end


endmodule
