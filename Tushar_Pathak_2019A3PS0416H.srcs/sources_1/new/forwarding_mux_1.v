`timescale 1ns / 1ps
module forwarding_mux_1(
input [7:0] data1,
input [7:0] fwd_reg_val,
input [1:0]cntrl_sign,
output reg [7:0] out1
    );
    
always@(*)
begin
    if(cntrl_sign==2'b01||cntrl_sign==2'b11)
    begin
        assign out1 = fwd_reg_val;
    end
    else
    begin
        assign out1 = data1;
    end
end
endmodule
