module sprom#(
  parameter ROM_ADDR_W = 'd11,
  parameter ROM_DEPTH  = 'd2048,
  parameter DATA_W     = 'd32
)(
  input                         clk,
  input        [ROM_ADDR_W-1:0] addr,
  output logic [DATA_W-1:0]     dout
);


  logic [DATA_W-1:0] rom [0:ROM_DEPTH-1]


  always_ff (posedge clk) begin
    dout <= rom[addr];
  end


endmodule
