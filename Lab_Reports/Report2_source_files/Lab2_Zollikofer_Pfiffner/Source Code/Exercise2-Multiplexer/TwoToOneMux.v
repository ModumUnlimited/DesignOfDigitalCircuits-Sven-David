`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ETHZ
// Engineer: svenp & zdavid
//
// Create Date: 03/15/2019 11:08:20 PM
// Design Name: 
// Module Name: TwoToOneMux
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


module TwoToOneMux(input [1:0] in, input control ,output out);
    assign out = control ? in[0] : in[1];
endmodule
