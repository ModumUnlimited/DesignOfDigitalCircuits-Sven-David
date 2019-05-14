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
  input  [4:0] shamt,
  input reset,
  input clock,
  output [31:0] result,
  output zero
 );
  
  wire [31:0] logicout;   // output of the logic block
  wire [31:0] addout;     // adder subtractor out
  wire [31:0] arithout;   // output after alt
  wire [31:0] n_b;        // inverted b
  wire [31:0] sel_b;      // select b or n_b;
  wire [31:0] slt;        // output of the slt extension
  reg [31:0] lo;
  reg [31:0] hi;
  wire [1:0] logicsel;    // lower two bits of aluop;
  wire [31:0] srl;
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
  
  /*
 always @ ( * ) 
    begin
      if(aluop == 6'b011001)
        begin
            lo = a * b;   
        end
      if    (reset == 1'b1)
      begin
          lo = 32'b0;
      end
 end  
  */
  
    always @( * ) begin
      if (aluop == 6'b011001) 
        {hi,lo} = a * b;
      if (reset)
        lo = 32'b0;
   end
   
  // set less than operator
  assign slt = {31'b0,addout[31]};
  
  // arith out
  assign arithout = (aluop[3]) ? slt : addout;
  
  // shift right logical
  /* 
  we take the input b as specified and use shift right logical
  -> see https://www.nandland.com/verilog/examples/example-shift-operator-verilog.html for documentation
  */
  assign srl = b >> shamt;
  
  
  // final out
  wire [31:0] normalRes;
  wire [31:0] specialRes;
  wire [31:0] multRes;
  

  assign multRes = aluop[3] ? 32'b0 : lo;
  assign specialRes = (aluop[4]) ? multRes : srl;
  assign normalRes = (aluop[2]) ? logicout : arithout;
  assign result = aluop[5] ?  normalRes : specialRes;
  // the zero
  assign zero = (result == 32'b0) ? 1: 0;
  
endmodule
