module data_path #(
    parameter PC_W = 8,
    parameter INS_W = 32,
    parameter RF_ADDRESS = 5,
    parameter DATA_W = 32,
    parameter DM_ADDRESS = 9,
    parameter ALU_CC_W = 4
)(
    input                  clk ,
    input                  reset,      
    input                  reg_write,
    input                  mem2reg,
    input                  alu_src,
    input                  mem_write,
    input                  mem_read,
    input  [ALU_CC_W-1:0]  alu_cc,
    output         [6:0]   opcode,
    output         [6:0]   funct7,
    output         [2:0]   funct3,
    output  [DATA_W-1:0]   alu_result
);

wire [7:0] pc_current;
wire [7:0] pc_plus4;
wire [31:0] instruction;

wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] write_data;
wire [31:0] imm_ext;
wire [31:0] alu_src_mux;
wire [31:0] mem_read_data;

wire carry_out;
wire zero;
wire overflow;

assign pc_plus4 = pc_current + 8'd4;

FlipFlop PC (
    .clk(clk),
    .reset(reset),
    .d(pc_plus4),
    .q(pc_current)
);

InstMem IM (
    .addr(pc_current),
    .instruction(instruction)
);

assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];

RegFile RF (
    .clk(clk),
    .reset(reset),
    .rg_wrt_en(reg_write),
    .rg_wrt_addr(instruction[11:7]),
    .rg_rd_addr1(instruction[19:15]),
    .rg_rd_addr2(instruction[24:20]),
    .rg_wrt_data(write_data),
    .rg_rd_data1(read_data1),
    .rg_rd_data2(read_data2)
);

ImmGen IG (
    .InstCode(instruction),
    .ImmOut(imm_ext)
);

MUX21 ALU_SRC_MUX (
    .D1(read_data2),
    .D2(imm_ext),
    .S(alu_src),
    .Y(alu_src_mux)
);

alu_32 ALU_unit (
    .A_in(read_data1),
    .B_in(alu_src_mux),
    .ALU_Sel(alu_cc),
    .ALU_Out(alu_result),
    .Carry_Out(carry_out),
    .Zero(zero),
    .Overflow(overflow)
);

DataMem DM (
    .MemRead(mem_read),
    .MemWrite(mem_write),
    .addr(alu_result[8:0]),
    .write_data(read_data2),
    .read_data(mem_read_data)
);

MUX21 MEM2REG_MUX (
    .D1(alu_result),
    .D2(mem_read_data),
    .S(mem2reg),
    .Y(write_data)
);

endmodule