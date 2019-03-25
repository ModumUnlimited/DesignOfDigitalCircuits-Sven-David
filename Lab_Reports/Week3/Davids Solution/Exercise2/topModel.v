`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2019 11:20:41 AM
// Design Name: 
// Module Name: topModel
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


module topModel(input [3:0]a, input [3:0]b, input [1:0]chooser , output overflow, output [0:6]D, output [3:0]AN);
    // internal wires to connect components
    wire [4:0] result;
    wire [3:0] s;
        
    DisplayChooser dispChooser(.chooser(chooser), .AN(AN));
    
    // the four bit adder will do the addition
    FourBitAdder adder(.a(a),.b(b),.s(result));
    
    // split result into displayable and overfloe^w
    assign overflow = result[4];
    assign s = result[3:0];
    
    //give output to displaydriver
    DisplayDriver disp(.in(s), .D(D));
endmodule
