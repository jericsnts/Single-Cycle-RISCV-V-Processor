`timescale 1ns / 1ps

module MUX21 (
    input  [31:0] D1,
    input  [31:0] D2,
    input         S,
    output [31:0] Y
);

assign Y = (~{32{S}} & D1) | ({32{S}} & D2);

endmodule