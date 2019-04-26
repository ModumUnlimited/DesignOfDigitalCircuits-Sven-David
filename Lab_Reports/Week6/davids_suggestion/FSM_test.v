`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: ETH Zurich
// Engineer: Original Author: Frank K. Gurkaynak - Changed by Sven Pfiffner and David Zollikofer
//
// Create Date:   15:24:03 03/17/2011
// Design Name:   alu
// Module Name:   ALU_test.v
// Project Name:  Lab5b
// Target Device:  
// Tool versions:  
// Description: Simple testbench to test the ALU
//
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FSM_test;


   // the reset signal we will pass to the fsm
   reg reset = 1'b0;
   // the left button we will pass to the fsm
   reg left = 1'b0;
   // the right signal we will pass to the fsm
   reg right = 1'b0;
   // the "virtual" leds that we pass to the fsm
   wire [5:0]leds;
   
   // Test clock 
   reg			clk ; // in this version we do not really need the clock


   // The test clock generation
   always				// process always triggers
	begin
		clk=1; #1;		// clk is 1 for 1 ns 
		clk=0; #1;		// clk is 0 for 1 ns
	end					// generate a 2 ns clock


      
   // Initialization
	initial
	begin
        // we apply the reset signal and wait 10 ns.
        reset = 1'b1; #10;
        // lift reset signal -> device should have reset
        reset = 1'b0; 
        // wait for 30ns
        #30;
        // press left button for 1 ns
        left = 1'b1; #1;
        // lift left button
        left = 1'b0; 
        // wait for sequence to complete
        #400;
        // press right button for 1 ns.
        right = 1'b1; #1;
        right = 1'b0;

	end
   

   // this is the device under test.   
   TopModule deviceUnderTest(.reset(reset), .clk(clk),  .left(left), .right(right), .leds(leds));
   
endmodule