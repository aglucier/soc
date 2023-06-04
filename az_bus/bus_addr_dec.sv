module bus_addr_dec(
  input [29:0] s_addr,
  output logic s0_csn,
  output logic s1_csn,
  output logic s2_csn,
  output logic s3_csn,
  output logic s4_csn,
  output logic s5_csn,
  output logic s6_csn,
  output logic s7_csn
);


  localparam S0_CSN = 3'h0;
  localparam S1_CSN = 3'h1;
  localparam S2_CSN = 3'h2;
  localparam S3_CSN = 3'h3;
  localparam S4_CSN = 3'h4;
  localparam S5_CSN = 3'h5;
  localparam S6_CSN = 3'h6;
  localparam S7_CSN = 3'h7;


  logic [2:0] s_index;


  assign s_index = s_addr[29:27];

  always_comb begin
    if(s_index==S0_CSN)
      s0_csn = 'b0;
    else
      s0_csn = 'b1;
  end

  always_comb begin
    if(s_index==S1_CSN)
      s1_csn = 'b0;
    else
      s1_csn = 'b1;
  end

  always_comb begin
    if(s_index==S2_CSN)
      s2_csn = 'b0;
    else
      s2_csn = 'b1;
  end

  always_comb begin
    if(s_index==S3_CSN)
      s3_csn = 'b0;
    else
      s3_csn = 'b1;
  end

  always_comb begin
    if(s_index==S4_CSN)
      s4_csn = 'b0;
    else
      s4_csn = 'b1;
  end

  always_comb begin
    if(s_index==S5_CSN)
      s5_csn = 'b0;
    else
      s5_csn = 'b1;
  end

  always_comb begin
    if(s_index==S6_CSN)
      s6_csn = 'b0;
    else
      s6_csn = 'b1;
  end

  always_comb begin
    if(s_index==S7_CSN)
      s7_csn = 'b0;
    else
      s7_csn = 'b1;
  end


endmodule
