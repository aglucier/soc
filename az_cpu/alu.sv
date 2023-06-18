module alu(
  input [31:0] in_0,
  input [31:0] in_1,
  input [3:0]  op,
  output logic [31:0] out,
  output logic        of
);


  localparam ALU_OP_NOP       = 'h0;
  localparam ALU_OP_AND       = 'h1;
  localparam ALU_OP_OR        = 'h2;
  localparam ALU_OP_XOR       = 'h3;
  localparam ALU_OP_ADDS      = 'h4;
  localparam ALU_OP_ADDU      = 'h5;
  localparam ALU_OP_SUBS      = 'h6;
  localparam ALU_OP_SUBU      = 'h7;
  localparam ALU_OP_SHRL      = 'h8;
  localparam ALU_OP_SHLL      = 'h9;


  logic signed [31:0] s_in_0, s_in_1;


  assign s_in_0 = $signed(in_0);
  assign s_in_1 = $signed(in_1);
  assign s_out  = $signed(out);

  always_comb begin
    case(op):
      ALU_OP_AND: out = in_0 & in_1;
      ALU_OP_OR : out = in_0 | in_1;
      ALU_OP_XOR: out = in_0 ^ in_1;
      ALU_OP_ADDS, ALU_OP_ADDU: out = in_0 + in_1;
      ALU_OP_SUBS, ALU_OP_SUBU: out = in_0 - in_1;
      ALU_OP_SHRL: out = in_0 >> in_1[4:0];
      ALU_OP_SHLL: out = in_0 << in_1[4:0];
      default: out = in_0;
    endcase
  end

  always_comb begin
    case(op):
      ALU_OP_ADDS: begin
        if((s_in_0>'h0 & s_in_1>'h0 & s_out<'h0) | (s_in_0<'h0 & s_in_1<'h0 & s_out>'h0))
          of = 'h1;
        else
          of = 'h0;
      end
      ALU_OP_SUBS: begin
        if((s_in_0<'h0 & s_in_1>'h0 & s_out>'h0) | (s_in_0>'h0 & s_in_1<'h0 & s_out<'h0))
          of = 'h1;
        else
          of = 'h0;
      end
      default: of = 'h0;
    endcase
  end


endmodule
