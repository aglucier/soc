module if_stage(
  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input			cpu_clk,		// To i_id_reg of id_reg.v
  input			cpu_rstn,		// To i_id_reg of id_reg.v
  input [31:0]		creg_rd_data,		// To i_decode of decoder.v
  input [4:0]		ex_dst_addr,		// To i_decode of decoder.v
  input			ex_en,			// To i_decode of decoder.v
  input [31:0]		ex_fwd_data,		// To i_decode of decoder.v
  input			ex_gpr_wen,		// To i_decode of decoder.v
  input			exe_mode,		// To i_decode of decoder.v
  input			flush,			// To i_id_reg of id_reg.v
  input [31:0]		gpr_rdata_0,		// To i_decode of decoder.v
  input [31:0]		gpr_rdata_1,		// To i_decode of decoder.v
  input			if_en,			// To i_decode of decoder.v, ...
  input [31:0]		if_insn,		// To i_decode of decoder.v
  input [29:0]		if_pc,			// To i_decode of decoder.v, ...
  input [31:0]		mem_fwd_data,		// To i_decode of decoder.v
  input			stall,			// To i_id_reg of id_reg.v
  // End of automatics
  output logic id_en,
  output logic [1:0]	id_mem_op,
  output logic [3:0]	id_dst_addr,
  output logic id_gpr_wen,
  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output logic [29:0]	br_addr,		// From i_decode of decoder.v
  output logic		br_taken,		// From i_decode of decoder.v
  output logic [4:0]	creg_rd_addr,		// From i_decode of decoder.v
  output logic [4:0]	gpr_raddr_0,		// From i_decode of decoder.v
  output logic [4:0]	gpr_raddr_1,		// From i_decode of decoder.v
  output logic [31:0]	id_alu_in_0,		// From i_id_reg of id_reg.v
  output logic [31:0]	id_alu_in_1,		// From i_id_reg of id_reg.v
  output logic [3:0]	id_alu_op,		// From i_id_reg of id_reg.v
  output logic		id_br_flag,		// From i_id_reg of id_reg.v
  output logic [1:0]	id_ctrl_op,		// From i_id_reg of id_reg.v
  output logic [2:0]	id_exp_code,		// From i_id_reg of id_reg.v
  output logic [31:0]	id_mem_wdata,		// From i_id_reg of id_reg.v
  output logic [29:0]	id_pc,			// From i_id_reg of id_reg.v
  output logic		ld_hazard		// From i_decode of decoder.v
  // End of automatics
);


  /* decoder AUTO_TEMPLATE(
  );*/
  decoder i_decode(/*AUTOINST*/
		   // Outputs
		   .gpr_raddr_0		(gpr_raddr_0[4:0]),
		   .gpr_raddr_1		(gpr_raddr_1[4:0]),
		   .creg_rd_addr	(creg_rd_addr[4:0]),
		   .alu_op		(alu_op[3:0]),
		   .alu_in_0		(alu_in_0[31:0]),
		   .alu_in_1		(alu_in_1[31:0]),
		   .br_addr		(br_addr[29:0]),
		   .br_taken		(br_taken),
		   .br_flag		(br_flag),
		   .mem_op		(mem_op[1:0]),
		   .mem_wdata		(mem_wdata[31:0]),
		   .ctrl_op		(ctrl_op[1:0]),
		   .dst_addr		(dst_addr[4:0]),
		   .gpr_wen		(gpr_wen),
		   .exp_code		(exp_code[2:0]),
		   .ld_hazard		(ld_hazard),
		   // Inputs
		   .if_pc		(if_pc[29:0]),
		   .if_insn		(if_insn[31:0]),
		   .if_en		(if_en),
		   .gpr_rdata_0		(gpr_rdata_0[31:0]),
		   .gpr_rdata_1		(gpr_rdata_1[31:0]),
		   .id_en		(id_en),
		   .id_dst_addr		(id_dst_addr[4:0]),
		   .id_gpr_wen		(id_gpr_wen),
		   .id_mem_op		(id_mem_op[1:0]),
		   .ex_en		(ex_en),
		   .ex_dst_addr		(ex_dst_addr[4:0]),
		   .ex_gpr_wen		(ex_gpr_wen),
		   .ex_fwd_data		(ex_fwd_data[31:0]),
		   .mem_fwd_data	(mem_fwd_data[31:0]),
		   .exe_mode		(exe_mode),
		   .creg_rd_data	(creg_rd_data[31:0]));

  /* id_reg AUTO_TEMPLATE(
  );*/
  id_reg i_id_reg(/*AUTOINST*/
		  // Outputs
		  .id_pc		(id_pc[29:0]),
		  .id_en		(id_en),
		  .id_alu_op		(id_alu_op[3:0]),
		  .id_alu_in_0		(id_alu_in_0[31:0]),
		  .id_alu_in_1		(id_alu_in_1[31:0]),
		  .id_br_flag		(id_br_flag),
		  .id_mem_op		(id_mem_op[1:0]),
		  .id_mem_wdata		(id_mem_wdata[31:0]),
		  .id_ctrl_op		(id_ctrl_op[1:0]),
		  .id_dst_addr		(id_dst_addr[4:0]),
		  .id_gpr_wen		(id_gpr_wen),
		  .id_exp_code		(id_exp_code[2:0]),
		  // Inputs
		  .cpu_clk		(cpu_clk),
		  .cpu_rstn		(cpu_rstn),
		  .alu_op		(alu_op[3:0]),
		  .alu_in_0		(alu_in_0[31:0]),
		  .alu_in_1		(alu_in_1[31:0]),
		  .br_flag		(br_flag),
		  .mem_op		(mem_op[1:0]),
		  .mem_wdata		(mem_wdata[31:0]),
		  .ctrl_op		(ctrl_op[1:0]),
		  .dst_addr		(dst_addr[4:0]),
		  .gpr_wen		(gpr_wen),
		  .exp_code		(exp_code[2:0]),
		  .stall		(stall),
		  .flush		(flush),
		  .if_pc		(if_pc[29:0]),
		  .if_en		(if_en));


endmodule
//Local Variables:
//verilog-library-flags:(".")
//verilog-auto-inst-param-value:"t"
//End
