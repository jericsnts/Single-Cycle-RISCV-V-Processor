`timescale 1 ns / 1 ps

module ALUController(
    input  [1:0] ALUOp,
    input  [6:0] Funct7,
    input  [2:0] Funct3,
    output reg [3:0] Operation
);

always @(*) begin

    case(ALUOp)

        2'b00: begin
            case(Funct3)
                3'b111: Operation = 4'b0000; // ANDI
                3'b110: Operation = 4'b0001; // ORI
                3'b100: Operation = 4'b1100; // NORI
                3'b010: Operation = 4'b0111; // SLTI
                3'b000: Operation = 4'b0010; // ADDI
                default: Operation = 4'b0000;
            endcase
        end

        2'b01: begin
            Operation = 4'b0010; // ADD
        end

        2'b10: begin
            case({Funct7, Funct3})

                {7'b0000000,3'b111}: Operation = 4'b0000; // AND
                {7'b0000000,3'b110}: Operation = 4'b0001; // OR
                {7'b0000000,3'b100}: Operation = 4'b1100; // NOR
                {7'b0000000,3'b010}: Operation = 4'b0111; // SLT
                {7'b0000000,3'b000}: Operation = 4'b0010; // ADD
                {7'b0100000,3'b000}: Operation = 4'b0110; // SUB
                default: Operation = 4'b0000;
            endcase
        end

        default: Operation = 4'b0000;

    endcase

end

endmodule