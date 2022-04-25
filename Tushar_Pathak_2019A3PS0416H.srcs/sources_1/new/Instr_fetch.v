`timescale 1ns / 1ps

module Instruction_Fetch(
    input clk,
    input reset,
    output [7:0] Instr_code
    );

reg [7:0]PC;
Instr_mem im(PC, reset, Instr_code);
wire [7:0]JumpAddress;
sign_extnd sx1(Instr_code[5:0],JumpAddress);
always@(posedge clk, negedge reset)
begin
	if(reset == 0)
		PC <= 0;
	else if(Instr_code[7:6]==2'b11)
		PC <= PC+1+JumpAddress;
    else
        PC <=PC+1;
end

endmodule
