`timescale 1ns / 1ps

module RegFile(
  input clk, reset, rg_wrt_en,
  input [4:0] rg_wrt_addr, 
  input [4:0] rg_rd_addr1,
  input [4:0] rg_rd_addr2, 
  input [31:0] rg_wrt_data,
  output wire [31:0] rg_rd_data1,
  output wire [31:0] rg_rd_data2
);

reg [31:0] registers [0:31];
integer i;

initial begin
    i = 32'd0;
end

always @(posedge clk or posedge reset)
begin
    if (reset == 1'b1)
    begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] <= 32'h00000000;
    end
    else if (rg_wrt_en == 1'b1)
    begin
        registers[rg_wrt_addr] <= rg_wrt_data;
    end
end

assign rg_rd_data1 = registers[rg_rd_addr1];
assign rg_rd_data2 = registers[rg_rd_addr2];

endmodule