`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ETHZ
// Engineer: svenp & zdavid
// 
// Create Date: 03/15/2019 10:26:40 PM
// Design Name: 
// Module Name: Decoder
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



// design manually verified.

module Decoder(input [1:0] in, output [3:0] out);
    assign out[0] = ~in[0] & ~in[1];
    assign out[1] = in[0] & ~in[1];
    assign out[2] = ~in[0] & in[1];
    assign out[3] = in[0] & in[1];
endmodule
