`timescale 1ns / 1ps

module ArithmeticUnit(input [31:0]a, input [31:0]b, input [3:0]select, output [31:0]out);


reg[31:0] intermed;

always @(*)
    begin
        case(select)
            4'b0000:  intermed = a + b; //Addition
            4'b0010: intermed = a - b; //Substraction
            4'b1010: intermed = (a<b)? 32'd1: 32'd0; //SLT
            default: intermed = 'b0;
        endcase
    end

assign out = intermed;

endmodule
