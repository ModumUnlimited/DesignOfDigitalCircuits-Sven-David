`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2019 19:28:13
// Design Name: 
// Module Name: ArithmeticUnit
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


module ArithmeticUnit(input [31:0]a, input [31:0]b, input [3:0]select, output reg[31:0]out);

reg[31:0] slt;
reg[31:0] diff;

always @ ( *)
    if (select == 4'b1010)
    begin
        diff = (a-b);
        slt = 32'b0;
        //$display("%b", diff);
        if(diff[31] == 1'b1)
              slt = 32'b1;
        //slt = ((a < b));
end	

always @(*)
    begin
        case(select)
            4'b0000: out = a + b; //Addition
            4'b0010: out = a - b; //Substraction
            4'b1010: out = slt; //SLT
        endcase
    end

endmodule
