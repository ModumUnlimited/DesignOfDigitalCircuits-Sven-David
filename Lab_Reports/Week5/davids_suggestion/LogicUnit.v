`timescale 1ns / 1ps

module LogicUnit(input [31:0]a, input [31:0]b, input [3:0]select, output reg[31:0]out);

always @(*)
    begin
        case(select)
            4'b0100: out = a & b; //AND
            4'b0101: out = a | b; //OR
            4'b0110: out = a ^ b; //XOR
            4'b0111: out = ~ (a | b); //NOR
            default: out = a & b;
        endcase
    end

endmodule
