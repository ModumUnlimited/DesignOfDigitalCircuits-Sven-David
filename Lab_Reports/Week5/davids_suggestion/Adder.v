`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2019 09:07:54 PM
// Design Name: 
// Module Name: Adder
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


module Adder(
input [31:0]a, input [31:0]b, output [31:0] resultA);
    
    
    
// start logic for adder

wire [4:0] res1;
wire [4:0] res2;
wire [4:0] res3;
wire [4:0] res4;
wire [4:0] res5;
wire [4:0] res6;
wire [4:0] res7;
wire [4:0] res8;

supply0 zeroCarryIn;

FourBitAdder fba1 (a[3:0], b[3:0],zeroCarryIn , res1);
FourBitAdder fba2 (a[7:4], b[7:4],res1[4] , res2);
FourBitAdder fba3 (a[11:8], b[11:8],res2[4] , res3);
FourBitAdder fba4 (a[15:12], b[15:12],res3[4] , res4);
FourBitAdder fba5 (a[19:16], b[19:16],res4[4] , res5);
FourBitAdder fba6 (a[23:20], b[23:20],res5[4] , res6);
FourBitAdder fba7 (a[27:24], b[27:24],res6[4] , res7);
FourBitAdder fba8 (a[31:28], b[31:28],res7[4] , res8);

// to store the addition result

assign resultA[3:0] = res1[3:0];
assign resultA[7:4] = res2[3:0];
assign resultA[11:8] = res3[3:0];
assign resultA[15:12] = res4[3:0];
assign resultA[19:16] = res5[3:0];
assign resultA[23:20] = res6[3:0];
assign resultA[27:24] = res7[3:0];
assign resultA[31:28] = res8[3:0];

// end logic for adder



endmodule
