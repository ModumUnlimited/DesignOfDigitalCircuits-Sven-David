`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2019 16:08:28
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


module Decoder(input [1:0]in, output reg[3:0]out);
    begin always @(*)
        case(in)
            2'b00: out = 4'b1110; 
            2'b01: out = 4'b1101;
            2'b11: out = 4'b1011;
            2'b10: out = 4'b0111;
        endcase
    end
endmodule
