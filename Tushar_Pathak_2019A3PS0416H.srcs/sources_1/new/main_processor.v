`timescale 1ns / 1ps
module main_processor(
    input clk,
    input rst
    );
wire RegWrite;
wire [7:0]ALUResult;
wire ALUOperation,ALUOperation_ID_EX; 
wire [7:0]Data1;
wire [7:0]Data2;
wire ZeroFlag;
wire [7:0]instr_code;
wire [7:0]Instr_code_if_id;
wire RegWrite_ID_EX;
wire ALU_cntrl_id_ex;
wire [7:0]Data1_ID_EX;
wire [7:0]Data2_ID_EX;
wire [2:0] Rd_ID_EX;
wire RegWrite_EX_WB;
wire [7:0] ALU_res_EX_WB;
wire [2:0] Rd_EX_WB;
wire shift_cntrl;
wire [7:0]ALU_in_2;
wire [7:0]shamt_value;
wire [7:0]out1;
wire [7:0]out2;
wire [2:0]Rs1_ID_EX,Rs2_ID_EX;
wire [1:0]forward_cntrl;
wire [7:0]shamt_value_id_ex;
//instruction fetch block where i mem and extender are instantiated
Instruction_Fetch i_fetch(clk, rst, instr_code);
//the IF_ID register
IF_ID if_id(clk, rst, instr_code, Instr_code_if_id);
//control unit instantiation
control_unit c_unit(Instr_code_if_id[7:6],shift_cntrl,RegWrite, ALUOperation);
//register file
reg_file r_f(
Instr_code_if_id[5:3],
Instr_code_if_id[2:0],
Rd_EX_WB,
Data1,
Data2,
ALU_res_EX_WB,
RegWrite_EX_WB,rst);
//sign extender used forextending the last 3 bits to 8
sign_extnd_shamt sx2(Instr_code_if_id[2:0],shamt_value); 
//mux for alu input data 2
MUX mux_alu_input(shift_cntrl,Data2,shamt_value,ALU_in_2);
//ID_EX register
ID_EX id_ex(
RegWrite,ALUOperation,Data1,ALU_in_2,Instr_code_if_id[5:3],Instr_code_if_id[5:3],
Instr_code_if_id[2:0],
clk, rst,
RegWrite_ID_EX,ALU_cntrl_id_ex,Data1_ID_EX,
Data2_ID_EX,Rd_ID_EX,Rs1_ID_EX,Rs2_ID_EX);
//mux for forwarding/data 1
forwarding_mux_1 fwd1(Data1_ID_EX,ALU_res_EX_WB,forward_cntrl,out1);
//mux for forwarding/data2
forwarding_mux_2 fwd2(Data2_ID_EX,ALU_res_EX_WB,forward_cntrl,out2);
//main alu unit
ALU alu(ALU_cntrl_id_ex, out1, out2, ALUResult, ZeroFlag);
//EX_WB register
EX_WB ex_wb(RegWrite_ID_EX,ALUResult,Rd_ID_EX,RegWrite_EX_WB,ALU_res_EX_WB,Rd_EX_WB,clk,rst);
//main forwarding unit
forwarding_unit fwd_unt(Rd_EX_WB,Rs1_ID_EX,Rs2_ID_EX,forward_cntrl,RegWrite_EX_WB)
endmodule
