module az_bus(/*AUTOARG*/
   // Outputs
   s_wdata, s_rw, s_asn, m_rdy, m_rdata, m0_grntn, m1_grntn, m2_grntn,
   m3_grntn, s_addr, s0_csn, s1_csn, s2_csn, s3_csn, s4_csn, s5_csn,
   s6_csn, s7_csn,
   // Inputs
   s7_rdy, s7_rdata, s6_rdy, s6_rdata, s5_rdy, s5_rdata, s4_rdy,
   s4_rdata, s3_rdy, s3_rdata, s2_rdy, s2_rdata, s1_rdy, s1_rdata,
   s0_rdy, s0_rdata, m3_wdata, m3_rw, m3_reqn, m3_asn, m3_addr,
   m2_wdata, m2_rw, m2_reqn, m2_asn, m2_addr, m1_wdata, m1_rw,
   m1_reqn, m1_asn, m1_addr, m0_wdata, m0_rw, m0_reqn, m0_asn,
   m0_addr, bus_rstn, bus_clk
   );
/*AUTOINPUT*/
// Beginning of automatic inputs (from unused autoinst inputs)
input logic		bus_clk;		// To i_bus_arbiter of bus_arbiter.v
input logic		bus_rstn;		// To i_bus_arbiter of bus_arbiter.v
input logic [29:0]	m0_addr;		// To i_bus_master_mux of bus_master_mux.v
input logic		m0_asn;			// To i_bus_master_mux of bus_master_mux.v
input logic		m0_reqn;		// To i_bus_arbiter of bus_arbiter.v
input logic		m0_rw;			// To i_bus_master_mux of bus_master_mux.v
input logic [31:0]	m0_wdata;		// To i_bus_master_mux of bus_master_mux.v
input logic [29:0]	m1_addr;		// To i_bus_master_mux of bus_master_mux.v
input logic		m1_asn;			// To i_bus_master_mux of bus_master_mux.v
input logic		m1_reqn;		// To i_bus_arbiter of bus_arbiter.v
input logic		m1_rw;			// To i_bus_master_mux of bus_master_mux.v
input logic [31:0]	m1_wdata;		// To i_bus_master_mux of bus_master_mux.v
input logic [29:0]	m2_addr;		// To i_bus_master_mux of bus_master_mux.v
input logic		m2_asn;			// To i_bus_master_mux of bus_master_mux.v
input logic		m2_reqn;		// To i_bus_arbiter of bus_arbiter.v
input logic		m2_rw;			// To i_bus_master_mux of bus_master_mux.v
input logic [31:0]	m2_wdata;		// To i_bus_master_mux of bus_master_mux.v
input logic [29:0]	m3_addr;		// To i_bus_master_mux of bus_master_mux.v
input logic		m3_asn;			// To i_bus_master_mux of bus_master_mux.v
input logic		m3_reqn;		// To i_bus_arbiter of bus_arbiter.v
input logic		m3_rw;			// To i_bus_master_mux of bus_master_mux.v
input logic [31:0]	m3_wdata;		// To i_bus_master_mux of bus_master_mux.v
input logic [31:0]	s0_rdata;		// To i_bus_slave_mux of bus_slave_mux.v
input logic		s0_rdy;			// To i_bus_slave_mux of bus_slave_mux.v
input logic [31:0]	s1_rdata;		// To i_bus_slave_mux of bus_slave_mux.v
input logic		s1_rdy;			// To i_bus_slave_mux of bus_slave_mux.v
input logic [31:0]	s2_rdata;		// To i_bus_slave_mux of bus_slave_mux.v
input logic		s2_rdy;			// To i_bus_slave_mux of bus_slave_mux.v
input logic [31:0]	s3_rdata;		// To i_bus_slave_mux of bus_slave_mux.v
input logic		s3_rdy;			// To i_bus_slave_mux of bus_slave_mux.v
input logic [31:0]	s4_rdata;		// To i_bus_slave_mux of bus_slave_mux.v
input logic		s4_rdy;			// To i_bus_slave_mux of bus_slave_mux.v
input logic [31:0]	s5_rdata;		// To i_bus_slave_mux of bus_slave_mux.v
input logic		s5_rdy;			// To i_bus_slave_mux of bus_slave_mux.v
input logic [31:0]	s6_rdata;		// To i_bus_slave_mux of bus_slave_mux.v
input logic		s6_rdy;			// To i_bus_slave_mux of bus_slave_mux.v
input logic [31:0]	s7_rdata;		// To i_bus_slave_mux of bus_slave_mux.v
input logic		s7_rdy;			// To i_bus_slave_mux of bus_slave_mux.v
// End of automatics
output logic        m0_grntn;
output logic        m1_grntn;
output logic        m2_grntn;
output logic        m3_grntn;
output logic [29:0] s_addr;
output logic        s0_csn;
output logic        s1_csn;
output logic        s2_csn;
output logic        s3_csn;
output logic        s4_csn;
output logic        s5_csn;
output logic        s6_csn;
output logic        s7_csn;
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output logic [31:0]	m_rdata;		// From i_bus_slave_mux of bus_slave_mux.v
output logic		m_rdy;			// From i_bus_slave_mux of bus_slave_mux.v
output logic		s_asn;			// From i_bus_master_mux of bus_master_mux.v
output logic		s_rw;			// From i_bus_master_mux of bus_master_mux.v
output logic [31:0]	s_wdata;		// From i_bus_master_mux of bus_master_mux.v
// End of automatics
/*AUTOINOUT*/
/*AUTOLOGIC*/


  /* bus_arbiter AUTO_TEMPLATE(
  );*/
  bus_arbiter i_bus_arbiter(/*AUTOINST*/
			    // Outputs
			    .m0_grntn		(m0_grntn),
			    .m1_grntn		(m1_grntn),
			    .m2_grntn		(m2_grntn),
			    .m3_grntn		(m3_grntn),
			    // Inputs
			    .bus_clk		(bus_clk),
			    .bus_rstn		(bus_rstn),
			    .m0_reqn		(m0_reqn),
			    .m1_reqn		(m1_reqn),
			    .m2_reqn		(m2_reqn),
			    .m3_reqn		(m3_reqn));


  /* bus_addr_dec AUTO_TEMPLATE(
  );*/
  bus_addr_dec i_bus_addr_dec(/*AUTOINST*/
			      // Outputs
			      .s0_csn		(s0_csn),
			      .s1_csn		(s1_csn),
			      .s2_csn		(s2_csn),
			      .s3_csn		(s3_csn),
			      .s4_csn		(s4_csn),
			      .s5_csn		(s5_csn),
			      .s6_csn		(s6_csn),
			      .s7_csn		(s7_csn),
			      // Inputs
			      .s_addr		(s_addr[29:0]));


  /* bus_master_mux AUTO_TEMPLATE(
  );*/
  bus_master_mux i_bus_master_mux(/*AUTOINST*/
				  // Outputs
				  .s_addr		(s_addr[29:0]),
				  .s_asn		(s_asn),
				  .s_rw			(s_rw),
				  .s_wdata		(s_wdata[31:0]),
				  // Inputs
				  .m0_addr		(m0_addr[29:0]),
				  .m0_asn		(m0_asn),
				  .m0_rw		(m0_rw),
				  .m0_wdata		(m0_wdata[31:0]),
				  .m0_grntn		(m0_grntn),
				  .m1_addr		(m1_addr[29:0]),
				  .m1_asn		(m1_asn),
				  .m1_rw		(m1_rw),
				  .m1_wdata		(m1_wdata[31:0]),
				  .m1_grntn		(m1_grntn),
				  .m2_addr		(m2_addr[29:0]),
				  .m2_asn		(m2_asn),
				  .m2_rw		(m2_rw),
				  .m2_wdata		(m2_wdata[31:0]),
				  .m2_grntn		(m2_grntn),
				  .m3_addr		(m3_addr[29:0]),
				  .m3_asn		(m3_asn),
				  .m3_rw		(m3_rw),
				  .m3_wdata		(m3_wdata[31:0]),
				  .m3_grntn		(m3_grntn));


  /* bus_slave_mux AUTO_TEMPLATE(
  );*/
  bus_slave_mux i_bus_slave_mux(/*AUTOINST*/
				// Outputs
				.m_rdata	(m_rdata[31:0]),
				.m_rdy		(m_rdy),
				// Inputs
				.s0_csn		(s0_csn),
				.s0_rdata	(s0_rdata[31:0]),
				.s0_rdy		(s0_rdy),
				.s1_csn		(s1_csn),
				.s1_rdata	(s1_rdata[31:0]),
				.s1_rdy		(s1_rdy),
				.s2_csn		(s2_csn),
				.s2_rdata	(s2_rdata[31:0]),
				.s2_rdy		(s2_rdy),
				.s3_csn		(s3_csn),
				.s3_rdata	(s3_rdata[31:0]),
				.s3_rdy		(s3_rdy),
				.s4_csn		(s4_csn),
				.s4_rdata	(s4_rdata[31:0]),
				.s4_rdy		(s4_rdy),
				.s5_csn		(s5_csn),
				.s5_rdata	(s5_rdata[31:0]),
				.s5_rdy		(s5_rdy),
				.s6_csn		(s6_csn),
				.s6_rdata	(s6_rdata[31:0]),
				.s6_rdy		(s6_rdy),
				.s7_csn		(s7_csn),
				.s7_rdata	(s7_rdata[31:0]),
				.s7_rdy		(s7_rdy));


endmodule
//Local Variables:
//verilog-library-flags:(".")
//verilog-auto-inst-param-value:"t"
//End
