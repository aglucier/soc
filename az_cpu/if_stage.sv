module if_stage(
  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input [29:0]		br_addr,		// To i_if_reg of if_reg.v
  input			br_taken,		// To i_if_reg of if_reg.v
  input			bus_grntn,		// To i_bus_if of bus_if.v
  input [31:0]		bus_rdata,		// To i_bus_if of bus_if.v
  input			bus_rdyn,		// To i_bus_if of bus_if.v
  input [29:0]		cpu_addr,		// To i_bus_if of bus_if.v
  input			cpu_clk,		// To i_bus_if of bus_if.v, ...
  input			cpu_rstn,		// To i_bus_if of bus_if.v, ...
  input [31:0]		cpu_wdata,		// To i_bus_if of bus_if.v
  input			flush,			// To i_bus_if of bus_if.v, ...
  input [31:0]		insn,			// To i_if_reg of if_reg.v
  input [29:0]		new_pc,			// To i_if_reg of if_reg.v
  input [29:0]		spm_addr,		// To i_bus_if of bus_if.v
  input [31:0]		spm_wdata,		// To i_bus_if of bus_if.v
  input			stall,			// To i_bus_if of bus_if.v, ...
  // End of automatics
  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output logic [29:0]	bus_addr,		// From i_bus_if of bus_if.v
  output logic		bus_asn,		// From i_bus_if of bus_if.v
  output logic		bus_reqn,		// From i_bus_if of bus_if.v
  output logic		bus_rw,			// From i_bus_if of bus_if.v
  output logic [31:0]	bus_wdata,		// From i_bus_if of bus_if.v
  output		busy,			// From i_bus_if of bus_if.v
  output logic [31:0]	cpu_rdata,		// From i_bus_if of bus_if.v
  output		if_en,			// From i_if_reg of if_reg.v
  output logic [31:0]	if_insn,		// From i_if_reg of if_reg.v
  output logic [29:0]	if_pc,			// From i_if_reg of if_reg.v
  output logic		spm_asn,		// From i_bus_if of bus_if.v
  output logic [31:0]	spm_rdata,		// From i_bus_if of bus_if.v
  output logic		spm_rw			// From i_bus_if of bus_if.v
  // End of automatics
);


  /* bus_if AUTO_TEMPLATE(
    .cpu_asn('h0),
    .cpu_rw ('h1),
  );*/
  bus_if i_bus_if(/*AUTOINST*/
		  // Outputs
		  .busy			(busy),
		  .cpu_rdata		(cpu_rdata[31:0]),
		  .spm_asn		(spm_asn),
		  .spm_rw		(spm_rw),
		  .spm_rdata		(spm_rdata[31:0]),
		  .bus_asn		(bus_asn),
		  .bus_rw		(bus_rw),
		  .bus_reqn		(bus_reqn),
		  .bus_addr		(bus_addr[29:0]),
		  .bus_wdata		(bus_wdata[31:0]),
		  // Inputs
		  .cpu_clk		(cpu_clk),
		  .cpu_rstn		(cpu_rstn),
		  .stall		(stall),
		  .flush		(flush),
		  .cpu_asn		('h0),			 // Templated
		  .cpu_rw		('h1),			 // Templated
		  .cpu_addr		(cpu_addr[29:0]),
		  .cpu_wdata		(cpu_wdata[31:0]),
		  .spm_addr		(spm_addr[29:0]),
		  .spm_wdata		(spm_wdata[31:0]),
		  .bus_grntn		(bus_grntn),
		  .bus_rdyn		(bus_rdyn),
		  .bus_rdata		(bus_rdata[31:0]));

  /* if_reg AUTO_TEMPLATE(
  );*/
  if_reg i_if_reg(/*AUTOINST*/
		  // Outputs
		  .if_pc		(if_pc[29:0]),
		  .if_insn		(if_insn[31:0]),
		  .if_en		(if_en),
		  // Inputs
		  .cpu_clk		(cpu_clk),
		  .cpu_rstn		(cpu_rstn),
		  .insn			(insn[31:0]),
		  .stall		(stall),
		  .flush		(flush),
		  .new_pc		(new_pc[29:0]),
		  .br_taken		(br_taken),
		  .br_addr		(br_addr[29:0]));


endmodule
//Local Variables:
//verilog-library-flags:(".")
//verilog-auto-inst-param-value:"t"
//End
