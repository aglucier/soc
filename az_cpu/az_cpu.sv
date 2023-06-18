module az_cpu(
  /*AUTOINPUT*/
  /*AUTOOUTPUT*/
);


  /* if_stage AUTO_TEMPLATE(
    .bus_rdata(if_bus_rdata),
    .bus_rdyn (if_bus_rdyn),
    .bus_grnt (if_bus_grntn),
    .bus_reqn (if_bus_reqn),
  );*/
  if_stage i_if_stage(/*AUTOINST*/);

  /* id_stage AUTO_TEMPLATE(
  );*/
  id_stage i_id_stage(/*AUTOINST*/);

  /* spm AUTO_TEMPLATE(
  );*/
  spm i_spm(/*AUTOINST*/);

  /* ex_stage AUTO_TEMPLATE(
  );*/
  ex_stage i_ex_stage(/*AUTOINST*/);

  /* gpr AUTO_TEMPLATE(
  );*/
  gpr i_gpr(/*AUTOINST*/);

  /* mem_stage AUTO_TEMPLATE(
  );*/
  mem_stage i_mem_stage(/*AUTOINST*/);

  /* ctrl AUTO_TEMPLATE(
  );*/
  ctrl i_ctrl(/*AUTOINST*/);


endmodule
//Local Variables:
//verilog-library-flags:(".")
//verilog-auto-inst-param-value:"t"
//End
