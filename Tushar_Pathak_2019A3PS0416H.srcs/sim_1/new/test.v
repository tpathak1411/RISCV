`timescale 1ns / 1ps

module test;
	reg clk;
	reg rst;

	main_processor m1 (.clk(clk),.rst(rst));

	initial begin
	clk = 0;
forever #10 clk = ~clk;
end

initial begin
rst = 1;
#5 rst = 0;#10
rst = 1;
#200;
$finish; 
end  
endmodule

