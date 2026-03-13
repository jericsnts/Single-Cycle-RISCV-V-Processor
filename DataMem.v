`timescale 1ns / 1ps

module DataMem(
    input MemRead,
    input MemWrite,
    input [8:0] addr,
    input [31:0] write_data,
    output reg [31:0] read_data
);

reg [31:0] memory [0:127];

always @(*) begin
    if (MemWrite)
        memory[addr[8:2]] <= write_data;
end

always @(*) begin
    if (MemRead)
        read_data = memory[addr[8:2]];
    else
        read_data = 32'b0;
end

endmodule