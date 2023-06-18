module mem_ctrl(
  input ex_en,
  input [1:0]  ex_mem_op,
  input [31:0] ex_mem_wdata,
  input [31:0] ex_out,
  input [31:0] rd_data,
  output logic [29:0] addr,
  output logic        asn,
  output logic        rw,
  output logic [31:0] wdata,
  output logic [31:0] out,
  output logic        miss_align
);


  localparam MEM_OP_LDW = 'h1;
  localparam MEM_OP_STW = 'h2;
  localparam ENABLEN    = 'h0;
  localparam DISENABLEN = 'h1;


  assign wdata  = ex_mem_wdata;
  assign addr   = ex_out[29:0];
  assign offset = ex_out[1:0];

  always_comb begin
    if(ex_en=='h1) begin
      case(ex_mem_op)
        MEM_OP_LDW, MEM_OP_STW: begin
          if(offset=='h0)
            asn = ENABLEN;
          else 
            miss_align = 'h1;
        end
        default: begin
          asn = DISENABLEN;
          miss_align = 'h0;
        end
      endcase
    end
  end

  always_comb begin
    if(ex_en=='h1) begin
      case(ex_mem_op)
        MEM_OP_LDW: out = (offset=='h0) ? rd_data : 'h0;
        default: out = ex_out;
      endcase
    end
  end

  always_comb begin
    if(ex_en=='h1) begin
      case(ex_mem_op)
        MEM_OP_STW: rw = (offset=='h0) ? 'h1 : 'h0;
        default: rw = 'h0;
      endcase
    end
  end


endmodule
