`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:12:30 PM
// Design Name: 
// Module Name: ADD
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


module ADD(
    input [31:0] A, 
    input [31:0] B, 
    output [31:0] result
    );
    
    wire [4:0] res1;
    wire [4:0] res2;
    wire [4:0] res3;
    wire [4:0] res4;
    wire [4:0] res5;
    wire [4:0] res6;
    wire [4:0] res7;
    wire [4:0] res8;

    supply0 zeroCarryIn;
    
    FourBitAdder fba1 (A[3:0], B[3:0],zeroCarryIn , res1);
    FourBitAdder fba2 (A[7:4], B[7:4],res1[4] , res2);
    FourBitAdder fba3 (A[11:8], B[11:8],res2[4] , res3);
    FourBitAdder fba4 (A[15:12], B[15:12],res3[4] , res4);
    FourBitAdder fba5 (A[19:16], B[19:16],res4[4] , res5);
    FourBitAdder fba6 (A[23:20], B[23:20],res5[4] , res6);
    FourBitAdder fba7 (A[27:24], B[27:24],res6[4] , res7);
    FourBitAdder fba8 (A[31:28], B[31:28],res7[4] , res8);

    assign result[3:0] = res1[3:0];
    assign result[7:4] = res2[3:0];
    assign result[11:8] = res3[3:0];
    assign result[15:12] = res4[3:0];
    assign result[19:16] = res5[3:0];
    assign result[23:20] = res6[3:0];
    assign result[27:24] = res7[3:0];
    assign result[31:28] = res8[3:0];

    
endmodule