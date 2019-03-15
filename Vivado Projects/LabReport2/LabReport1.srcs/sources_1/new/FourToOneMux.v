`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2019 13:36:04
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


module FourToOneMux(input [3:0]in, input c[1:0], output o);
    
    //Logic
    wire [1:0]firstLayerChoice;
    
    Multiplexer muxOne(.in(in[1:0]), .c(c[0]), .o(firstLayerChoice[0]));
    Multiplexer muxTwo(.in(in[3:2]), .c(c[0]), .o(firstLayerChoice[1]));
    Multiplexer muxThree(.in(firstLayerChoice[1:0]), .c(c[1]), .o(o));

endmodule
