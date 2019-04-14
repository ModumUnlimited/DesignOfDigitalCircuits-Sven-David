`timescale 1ns / 1ps

module Alu(input [31:0]a, input [31:0]b, input [3:0]select, output [31:0]out, output flag);

wire [31:0]outFromArithmetic;
wire [31:0]outFromLogic;

reg [31:0]out = 32'b00000000000000000000000000000000;

ArithmeticUnit arithmetic(.a(a), .b(b), .select(select), .out(outFromArithmetic));
LogicUnit logic(.a(a), .b(b), .select(select), .out(outFromLogic));



wire [31:0] resultA;

Adder add(a,b,resultA);

reg [31:0]		slt;       
reg [31:0]		diff;

always @ ( *)
    if (select == 4'b1010)
    begin
        diff = (a-b);
        slt = 32'b0;
        //$display("%b", diff);
        if(diff[31] == 1'b1)
              slt = 32'b1;
        //slt = ((a < b));
    end		

always @(*)
    begin
        case(select)
            4'b0000: out = resultA; //Addition
            4'b0010: out = a - b; //Substraction
            4'b1010: out = slt;
            default: out = outFromLogic;
        endcase
    end
    
assign flag = (out==32'b0)? 1'b1 : 1'b0;





endmodule
