`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2019 19:28:13
// Design Name: 
// Module Name: ArithmeticUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ArithmeticUnitOwnAdder(input [31:0]a, input [31:0]b, input [3:0]select, output reg[31:0]out);

wire [31:0]addOut;

//Own adder module
Adder32 adder(.a(a), .b(b), .out(addOut));

always @(*)
    begin
        case(select)
            4'b0000: out = addOut; //Addition
            4'b0010: out = a - b; //Substraction
            4'b1010: out = (a<b)? 32'd1: 32'd0; //SLT
        endcase
    end

endmodule
