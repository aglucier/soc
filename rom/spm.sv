module spm(
  input cpu_clk,
  input if_spm_asn,
  input if_spm_rw,
  input [11:0] if_spm_addr,
  input [31:0] if_spm_wdata,
  input if_mem_asn,
  input if_mem_rw,
  input [11:0] if_mem_addr,
  input [31:0] if_mem_wdata,
  output logic [31:0] if_spm_rdata,
  output logic [31:0] if_mem_rdata
);


  localparam ENABLE  = 'b0;
  localparam DISABLE = 'b1;
  localparam WRITE   = 'b0;
  localparam READ    = 'b1;


  logic we1, we2;


  assign we1 = (if_spm_asn==ENABLE & if_spm_rw==WRITE) ? READ : WRITE;
  assign we2 = (if_mem_asn==ENABLE & if_mem_rw==WRITE) ? READ : WRITE;


  /* dprom AUTO_TEMPLATE(
    .clk\([1-2]\)(cpu_clk),
    .addr1(if_spm_addr),
    .din1 (if_spm_wdata),
    .dout1(if_spm_rdata),
    .addr2(if_mem_addr),
    .din2 (if_mem_wdata),
    .dout2(if_mem_rdata),
  );*/
  dprom i_dprom(/*AUTOINST*/
		// Outputs
		.dout1			(if_spm_rdata),		 // Templated
		.dout2			(if_mem_rdata),		 // Templated
		// Inputs
		.clk1			(cpu_clk),		 // Templated
		.we1			(we1),
		.addr1			(if_spm_addr),		 // Templated
		.din1			(if_spm_wdata),		 // Templated
		.clk2			(cpu_clk),		 // Templated
		.we2			(we2),
		.addr2			(if_mem_addr),		 // Templated
		.din2			(if_mem_wdata));		 // Templated


endmodule
//Local Variables:
//verilog-library-flags:(".")
//verilog-auto-inst-param-value:"t"
//End
