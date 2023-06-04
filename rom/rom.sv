module rom
#(
  parameter ROM_ADDR_W = 'd11,
  parameter ROM_DEPTH  = 'd2048,
  parameter DATA_W     = 'd32
)
(
  input	csn,
  input	asn,
  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input [ROM_ADDR_W-1:0] addr,			// To i_sprom of sprom.v
  input			clk,			// To i_sprom of sprom.v
  // End of automatics
  output logic rdy,
  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output logic [DATA_W-1:0] rdata		// From i_sprom of sprom.v
  // End of automatics
);

  
  localparam ENABLE = 'b0;


  always_ff @(posedge rom_clk or rom_rstn) begin
    if(!rom_rstn)
      rdy <= #1 'b0;
    else if(asn==ENABLE & csn==ENABLE)
      rdy <= #1 'b1;
    else
      rdy <= #1 'b0;
  end


  /* sprom AUTO_TEMPLATE(
    .dout(rdata[]),
  );*/
  sprom i_sprom #(/*AUTOINSTPARAM*/
		  // Parameters
		  .ROM_ADDR_W		(ROM_ADDR_W),
		  .ROM_DEPTH		(ROM_DEPTH),
		  .DATA_W		(DATA_W))(/*AUTOINST*/
						  // Outputs
						  .dout			(rdata[DATA_W-1:0]), // Templated
						  // Inputs
						  .clk			(clk),
						  .addr			(addr[ROM_ADDR_W-1:0]));


endmodule
//Local Variables:
//verilog-library-flags:(".")
//verilog-auto-inst-param-value:"t"
//End
