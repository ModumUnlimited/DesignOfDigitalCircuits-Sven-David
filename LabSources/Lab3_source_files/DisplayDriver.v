`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2019 10:23:38 AM
// Design Name: 
// Module Name: DisplayDriver
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


module DisplayDriver(input [3:0]in, output reg[0:6]D);
// this case block will translate into a very efficient circtuit. We are checking all cases.
begin always @(*)
    case (in) 
        4'b0000: D = 7'b0000001;
        4'b0001: D = 7'b1001111;
        4'b0010: D = 7'b0010010;
        4'b0011: D = 7'b0000110;
        4'b0100: D = 7'b1001100;
        4'b0101: D = 7'b0100100;
        4'b0110: D = 7'b0100000;
        4'b0111: D = 7'b0001111;
        4'b1000: D = 7'b0000000;
        4'b1001: D = 7'b0000100;
        4'b1010: D = 7'b0001000;
        4'b1011: D = 7'b1100000;
        4'b1100: D = 7'b0110001;
        4'b1101: D = 7'b1000010;
        4'b1110: D = 7'b0110000;
        4'b1111: D = 7'b0111000;
    endcase
end

endmodule
