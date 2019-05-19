`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2019 00:31:37
// Design Name: 
// Module Name: 32Adder
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


module Adder32(input [31:0]a, input [31:0]b, output [31:0]out);
    
    //In order to add two 32 bit numbers using 4 bit adders we need 8 adders, thus 8 result wires
    wire [4:0]r1;
    wire [4:0]r2;
    wire [4:0]r3;
    wire [4:0]r4;
    wire [4:0]r5;
    wire [4:0]r6;
    wire [4:0]r7;
    wire [4:0]r8;
    
    //The first carry is obviously 0
    supply0 none;
    
    FourBitAdder a1 (.a(a[3:0]), .b(b[3:0]), .carryOne(none), .s(r1));
    FourBitAdder a2 (.a(a[7:4]), .b(b[7:4]), .carryOne(r1[4]), .s(r2));
    FourBitAdder a3 (.a(a[11:8]), .b(b[11:8]), .carryOne(r2[4]), .s(r3));
    FourBitAdder a4 (.a(a[15:12]), .b(b[15:12]), .carryOne(r3[4]), .s(r4));
    FourBitAdder a5 (.a(a[19:16]), .b(b[19:16]), .carryOne(r4[4]), .s(r5));
    FourBitAdder a6 (.a(a[23:20]), .b(b[23:20]), .carryOne(r5[4]), .s(r6));
    FourBitAdder a7 (.a(a[27:24]), .b(b[27:24]), .carryOne(r6[4]), .s(r7));
    FourBitAdder a8 (.a(a[31:28]), .b(b[31:28]), .carryOne(r7[4]), .s(r8));
    
    //Assign the output based on the calculations
    assign out = {r8[3:0],r7[3:0],r6[3:0],r5[3:0],r4[3:0],r3[3:0],r2[3:0],r1[3:0]};

endmodule
