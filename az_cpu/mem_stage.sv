module mem_stage(
  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input			bus_grntn,		// To i_bus_if of bus_if.v
  input [31:0]		bus_rdata,		// To i_bus_if of bus_if.v
  input			bus_rdyn,		// To i_bus_if of bus_if.v
  input			cpu_clk,		// To i_bus_if of bus_if.v, ...
  input			cpu_rstn,		// To i_bus_if of bus_if.v, ...
  input			ex_br_flag,		// To i_mem_reg of mem_reg.v
  input [1:0]		ex_ctrl_op,		// To i_mem_reg of mem_reg.v
  input [4:0]		ex_dst_addr,		// To i_mem_reg of mem_reg.v
  input			ex_en,			// To i_mem_ctrl of mem_ctrl.v, ...
  input [2:0]		ex_exp_code,		// To i_mem_reg of mem_reg.v
  input			ex_gpr_wen,		// To i_mem_reg of mem_reg.v
  input [1:0]		ex_mem_op,		// To i_mem_ctrl of mem_ctrl.v
  input [31:0]		ex_mem_wdata,		// To i_mem_ctrl of mem_ctrl.v
  input [31:0]		ex_out,			// To i_mem_ctrl of mem_ctrl.v
  input [29:0]		ex_pc,			// To i_mem_reg of mem_reg.v
  input			flush,			// To i_bus_if of bus_if.v, ...
  input [31:0]		spm_wdata,		// To i_bus_if of bus_if.v
  input			stall,			// To i_bus_if of bus_if.v, ...
  // End of automatics
  output logic [31:0] fwd_data,
  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output logic [29:0]	bus_addr,		// From i_bus_if of bus_if.v
  output logic		bus_asn,		// From i_bus_if of bus_if.v
  output logic		bus_reqn,		// From i_bus_if of bus_if.v
  output logic		bus_rw,			// From i_bus_if of bus_if.v
  output logic [31:0]	bus_wdata,		// From i_bus_if of bus_if.v
  output		busy,			// From i_bus_if of bus_if.v
  output logic		mem_br_flag,		// From i_mem_reg of mem_reg.v
  output logic [1:0]	mem_ctrl_op,		// From i_mem_reg of mem_reg.v
  output logic [4:0]	mem_dst_addr,		// From i_mem_reg of mem_reg.v
  output logic		mem_en,			// From i_mem_reg of mem_reg.v
  output logic [2:0]	mem_exp_code,		// From i_mem_reg of mem_reg.v
  output logic		mem_gpr_wen,		// From i_mem_reg of mem_reg.v
  output logic [31:0]	mem_out,		// From i_mem_reg of mem_reg.v
  output logic [29:0]	mem_pc,			// From i_mem_reg of mem_reg.v
  output logic [29:0]	spm_addr,		// From i_bus_if of bus_if.v
  output logic		spm_asn,		// From i_bus_if of bus_if.v
  output logic [31:0]	spm_rdata,		// From i_bus_if of bus_if.v
  output logic		spm_rw			// From i_bus_if of bus_if.v
  // End of automatics
);


  assign fwd_data = out;

  /* bus_if AUTO_TEMPLATE(
  );*/
  bus_if i_bus_if(/*AUTOINST*/
		  // Outputs
		  .busy			(busy),
		  .cpu_rdata		(cpu_rdata[31:0]),
		  .spm_asn		(spm_asn),
		  .spm_rw		(spm_rw),
		  .spm_addr		(spm_addr[29:0]),
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
		  .cpu_asn		(cpu_asn),
		  .cpu_rw		(cpu_rw),
		  .cpu_addr		(cpu_addr[29:0]),
		  .cpu_wdata		(cpu_wdata[31:0]),
		  .spm_wdata		(spm_wdata[31:0]),
		  .bus_grntn		(bus_grntn),
		  .bus_rdyn		(bus_rdyn),
		  .bus_rdata		(bus_rdata[31:0]));

  /* mem_ctrl AUTO_TEMPLATE(
	.addr   (cpu_addr[29:0]),
	.asn    (cpu_asn),
	.rw	    (cpu_rw),
	.wdata  (cpu_wdata[31:0]),
    .rd_data(cpu_rdata[31:0]));
  );*/
  mem_ctrl i_mem_ctrl(/*AUTOINST*/
		      // Outputs
		      .addr		(cpu_addr[29:0]),	 // Templated
		      .asn		(cpu_asn),		 // Templated
		      .rw		(cpu_rw),		 // Templated
		      .wdata		(cpu_wdata[31:0]),	 // Templated
		      .out		(out[31:0]),
		      .miss_align	(miss_align),
		      // Inputs
		      .ex_en		(ex_en),
		      .ex_mem_op	(ex_mem_op[1:0]),
		      .ex_mem_wdata	(ex_mem_wdata[31:0]),
		      .ex_out		(ex_out[31:0]),
		      .rd_data		(cpu_rdata[31:0]));	 // Templated

  /* mem_reg AUTO_TEMPLATE(
  );*/
  mem_reg i_mem_reg(/*AUTOINST*/
		    // Outputs
		    .mem_pc		(mem_pc[29:0]),
		    .mem_en		(mem_en),
		    .mem_br_flag	(mem_br_flag),
		    .mem_ctrl_op	(mem_ctrl_op[1:0]),
		    .mem_dst_addr	(mem_dst_addr[4:0]),
		    .mem_gpr_wen	(mem_gpr_wen),
		    .mem_exp_code	(mem_exp_code[2:0]),
		    .mem_out		(mem_out[31:0]),
		    // Inputs
		    .cpu_clk		(cpu_clk),
		    .cpu_rstn		(cpu_rstn),
		    .out		(out[31:0]),
		    .miss_align		(miss_align),
		    .stall		(stall),
		    .flush		(flush),
		    .ex_pc		(ex_pc[29:0]),
		    .ex_en		(ex_en),
		    .ex_br_flag		(ex_br_flag),
		    .ex_ctrl_op		(ex_ctrl_op[1:0]),
		    .ex_dst_addr	(ex_dst_addr[4:0]),
		    .ex_gpr_wen		(ex_gpr_wen),
		    .ex_exp_code	(ex_exp_code[2:0]));


endmodule
//Local Variables:
//verilog-library-flags:(".")
//verilog-auto-inst-param-value:"t"
//End
