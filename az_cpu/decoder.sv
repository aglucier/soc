module decoder(
  input [29:0] if_pc,
  input [31:0] if_insn,
  input               if_en,
  input [31:0]        gpr_rdata_0,
  input [31:0]        gpr_rdata_1,
  output logic [4:0]        gpr_raddr_0,
  output logic [4:0]        gpr_raddr_1,
  input               id_en,
  input [4:0]         id_dst_addr,
  input               id_gpr_wen,
  input [1:0]         id_mem_op,
  input               ex_en,
  input [4:0]         ex_dst_addr,
  input               ex_gpr_wen,
  input [31:0]        ex_fwd_data,
  input [31:0]        mem_fwd_data,
  input               exe_mode,
  input [31:0]        creg_rd_data,
  output logic [4:0]  creg_rd_addr,
  output logic [3:0]  alu_op,
  output logic [31:0] alu_in_0,
  output logic [31:0] alu_in_1,
  output logic [29:0] br_addr,
  output logic        br_taken,
  output logic        br_flag,
  output logic [1:0]  mem_op,
  output logic [31:0] mem_wdata,
  output logic [1:0]  ctrl_op,
  output logic [4:0]  dst_addr,
  output logic        gpr_wen,
  output logic [2:0]  exp_code,
  output logic        ld_hazard,
);


  localparam REG_NUM          = 'd32;
  localparam REG_ADDR_W       = 'h5;
  localparam RegAddrBus       = 4:0;
  localparam CPU_IRQ_CH       = 'h8;
  localparam ALU_OP_W         = 'h4;
  localparam AluOpBus         = 3:0;
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
  localparam MEM_OP_W         = 2;
  localparam MemOpBus         = 1:0;
  localparam MEM_OP_NOP       = 'h0;
  localparam MEM_OP_LDW       = 'h1;
  localparam MEM_OP_STW       = 'h2;
  localparam CTRL_OP_W        = 'h2;
  localparam CtrlOpBus        = 1:0;
  localparam CTRL_OP_NOP      = 'h0;
  localparam CTRL_OP_WRCR     = 'h1;
  localparam CTRL_OP_EXRT     = 'h2;
  localparam CPU_EXE_MODE     = 'h1;
  localparam CpuExeModeBus    = 0:0;
  localparam CPU_KERNEL_MODE  = 'h0;
  localparam CPU_USER_MODE    = 'h1;
  localparam CREG_ADDR_STATUS = 'h0;
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
  localparam CregExeModeLoc       = 'h0;
  localparam CregIntEnableLoc     = 'h1;
  localparam CregExpCodeLoc       = 2:0;
  localparam CregDlyGlagLoc       = 3;
  localparam BusIfStateBus        = 1:0;
  localparam BUS_IF_STATE_IDLE    = 2'h0;
  localparam BUS_IF_STATE_REQ     = 2'h1;
  localparam BUS_IF_STATE_ACCESS  = 2'h2;
  localparam BUS_IF_STATE_STALL   = 2'h3;
  localparam RESET_VECTOR         = 'h0;
  localparam ShAmountBus          = 4:0;
  localparam ShAmountLoc          = 4:0;
  localparam RELEASE_YEAR         = 'd41;
  localparam RELEASE_MONTH        = 'd7;
  localparam RELEASE_VERSION      = 'd1;
  localparam RELEASE_REVISION     = 'd0;

  localparam ISA_NOP  = 'h0;
  localparam ISA_OP_W = 'd6;
  localparam IsaOpBus = 5:0;
  localparam IsaOpLoc = 31:26;
  localparam ISA_OP_ANDR  = 'h0;
  localparam ISA_OP_ANDI  = 'h1;
  localparam ISA_OP_ORR   = 'h2;
  localparam ISA_OP_ORI   = 'h3;
  localparam ISA_OP_XORR  = 'h4;
  localparam ISA_OP_XORI  = 'h5;
  localparam ISA_OP_ADDSR = 'h6;
  localparam ISA_OP_ADDSI = 'h7;
  localparam ISA_OP_ADDUR = 'h8;
  localparam ISA_OP_ADDUI = 'h9;
  localparam ISA_OP_SUBSR = 'ha;
  localparam ISA_OP_SUBUR = 'hb;
  localparam ISA_OP_SUBLR = 'hc;
  localparam ISA_OP_SUBLI = 'hd;
  localparam ISA_OP_SULLR = 'he;
  localparam ISA_OP_SULLI = 'hf;
  localparam ISA_OP_BE    = 'h10;
  localparam ISA_OP_BNE   = 'h11;
  localparam ISA_OP_BSGT  = 'h12;
  localparam ISA_OP_BUGT  = 'h13;
  localparam ISA_OP_JMP   = 'h14;
  localparam ISA_OP_CALL  = 'h15;
  localparam ISA_OP_LDW   = 'h16;
  localparam ISA_OP_STW   = 'h17;
  localparam ISA_OP_TRAP  = 'h18;
  localparam ISA_OP_RDCR  = 'h19;
  localparam ISA_OP_WRCR  = 'h1a;
  localparam ISA_OP_EXRT  = 'h1b;
  localparam ISA_REG_ADDR_W = 5;
  localparam IsaRegAddrBus  = 4:0;
  localparam IsaRaAddrLoc  = 25:21;
  localparam IsaRbAddrLoc  = 20:16;
  localparam IsaRcAddrLoc  = 15:11;
  localparam ISA_IMM_W     = 16;
  localparam ISA_EXT_W     = 16;
  localparam ISA_IMM_MSB   = 15;
  localparam IsaImmBus     = 15:0;
  localparam IsaImmLoc     = 15:0;
  localparam ISA_EXP_W     = 3;
  localparam IsaExpBus     = 2:0;
  localparam ISA_EXP_NO_EXP  = 'h0;
  localparam ISA_EXP_EXT_INT = 'h1;
  localparam ISA_EXP_UNDEF_INSN = 'h2;
  localparam ISA_EXP_OVERFLOW  = 'h3;
  localparam ISA_EXP_MISS_ALIGN = 'h4;
  localparam ISA_EXP_TRAP       = 'h5;
  localparam ISA_EXP_PRV_VIO    = 'h6;

  localparam ENABLEN  = 'h0;
  localparam DISABLEN = 'h1;


  logic signed [31:0] s_ra_data;
  logic signed [31:0] s_rb_data;


  assign op      = if_insn[IsaOpLoc];
  assign ra_addr = if_insn[IsaRaAddrLoc];
  assign rb_addr = if_insn[IsaRbAddrLoc];
  assign rc_addr = if_insn[IsaRcAddrLoc];
  assign imm     = if_insn[IsaImmLoc];
  assign imm_s   = {ISA_EXT_W{imm[ISA_IMM_MSB},imm};
  assign imm_u   = {ISA_EXT_W{'h0},imm};

  assign gpr_rd_addr_0 = ra_addr;
  assign gpr_rd_addr_1 = rb_addr;
  assign creg_rd_addr  = ra_addr;

  assign s_ra_data = $signed(ra_data);
  assign s_rb_data = $signed(rb_data);
  assign mem_wdata = rb_data;

  assign ret_addr  = if_pc + 'h1;
  assign br_target = if_pc + imm_s[29:0];
  assign jr_target = ra_data[29:0];


  always_comb begin
    if(id_en=='h1 & id_gpr_wen==ENABLEN & id_dst_addr==ra_addr)
      ra_data = ex_fwd_data;
    else if(ex_en=='h1 & ex_gpr_wen==ENABLEN & ex_dst_addr==ra_addr)
      ra_data = mem_fwd_data;
    else
      ra_data = gpr_rdata_0;
  end

  always_comb begin
    if(id_en=='h1 & id_gpr_wen==ENABLEN & id_dst_addr==rb_addr)
      rb_data = ex_fwd_data;
    else if(ex_en=='h1 & ex_gpr_wen==ENABLEN & ex_dst_addr==rb_addr)
      rb_data = mem_fwd_data;
    else
      ra_data = gpr_rdata_1;
  end

  assign id_hazard = (id_en=='h1 & id_mem_op==MEM_OP_LDW & (id_dst_addr==ra_addr | id_dst_addr==rb_addr)) ? 'h1 : 'h0;

  always_comb begin
    case(op)
      ISA_OP_ANDR , ISA_OP_ANDI : alu_op = ALU_OP_AND;
      ISA_OP_ORR  , ISA_OP_ORI  : alu_op = ALU_OP_OR;
      ISA_OP_XORR , ISA_OP_XORI : alu_op = ALU_OP_XOR;
      ISA_OP_ADDSR, ISA_OP_ADDSI: alu_op = ALU_OP_ADDS;
      ISA_OP_ADDUR, ISA_OP_ADDUI: alu_op = ALU_OP_ADDU;
      ISA_OP_SUBSR              : alu_op = ALU_OP_SUBS;
      ISA_OP_SUBUR              : alu_op = ALU_OP_SUBU;
      ISA_OP_SHRLR, ISA_OP_SHRLI: alu_op = ALU_OP_SHRL;
      ISA_OP_SHLLR, ISA_OP_SHLLI: alu_op = ALU_OP_SHLL;
      ISA_OP_LDW  , ISA_OP_STW  : alu_op = ALU_OP_ADDU;
      default: alu_op = ALU_OP_NOP;
    endcase
  end

  always_comb begin
    case(op)
      ISA_OP_ANDR , ISA_OP_ANDI , ISA_OP_ORR  , ISA_OP_ORI  , 
      ISA_OP_XORR , ISA_OP_XORI , ISA_OP_ADDSR, ISA_OP_ADDSI,
      ISA_OP_ADDUR, ISA_OP_ADDUI, ISA_OP_SUBSR, ISA_OP_SUBUR,
      ISA_OP_SHRLR, ISA_OP_SHRLI, ISA_OP_SHLLR, ISA_OP_SHLLI,
      ISA_OP_CALL,  ISA_OP_LDW: gpr_wen = ENABLEN;
      ISA_OP_RDCR: begin
        if(exe_mode==CPU_KERNEL_MODE)
          gpr_wen = ENABLEN;
      end
      default: gpr_wen = DISABLEN;
    endcase
  end
  
  always_comb begin
    case(op)
      ISA_OP_ANDR , ISA_OP_ORR  , ISA_OP_XORR , ISA_OP_ADDSR, 
      ISA_OP_ADDUR, ISA_OP_SUBSR, ISA_OP_SUBUR, ISA_OP_SHRLR, 
      ISA_OP_SHLLR, ISA_OP_CALL : dst_addr = rc_addr;
      default: dst_addr = rb_addr;
    endcase
  end

  always_comb begin
    case(op)
      ISA_OP_ANDR , ISA_OP_ANDI , ISA_OP_ORR  , ISA_OP_ORI  , 
      ISA_OP_XORR , ISA_OP_XORI , ISA_OP_ADDSR, ISA_OP_ADDSI,
      ISA_OP_ADDUR, ISA_OP_ADDUI, ISA_OP_SUBSR, ISA_OP_SUBUR,
      ISA_OP_SHRLR, ISA_OP_SHRLI, ISA_OP_SHLLR, ISA_OP_SHLLI,
      ISA_OP_CALL,  ISA_OP_LDW: gpr_wen = ENABLEN;
      ISA_OP_RDCR: begin
        if(exe_mode==CPU_KERNEL_MODE)
          gpr_wen = ENABLEN;
      end
      default: gpr_wen = DISABLEN;
    endcase
  end

  always_comb begin
    case(op)
      ISA_OP_ANDI , ISA_OP_ORI  , ISA_OP_XORI , ISA_OP_ADDSI, 
      ISA_OP_ADDUI, ISA_OP_SHRLI, ISA_OP_SHLLI, ISA_OP_LDW  , 
      ISA_OP_STW  : alu_in_1 = imm_s;
      default: alu_in_1 = rb_data;
    endcase
  end

  always_comb begin
    case(op)
      ISA_OP_CALL: alu_in_0 = {ret_addr, {2{'h0}}};
      ISA_OP_RDCR: begin
        if(exe_mode==CPU_KERNEL_MODE)
          alu_in_0 = creg_rd_data;
      end
      default: alu_in_0 = rb_data;
    endcase
  end

  always_comb begin
    case(op)
      ISA_OP_BE, ISA_OP_BNE, ISA_OP_BSGT, ISA_OP_BUGT: br_addr = br_target; 
      ISA_OP_JMP, ISA_OP_CALL:  br_addr = jr_target;
      default: br_addr = 'h0;
    endcase
  end

  always_comb begin
    case(op)
      ISA_OP_BE  : br_taken = (ra_data==rb_data) ? 'h1 : 'h0;   
      ISA_OP_BNE : br_taken = (ra_data!=rb_data) ? 'h1 : 'h0; 
      ISA_OP_BSGT: br_taken = (s_ra_data<s_rb_data) ? 'h1 : 'h0; 
      ISA_OP_BUGT: br_taken = (ra_data  < rb_data ) ? 'h1 : 'h0;
      ISA_OP_JMP, ISA_OP_CALL:  br_taken = 'h1;
      default: br_taken = 'h0;
    endcase
  end

  always_comb begin
    case(op)
      ISA_OP_BE  , ISA_OP_BNE , ISA_OP_BSGT, ISA_OP_BUGT, 
      ISA_OP_JMP, ISA_OP_CALL:  br_flag = 'h1;
      default: br_flag = 'h0;
    endcase
  end

  always_comb begin
    case(op)
      ISA_OP_LDW, ISA_OP_STW:  mem_op = MEM_OP_STW;
      default: mem_op = MEM_OP_NOP;
    endcase
  end

  always_comb begin
    case(op)
      ISA_OP_TRAP: exp_code = ISA_EXP_TRAP;
      ISA_OP_RDCR, ISA_OP_WRCR, ISA_OP_EXRT: exp_code = exe_mode==CPU_KERNEL_MODE ? ISA_EXP_NO_EXP : ISA_EXP_PRV_VIO;
      default: exp_code = ISA_EXP_UNDEF_INSN;
    endcase
  end


endmodule
