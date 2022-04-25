`timescale 1ns / 1ps
module forwarding_unit(
input [2:0]EX_MEM_Rd,
input [2:0]ID_EX_Rs1,
input [2:0]ID_EX_Rs2,
output reg [1:0]forward_signal,
input regwrite_EX_WB
    );
    always@(*)
    begin
    if(EX_MEM_Rd==ID_EX_Rs2&&regwrite_EX_WB==1)
    begin
    assign forward_signal=2'b10;
    end
    else if(EX_MEM_Rd==ID_EX_Rs1&&regwrite_EX_WB==1)
    begin
    assign forward_signal=2'b01;
    end
     else if(EX_MEM_Rd==ID_EX_Rs1 && EX_MEM_Rd==ID_EX_Rs2&&regwrite_EX_WB==1)
    begin
    assign forward_signal=2'b11;
    end
    else
    begin
    assign forward_signal=2'b00;
    end
    end
endmodule
