`timescale 1ns / 1ps

module Instr_mem(
    input [7:0] PC,
    input reset,
    output [7:0] Instruction_Code
    );
reg [7:0] Mem [7:0];
assign Instruction_Code = Mem[PC];

always @(reset)
begin
if(reset==0)
begin
Mem[0]=8'b00100011;
Mem[1]=8'b01100001;
Mem[2]=8'b00011100;
Mem[3]=8'b11000001;
Mem[4]=8'b01011011;
Mem[5]=8'b00001011;
end
end
endmodule
