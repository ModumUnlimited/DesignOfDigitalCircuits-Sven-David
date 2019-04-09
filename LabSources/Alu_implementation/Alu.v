`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ETH Zurich
// Engineer: David Zollikofer, Sven Pfiffner
// 
// Create Date: 09.04.2019 19:10:58 
// Module Name: Alu
// Description: Arithmetic logic unit umplemented using the "seperated cell for A und L"
// design concept.
//////////////////////////////////////////////////////////////////////////////////


module Alu(input [31:0]a, input [31:0]b, input [3:0]select, output reg [31:0]out, output flag);

wire [31:0]outFromArithmetic;
wire [31:0]outFromLogic;

ArithmeticUnit arithmetic(.a(a), .b(b), .select(select), .out(outFromArithmetic));
LogicUnit logic(.a(a), .b(b), .select(select), .out(outFromLogic));


always @(*)
    begin
        case(select[2])
            1'b0: out = outFromLogic[31:0]; //Select from logic output
            1'b1: out = outFromArithmetic[31:0]; //Select from arithmetic output
        endcase
    end
    
assign flag = (out==32'b0)? 1'b1 : 1'b0;

endmodule
