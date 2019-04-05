`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:12:30 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [3:0] aluOp,
    input [31:0] A, 
    input [31:0] B, 
    output reg [31:0] result,
    output zero
    );
    
    // we now define all the modules:
    
    wire[31:0] addWire;
    wire[31:0] subWire;
    wire[31:0] andWire;
    wire[31:0] orWire;
    wire[31:0] xorWire;
    wire[31:0] norWire;
    wire[31:0] sltWire;
    
    
    ADD addModule (.A(A),.B(B),.result(addWire));
    SUB subModule (.A(A),.B(B),.result(subWire));
    AND andModule (.A(A),.B(B),.result(andWire));
    OR orModule (.A(A),.B(B),.result(orWire));
    XOR xorModule (.A(A),.B(B),.result(xorWire));
    NOR norModule (.A(A),.B(B),.result(norWire));
    SLT sltModule (.A(A),.B(B),.result(sltWire));

    always @(*)
    begin
        // omission of this line might result n a latch!
        result = 32'b0;
        case(aluOp)
            4'b0000: result = addWire;// addition;
            4'b0010: result = subWire;// subtract;
            4'b0100: result = andWire;// and;
            4'b0101: result = orWire;// or;
            4'b0110: result = xorWire;// xor;
            4'b0111: result = norWire;// nor;
            4'b1010: result = sltWire;// slt;
            default: result = 32'b0;
        endcase
    end
    
    assign zero = (result == 32'b0) ? 1 : 0;
    
endmodule
