`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:12:30 PM
// Design Name: 
// Module Name: SLT
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


module SLT(
    input [31:0] A, 
    input [31:0] B, 
    output [31:0] result
    );
    
    assign result = (A < B) ? 32'b11111111111111111111111111111111 : 32'b0;
    
endmodule
