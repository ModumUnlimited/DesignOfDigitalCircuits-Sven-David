`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2019 15:47:39
// Design Name: 
// Module Name: Top
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


module Top(input [3:0]a, input [3:0]b, input [1:0]dispCon, output overflow, output [0:6]D, output [3:0]AN);
    wire [4:0] result;
    wire [3:0] s;
    
    
    FourBAdder adder(.a(a),.b(b),.s(result));
    Decoder decoder(.in(dispCon), .out(AN));
    
    assign overflow = result[4];
    assign s = result[3:0];
    
    DisplayDriver disp(.in(s), .D(D));
    
endmodule
