module bus_if(
  input cpu_clk,
  input cpu_rstn,
  input stall,
  input flush,
  output busy,
  input cpu_asn,
  input cpu_rw,
  input [29:0] cpu_addr,
  input [31:0] cpu_wdata,
  output logic [31:0] cpu_rdata,
  output logic spm_asn,
  output logic spm_rw,
  output logic [29:0] spm_addr,
  input [31:0] spm_wdata,
  output logic [31:0] spm_rdata,
  output logic bus_asn,
  output logic bus_rw,
  input bus_grntn,
  input bus_rdyn,
  output logic bus_reqn,
  output logic [29:0] bus_addr,
  output logic [31:0] bus_wdata,
  input [31:0] bus_rdata
);


  localparam BUS_IF_STATE_IDLE   = 'h0;
  localparam BUS_IF_STATE_REQ    = 'h1;
  localparam BUS_IF_STATE_ACCESS = 'h2;
  localparam BUS_IF_STATE_STALL  = 'h3;
  localparam ENABLE      = 'h0;
  localparam DISABLE     = 'h1;
  localparam WRITE       = 'h0;
  localparam READ        = 'h1;
  localparam BUS_SLAVE_1 = 'h1;

  
  logic [1:0]  state;
  logic [31:0] rd_buf;
  logic [2:0]  s_index;


  assign spm_rw    = cpu_rw;
  assign spm_addr  = cpu_addr;
  assign spm_wdata = cpu_wdata;


  always_ff @(posedge cpu_clk or negedge cpu_rstn) begin
    if(!cpu_rstn) begin
      state <= #1 BUS_IF_STATE_IDLE;
    end else begin
      case(state)
        BUS_IF_STATE_IDLE: begin
          if(flush=='b0 & cpu_asn==ENABLE & s_index!=BUS_SLAVE_1)
            state <= #1 BUS_IF_STATE_REQ;
        end
        BUS_IF_STATE_REQ: begin
          if(bus_grntn==ENABLE)
            state <= #1 BUS_IF_STATE_ACCESS;
        end
        BUS_IF_STATE_ACCESS: begin
          if(bus_rdyn==ENABLE) begin
            if(stall=='b1)
              state <= #1 BUS_IF_STATE_STALL;
            else
              state <= #1 BUS_IF_STATE_IDLE;
          end
        end
        BUS_IF_STATE_STALL: begin
          if(stall=='b0)
            state <= #1 BUS_IF_STATE_IDLE;
        end
        default: state <= #1 BUS_IF_STATE_IDLE;
      endcase
    end
  end

  always_ff @(posedge cpu_clk or negedge cpu_rstn) begin
    if(!cpu_rstn) begin
      bus_reqn  <= #1 DISABLE;
      bus_rw    <= #1 READ;
      bus_addr  <= #1 'h0;
      bus_wdata <= #1 'h0;
    end else begin
      case(state)
        BUS_IF_STATE_IDLE: begin
          if(flush=='b0 & cpu_asn==ENABLE & s_index!=BUS_SLAVE_1)
            bus_reqn  <= #1 ENABLE;
            bus_rw    <= #1 cpu_rw;
            bus_addr  <= #1 cpu_addr;
            bus_wdata <= #1 cpu_wdata;
        end
        BUS_IF_STATE_ACCESS: begin
          if(bus_rdyn==ENABLE) begin
            bus_reqn  <= #1 DISABLE;
            bus_rw    <= #1 READ;
            bus_addr  <= #1 'h0;
            bus_wdata <= #1 'h0;
          end
        end
        default: begin
          bus_reqn  <= #1 DISABLE;
          bus_rw    <= #1 READ;
          bus_addr  <= #1 'h0;
          bus_wdata <= #1 'h0;
        end
      endcase
    end
  end

  always_ff @(posedge cpu_clk or negedge cpu_rstn) begin
    if(!cpu_rstn) begin
      bus_asn <= #1 DISABLE;
    end else begin
      case(state)
        BUS_IF_STATE_REQ: begin
          if(bus_grntn==ENABLE)
            bus_asn <= #1 ENABLE;
        end
        BUS_IF_STATE_ACCESS: bus_asn <= #1 DISABLE;
        default: bus_asn <= #1 DISABLE;
      endcase
    end
  end

  always_ff @(posedge cpu_clk or negedge cpu_rstn) begin
    if(!cpu_rstn)
      rd_buf <= #1 'h0;
    else if(state==BUS_IF_STATE_ACCESS)
      rd_buf <= #1 bus_rdata;
  end

  always_comb begin
    if(cpu_rw==READ) begin
      case(state)
        BUS_IF_STATE_IDLE: begin
          if(flush=='b0 & cpu_asn==ENABLE & s_index==BUS_SLAVE_1 & stall=='b0)
            cpu_rdata = spm_rdata;
        end
        BUS_IF_STATE_ACCESS: begin
          if(bus_rdyn==ENABLE)
            cpu_rdata = bus_rdata;
        end
        BUS_IF_STATE_STALL: cpu_rdata = rd_buf;
        default: cpu_rdata = 'h0;
      endcase
    end else begin
      cpu_rdata = 'h0;
    end
  end

  always_comb begin
    case(state)
      BUS_IF_STATE_IDLE: begin
        if(flush=='b0 & cpu_asn==ENABLE & s_index!=BUS_SLAVE_1)
          busy = 'b1;
      end
      BUS_IF_STATE_REQ: busy = 'b1;
      BUS_IF_STATE_ACCESS: begin
        if(bus_rdyn==DISABLE)
          busy = 'b0;
      end
      default: busy = 'b0;
    endcase
  end

  assign spm_asn = (flush=='b0 & cpu_asn==ENABLE & s_index!=BUS_SLAVE_1 & stall=='b0 & state==BUS_IF_STATE_IDLE) ? ENABLE : 0;


endmodule
