`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2019 10:51:49 PM
// Design Name: 
// Module Name: DisplayChooser
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


module DisplayChooser(input [1:0] chooser,output reg [3:0]AN);
    always @(*)
        case (chooser) 
            2'b00: AN = 4'b0111;
            2'b01: AN = 4'b1011;
            2'b10: AN = 4'b1101;
            2'b11: AN = 4'b1110;
        endcase
endmodule
