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
//                 ALU description from Lab 5
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
    input  [3:0] aluop,
	input  [4:0] shamt,
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
  wire [31:0] srl;        // output of shifting b right by shamt positions
  reg  [31:0] lo;         // store the lower 32 bits of the multiplication
  wire [1:0] logicsel;    // lower two bits of aluop;

  // logic select 
  assign logicsel = aluop[1:0];
  assign logicout = (logicsel == 2'b00) ? a & b :
                    (logicsel == 2'b01) ? a | b :
						  (logicsel == 2'b10) ? a ^ b :
						                      ~(a | b) ;

  // adder subtractor
  assign n_b = ~b ;  // invert b
  assign sel_b = (aluop[1])? n_b : b ;
  assign addout = a + sel_b + aluop[1];
  
  
  // multiplication
    always @ ( * ) 
    begin
      if(aluop == 6'b011001)
        begin
            lo = a * b;   
        end
      if    (reset	  == 1'b1)
      begin
          lo = 32'b0;
      end
    end
  
  
  // set less than operator
  assign slt = {31'b0,addout[31]};
  
  
  // shift right logical
  /* 
  we take the input b as specified and use shift right logical
  -> see https://www.nandland.com/verilog/examples/example-shift-operator-verilog.html for documentation
  */
  assign srl = b >> shamt;
  
  // arith out
  /*
  for logic behind this see https://www.d.umn.edu/~gshute/mips/rtype.xhtml
  */
  assign arithout = (aluop[3]) ? slt : (aluop[1] ? srl :  addout);
  
  
  // final out
  assign result = (aluop == 6'b010010) ? lo : ((aluop[2]) ? logicout : arithout);
  // the zero
  assign zero = (result == 32'b0) ? 1: 0;
  
  
  
  
endmodule
