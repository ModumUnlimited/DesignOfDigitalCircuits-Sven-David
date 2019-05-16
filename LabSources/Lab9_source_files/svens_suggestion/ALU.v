`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  ETH Zurich
// Engineer: Frank K. Gurkaynak
// 
// Create Date:    12:51:05 03/17/2011 
// Design Name:    MIPS processor
// Module Name:    ALU 
// Project Name:   Digital Circuits Lab Exercuse
// Target Devices: 
// Tool versions: 
// Description:    This is one possible solution to the
//                 ALU description from Lab5a
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU( 
  input  [31:0] a,
  input  [31:0] b,
  input  [5:0] aluop,
  input  [5:0] shamt,
  input  reset,
  input  clock,
  output [31:0] result,
  output zero
 );
  
  wire [31:0] logicout;   // output of the logic block
  wire [31:0] addout;     // adder subtractor out
  wire [31:0] arithout;   // output after alt
  wire [31:0] n_b;        // inverted b
  wire [31:0] sel_b;      // select b or n_b;
  wire [31:0] slt;        // output of the slt extension
  wire [31:0] srl;        // output of the srl extension
  wire [31:0] multu;      // output of the multu extension
  reg  [31:0] lo;         // Will store least significant bits of multiplication
                          // Note that by the specifications in the exercise, hi is not needed here
  wire [1:0] logicsel;    // lower two bits of aluop;
  
  // logic select 
  assign logicsel = aluop[1:0];
  assign logicout = (logicsel == 2'b00) ? a & b :
                    (logicsel == 2'b01) ? a | b :
                    (logicsel == 2'b10) ? a ^ b :
                                        ~(a | b);
  
  // adder subtractor
  assign n_b = ~b ;  // invert b
  assign sel_b = (aluop[1])? n_b : b ;
  assign addout = a + sel_b + aluop[1];
  
  always@(*)
    begin
        if(aluop == 6'b011001) //If aluop indicates multu
            lo = a*b; //Write a * b into hi and lo
        if(reset) //If reset signal occurs
            lo = 32'b0; //Reset lo to all 0
    end
  
  // Assign right shift by shamt
  assign srt = b >> shamt;
  
  // Assign multu based on aluop
  assign multu = aluop[3] ? 32'b0 : lo;
  
  // set less than operator
  assign slt = {31'b0,addout[31]};
  
  // arith out
  assign arithout = (aluop[3]) ? slt : addout;
  
  // final out
  wire [31:0] standardAlu;
  wire [31:0] extendedAlu;
  //wire [31:0] 
  
  assign standardAlu = (aluop[2]) ? logicout : arithout; //Get result based on standard alu ops 
  assign extendedAlu = (aluop[4]) ? multu : srl;
  assign result = aluop[5] ? standardAlu : extendedAlu; // Op signal 5 determines which module is used
  // the zero
  assign zero = (result == 32'b0) ? 1: 0;
  
endmodule
