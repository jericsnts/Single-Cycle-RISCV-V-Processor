`timescale 1 ns / 1 ps

module Controller(
    input  [6:0] Opcode,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg [1:0] ALUOp
);

always @(*) begin

    case (Opcode)

        7'b0110011: begin
            ALUSrc   = 0;
            MemtoReg = 0;
            RegWrite = 1;
            MemRead  = 0;
            MemWrite = 0;
            ALUOp    = 2'b10;
        end

        7'b0010011: begin
            ALUSrc   = 1;
            MemtoReg = 0;
            RegWrite = 1;
            MemRead  = 0;
            MemWrite = 0;
            ALUOp    = 2'b00;
        end

        7'b0000011: begin
            ALUSrc   = 1;
            MemtoReg = 1;
            RegWrite = 1;
            MemRead  = 1;
            MemWrite = 0;
            ALUOp    = 2'b01;
        end

        7'b0100011: begin
            ALUSrc   = 1;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead  = 0;
            MemWrite = 1;
            ALUOp    = 2'b01;
        end

        default: begin
            ALUSrc   = 0;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead  = 0;
            MemWrite = 0;
            ALUOp    = 2'b00;
        end

    endcase

end

endmodule
