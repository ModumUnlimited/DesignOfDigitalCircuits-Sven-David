`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ETHZ
// Engineer: svenp & zdavid
// 
// Create Date: 15.03.2019 11:32:16
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


module Decoder(input [1:0] a, output [3:0] o);
     assign o[0] = a[0] & a[1];
     assign o[1] = (~a[0]) & a[1];
     assign o[2] = a[0] & (~a[1]);
     assign o[3] = (~a[0]) & (~a[1]);
endmodule
