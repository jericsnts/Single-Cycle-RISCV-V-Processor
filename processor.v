`timescale 1 ns / 1 ps

module processor(
    input clk,
    input reset,
    output [31:0] Result
);

wire [6:0] opcode;
wire [6:0] funct7;
wire [2:0] funct3;

wire reg_write;
wire mem2reg;
wire alu_src;
wire mem_write;
wire mem_read;

wire [1:0] ALUOp;
wire [3:0] Operation;


Controller CU (
    .Opcode(opcode),
    .ALUSrc(alu_src),
    .MemtoReg(mem2reg),
    .RegWrite(reg_write),
    .MemRead(mem_read),
    .MemWrite(mem_write),
    .ALUOp(ALUOp)
);

ALUController ALU_CU (
    .ALUOp(ALUOp),
    .Funct7(funct7),
    .Funct3(funct3),
    .Operation(Operation)
);

data_path DP (
    .clk(clk),
    .reset(reset),
    .reg_write(reg_write),
    .mem2reg(mem2reg),
    .alu_src(alu_src),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .alu_cc(Operation),

    .opcode(opcode),
    .funct7(funct7),
    .funct3(funct3),

    .alu_result(Result)
);

endmodule
