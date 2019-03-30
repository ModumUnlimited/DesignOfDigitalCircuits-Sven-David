`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2019 07:30:06 AM
// Design Name: 
// Module Name: PMWLed
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


module PMWLed(input clk, input[2:0] intensity, output led);

// internal variable for bookkeeping
reg[2:0] ledController;

//always @(posedge clk) cnt <= cnt + 1'b1;  // free-running counter

//assign PWM_out = (PWM_in > cnt);  // comparator

// we just add the intensity to the internal variable. If we overflow, we just start at 0 again
always @(posedge clk)
    ledController <= ledController + intensity;

// the first significant bit tells us if we should turn the led off.
assign led = (intensity == 3'b111) ? 1'b1 :  ((intensity == 3'b000) ? 1'b0 : (ledController == 3'b000));


endmodule
