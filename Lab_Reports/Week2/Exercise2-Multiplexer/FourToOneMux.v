`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ETHZ
// Engineer: svenp & zdavid
// 
// Create Date: 03/15/2019 11:12:27 PM
// Design Name: 
// Module Name: FourToOneMux
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


module FourToOneMux(input [3:0] in, input [1:0] control ,output out);
    wire [1:0] out1;

    TwoToOneMux t1 (.in(in[1:0]), .control(control[0]), .out(out1[0]));
    TwoToOneMux t2 (.in(in[3:2]), .control(control[0]), .out(out1[1]));

    TwoToOneMux together (.in(out1), .control(control[1]), .out(out));
endmodule
