module dprom(
  input clk1,
  input we1,
  input [11:0] addr1,
  input [31:0] din1,
  input clk2,
  input we2,
  input [11:0] addr2,
  input [31:0] din2,
  output logic dout1,
  output logic dout2
);


  logic [31:0] mem[0:4095];


  always_ff @(posedge clk1) begin
    if(we1)
      mem[addr1] <= #1 din1;
    else if(we2)
      mem[addr2] <= #1 din2;
  end

  always_ff @(posedge clk1) begin
    if(!we1)
      dout1 <= #1 mem[addr1];
  end

  always_ff @(posedge clk2) begin
    if(!we2)
      dout2 <= #1 mem[addr2];
  end


endmodule
