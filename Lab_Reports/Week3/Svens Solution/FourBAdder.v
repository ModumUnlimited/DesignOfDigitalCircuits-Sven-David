`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2019 15:47:14
// Design Name: 
// Module Name: FourBAdder
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


module FourBAdder(input [3:0]a, input [3:0]b, output [4:0]s);
    supply0 carrryOne;
    wire carryTwo;
    wire carryThree;
    wire carryFour;
    FullAdder fullAdderOne(.a(a[0]), .b(b[0]), .ci(carryOne), .co(carryTwo), .s(s[0]));
    FullAdder fullAdderTwo(.a(a[1]), .b(b[1]), .ci(carryTwo), .co(carryThree), .s(s[1]));
    FullAdder fullAdderThree(.a(a[2]), .b(b[2]), .ci(carryThree), .co(carryFour), .s(s[2]));
    FullAdder fullAdderFour(.a(a[3]), .b(b[3]), .ci(carryFour), .co(s[4]), .s(s[3]));
endmodule
