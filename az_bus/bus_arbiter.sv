module bus_arbiter
  input bus_clk,
  input bus_rstn,
  input        m0_reqn,
  input        m1_reqn,
  input        m2_reqn,
  input        m3_reqn,
  output logic m0_grntn,
  output logic m1_grntn,
  output logic m2_grntn,
  output logic m3_grntn
);


  localparam M0_GRNT = 'h0;
  localparam M1_GRNT = 'h1;
  localparam M2_GRNT = 'h2;
  localparam M3_GRNT = 'h3;
  localparam ENABLE  = 'h0;
  localparam DISABLE = 'h1;


  logic [1:0] bus_owner;


  always_ff @(posedge bus_clk or negedge bus_rstn) begin
    if(!bus_rstn) begin
      bus_owner <= #1 M0_GRNT;
    end else begin
      case(bus_owner)
        M0_GRNT: begin
          if(m0_reqn==ENABLE)
            bus_owner <= #1 M0_GRNT;
          else if(m1_reqn==ENABLE)
            bus_owner <= #1 M1_GRNT;
          else if(m2_reqn==ENABLE)
            bus_owner <= #1 M2_GRNT;
          else if(m3_reqn==ENABLE)
            bus_owner <= #1 M3_GRNT;
        end 
        M1_GRNT: begin
          if(m1_reqn==ENABLE)
            bus_owner <= #1 M1_GRNT;
          else if(m2_reqn==ENABLE)
            bus_owner <= #1 M2_GRNT;
          else if(m3_reqn==ENABLE)
            bus_owner <= #1 M3_GRNT;
          else if(m0_reqn==ENABLE)
            bus_owner <= #1 M0_GRNT;
        end 
        M2_GRNT: begin
          if(m2_reqn==ENABLE)
            bus_owner <= #1 M2_GRNT;
          else if(m3_reqn==ENABLE)
            bus_owner <= #1 M3_GRNT;
          else if(m0_reqn==ENABLE)
            bus_owner <= #1 M0_GRNT;
          else if(m1_reqn==ENABLE)
            bus_owner <= #1 M1_GRNT;
        end 
        M3_GRNT: begin
          if(m3_reqn==ENABLE)
            bus_owner <= #1 M3_GRNT;
          else if(m0_reqn==ENABLE)
            bus_owner <= #1 M0_GRNT;
          else if(m1_reqn==ENABLE)
            bus_owner <= #1 M1_GRNT;
          else if(m2_reqn==ENABLE)
            bus_owner <= #1 M2_GRNT;
        end 
        default: begin
          if(m0_reqn==ENABLE)
            bus_owner <= #1 M0_GRNT;
          else if(m1_reqn==ENABLE)
            bus_owner <= #1 M1_GRNT;
          else if(m2_reqn==ENABLE)
            bus_owner <= #1 M2_GRNT;
          else if(m3_reqn==ENABLE)
            bus_owner <= #1 M3_GRNT;
        end
      endcase
    end
  end

  always_comb begin
    if(bus_owner==M0_GRNT)
      m0_grntn = ENABLE;
    else
      m0_grntn = DISABLE;
  end

  always_comb begin
    if(bus_owner==M1_GRNT)
      m1_grntn = ENABLE;
    else
      m1_grntn = DISABLE;
  end

  always_comb begin
    if(bus_owner==M2_GRNT)
      m2_grntn = ENABLE;
    else
      m2_grntn = DISABLE;
  end

  always_comb begin
    if(bus_owner==M3_GRNT)
      m3_grntn = ENABLE;
    else
      m3_grntn = DISABLE;
  end


endmodule
