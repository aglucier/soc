module ctrl(
  input        cpu_clk,
  input        cpu_rstn,
  input [4:0]  creg_raddr,
  output logic [31:0] creg_rdata,
  input        exe_mode,
  input [7:0]  irq,
  output logic int_detect,
  input [29:0] id_pc,
  input [29:0] mem_pc,
  input        mem_en,
  input        mem_br_flag,
  input [1:0]  mem_ctrl_op,
  input [4:0]  mem_dst_addr,
  input        mem_gpr_wen,
  input [2:0]  mem_exp_code,
  output logic [31:0] mem_out,
  input [31:0] if_busy,
  input        ld_hazard,
  input        mem_busy,
  output logic if_stall,
  output logic id_stall,
  output logic ex_stall,
  output logic mem_stall,
  output logic if_flush,
  output logic id_flush,
  output logic ex_flush,
  output logic mem_flush,
  output logic [29:0] new_pc
);


  localparam CTRL_OP_EXRT         = 'h2;
  localparam CTRL_OP_WRCR         = 'h1;
  localparam CREG_ADDR_STATUS     = 'h0;
  localparam CREG_ADDR_PRE_STATUS = 'h1;
  localparam CREG_ADDR_PC         = 'h2;
  localparam CREG_ADDR_EPC        = 'h3;
  localparam CREG_ADDR_EXP_VECTOR = 'h4;
  localparam CREG_ADDR_CAUSE      = 'h5;
  localparam CREG_ADDR_INT_MASK   = 'h6;
  localparam CREG_ADDR_IRQ        = 'h7;
  localparam CREG_ADDR_ROM_SIZE   = 'h1d;
  localparam CREG_ADDR_SPM_SIZE   = 'h1e;
  localparam CREG_ADDR_CPU_INFO   = 'h1f;


  logic stall, flush;


  assign stall      = if_busy | mem_busy;
  assign if_stall   = stall | ld_hazard;
  assign id_stall   = stall;
  assign ex_stall   = stall;
  assign mem_stall  = stall;
  assign if_flush   = flush;
  assign id_flush   = flush | ld_hazard;
  assign ex_flush   = flush;
  assign mem_flush  = flush;

  always_comb begin
    if(mem_en=='h1) begin
      if(mem_exp_code!='h0) begin
        new_pc = exp_vector;
        flush  = 'h1;
      end else if(mem_ctrl_op==CTRL_OP_EXRT) begin
        new_pc = epc;
        flush  = 'h1;
      end else if(mem_ctrl_op==CTRL_OP_WRCR) begin
        new_pc = mem_epc;
        flush  = 'h1;
      end
    end else begin
      new_pc = 'h0;
      flush  = 'h0;
    end
  end

  always_comb begin  
    if(int_en=='h1 & ((|((~mask)&irq))=='h1))
      int_detect = 'h1;
    else
      int_detect = 'h0;
  end

  always_comb begin
    case(creg_raddr)
      CREG_ADDR_STATUS    : creg_rd_data = {29'h0,int_en,exe_mode}; 
      CREG_ADDR_PRE_STATUS: creg_rd_data = {29'h0,pre_int_en,pre_exe_mode}; 
      CREG_ADDR_EPC       : creg_rd_data = {id_pc, 2'h0}; 
      CREG_ADDR_EXP_VECTOR: creg_rd_data = {exp_vector, 2'h0}; 
      CREG_ADDR_CAUSE     : creg_rd_data = {28'h0, dly_flag, exp_code}; 
      CREG_ADDR_INT_MASK  : creg_rd_data = {24'h0, mask}; 
      CREG_ADDR_IRQ       : creg_rd_data = {24'h0, irq}; 
      CREG_ADDR_ROM_SIZE  : creg_rd_data = $unsigned{ROM_SIZE}; 
      CREG_ADDR_SPM_SIZE  : creg_rd_data = $unsigned{SPM_SIZE}; 
      CREG_ADDR_CPU_INFO  : creg_rd_data = {RELESE_YEAR, RELESE_MONTH, RELESE_VERSION, RELEASE_REVERSION}; 
      default: creg_rd_data = 'h0;
    endcase
  end


  always_ff @(posedge cpu_clk or negedge cpu_rstn) begin
    if(!cpu_rstn) begin
      exe_mode     <= #1 'h0;
      int_en       <= #1 'h0;
      pre_exe_mode <= #1 'h0;
      pre_int_en   <= #1 'h0;
      exp_code     <= #1 'h0;
      mask         <= #1 {8{'h1}};
      dly_flag     <= #1 'h0;
      epc          <= #1 'h0;
      exp_vector   <= #1 'h0;
      pre_pc       <= #1 'h0;
      br_flag      <= #1 'h0;
    end else if(mem_en & !stall) begin
      pre_pc       <= #1 pre_pc;
      br_flag      <= #1 br_flag;
      if(mem_exp_code!='h0) begin
        exe_mode     <= #1 'h0;
        int_en       <= #1 'h0;
        pre_exe_mode <= #1 exe_mode;
        pre_int_en   <= #1 int_en;
        exp_code     <= #1 mem_exp_code;
        dly_flag     <= #1 br_flag;
        epc          <= #1 pre_pc;
      end else if(mem_ctrl_op==CTRL_OP_EXRT) begin
        exe_mode <= #1 pre_exe_mode;
        int_en   <= #1 pre_int_en;
      end else if(mem_ctrl_op==CTRL_OP_WRCR) begin
        case(mem_dst_addr):
          CREG_ADDR_STATUS: begin
            exe_mode <= #1 mem_out[0];
            int_en   <= #1 mem_out[1];
          end
          CREG_ADDR_PRE_STATUS: begin
            pre_exe_mode <= #1 mem_out[0];
            pre_int_en   <= #1 mem_out[1];
          end
          CREG_ADDR_EPC       : epc <= #1 mem_out[29:0];
          CREG_ADDR_EXP_VECTOR: exp_vector <= #1 mem_out[29:0];
          CREG_ADDR_CAUSE: begin
            dly_flag <= mem_out[3];
            exp_code <= mem_out[2:0];
          end
          CREG_ADDR_INT_MASK: mask <= #1 mem_out[7:0];
          default: begin
          end
        endcase 
      end
    end
  end

endmodule
