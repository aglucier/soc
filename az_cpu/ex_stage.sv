module ex_stage(
  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input [31:0]		alu_in_0,		// To i_alu of alu.v
  input [31:0]		alu_in_1,		// To i_alu of alu.v
  input [3:0]		alu_op,			// To i_alu of alu.v
  input			cpu_clk,		// To i_ex_reg of ex_reg.v
  input			cpu_rstn,		// To i_ex_reg of ex_reg.v
  input			flush,			// To i_ex_reg of ex_reg.v
  input			id_br_flag,		// To i_ex_reg of ex_reg.v
  input [1:0]		id_ctrl_op,		// To i_ex_reg of ex_reg.v
  input [4:0]		id_dst_addr,		// To i_ex_reg of ex_reg.v
  input			id_en,			// To i_ex_reg of ex_reg.v
  input [2:0]		id_exp_code,		// To i_ex_reg of ex_reg.v
  input			id_gpr_wen,		// To i_ex_reg of ex_reg.v
  input [1:0]		id_mem_op,		// To i_ex_reg of ex_reg.v
  input [31:0]		id_mem_wdata,		// To i_ex_reg of ex_reg.v
  input [29:0]		id_pc,			// To i_ex_reg of ex_reg.v
  input			int_detect,		// To i_ex_reg of ex_reg.v
  input			stall,			// To i_ex_reg of ex_reg.v
  // End of automatics
  output logic [31:0] fwd_data;,
  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output logic		ex_br_flag,		// From i_ex_reg of ex_reg.v
  output logic [1:0]	ex_ctrl_op,		// From i_ex_reg of ex_reg.v
  output logic [4:0]	ex_dst_addr,		// From i_ex_reg of ex_reg.v
  output logic		ex_en,			// From i_ex_reg of ex_reg.v
  output logic [2:0]	ex_exp_code,		// From i_ex_reg of ex_reg.v
  output logic		ex_gpr_wen,		// From i_ex_reg of ex_reg.v
  output logic [1:0]	ex_mem_op,		// From i_ex_reg of ex_reg.v
  output logic [31:0]	ex_mem_wdata,		// From i_ex_reg of ex_reg.v
  output logic [31:0]	ex_out,			// From i_ex_reg of ex_reg.v
  output logic [29:0]	ex_pc			// From i_ex_reg of ex_reg.v
  // End of automatics
);

  
  assign fwd_data = alu_out;


  /* ex_reg AUTO_TEMPLATE(
  );*/
  ex_reg i_ex_reg(/*AUTOINST*/
		  // Outputs
		  .ex_pc		(ex_pc[29:0]),
		  .ex_en		(ex_en),
		  .ex_br_flag		(ex_br_flag),
		  .ex_mem_op		(ex_mem_op[1:0]),
		  .ex_mem_wdata		(ex_mem_wdata[31:0]),
		  .ex_ctrl_op		(ex_ctrl_op[1:0]),
		  .ex_dst_addr		(ex_dst_addr[4:0]),
		  .ex_gpr_wen		(ex_gpr_wen),
		  .ex_exp_code		(ex_exp_code[2:0]),
		  .ex_out		(ex_out[31:0]),
		  // Inputs
		  .cpu_clk		(cpu_clk),
		  .cpu_rstn		(cpu_rstn),
		  .alu_out		(alu_out[31:0]),
		  .alu_of		(alu_of),
		  .stall		(stall),
		  .flush		(flush),
		  .int_detect		(int_detect),
		  .id_pc		(id_pc[29:0]),
		  .id_en		(id_en),
		  .id_br_flag		(id_br_flag),
		  .id_mem_op		(id_mem_op[1:0]),
		  .id_mem_wdata		(id_mem_wdata[31:0]),
		  .id_ctrl_op		(id_ctrl_op[1:0]),
		  .id_dst_addr		(id_dst_addr[4:0]),
		  .id_gpr_wen		(id_gpr_wen),
		  .id_exp_code		(id_exp_code[2:0]));

  /* alu AUTO_TEMPLATE(
    .op  (alu_op[]),
    .in_0(alu_in_0[]),
    .in_1(alu_in_1[]),
    .of  (alu_of[]),
    .out (alu_out[]),
  );*/
  alu i_alu(/*AUTOINST*/
	    // Outputs
	    .out			(alu_out[31:0]),	 // Templated
	    .of				(alu_of),		 // Templated
	    // Inputs
	    .in_0			(alu_in_0[31:0]),	 // Templated
	    .in_1			(alu_in_1[31:0]),	 // Templated
	    .op				(alu_op[3:0]));		 // Templated


endmodule
//Local Variables:
//verilog-library-flags:(".")
//verilog-auto-inst-param-value:"t"
//End
