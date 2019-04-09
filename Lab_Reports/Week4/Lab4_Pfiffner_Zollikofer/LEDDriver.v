`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2019 01:11:29 PM
// Design Name: 
// Module Name: LEDDriver
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


module LEDDriver(
input [3:0] currentState,
input clk,
output [5:0] leds
    );
    
    
//zero state
parameter STATE0 = 4'b1000;

//left sequence
parameter STATE1A = 4'b0001;
parameter STATE2A = 4'b0010;
parameter STATE3A = 4'b0011;
parameter STATE4A = 4'b0100;
parameter STATE5A = 4'b0101;
parameter STATE6A = 4'b0110;
parameter STATE7A = 4'b0111;

//right sequence
parameter STATE1B = 4'b1001;
parameter STATE2B = 4'b1010;
parameter STATE3B = 4'b1011;
parameter STATE4B = 4'b1100;
parameter STATE5B = 4'b1101;
parameter STATE6B = 4'b1110;
parameter STATE7B = 4'b1111;

// led strengths
parameter FULL = 3'b111;
parameter ONEHALF = 3'b100;
parameter ONEQUARTER = 3'b010;
parameter ONEEIGHT = 3'b001;
parameter OUT = 3'b000;
    


reg [2:0] led0;
reg [2:0] led1;
reg [2:0] led2;
reg [2:0] led3;
reg [2:0] led4;
reg [2:0] led5;

PMWLed pw0 (.clk(clk), .led(leds[0]), .intensity(led0));
PMWLed pw1 (.clk(clk), .led(leds[1]), .intensity(led1));
PMWLed pw2 (.clk(clk), .led(leds[2]), .intensity(led2));
PMWLed pw3 (.clk(clk), .led(leds[3]), .intensity(led3));
PMWLed pw4 (.clk(clk), .led(leds[4]), .intensity(led4));
PMWLed pw5 (.clk(clk), .led(leds[5]), .intensity(led5));





always @(*)
    begin
    case (currentState)
            STATE0: 
                begin
                    led0 = OUT;
                    led1  = OUT;
                    led2 = OUT;
                    led3 = OUT;
                    led4 = OUT;
                    led5 = OUT;
                end
            
            STATE1A: 
                begin
                    led0 = OUT;
                    led1 = OUT;
                    led2 = OUT;
                    led3 = ONEHALF;
                    led4 = OUT;
                    led5 = OUT;
                end
                
            STATE2A:
                begin
                    led0 = OUT;
                    led1 = OUT;
                    led2 = OUT;
                    led3 = FULL;
                    led4 = ONEHALF;
                    led5 = OUT;
                end
            
             STATE3A: 
                begin
                    led0 = OUT;
                    led1 = OUT;
                    led2 = OUT;
                    led3 = FULL;
                    led4 = FULL;
                    led5 = ONEHALF;
                end

             STATE4A: 
                begin
                    led0 = OUT;
                    led1 = OUT;
                    led2 = OUT;
                    led3 = FULL;
                    led4 = FULL;
                    led5 = FULL;
                end 
                
             STATE5A: 
                begin
                    led0 = OUT;
                    led1 = OUT;
                    led2 = OUT;
                    led3 = ONEHALF;
                    led4 = FULL;
                    led5 = FULL;
                end
                
             STATE6A: 
                begin
                    led0 = OUT;
                    led1 = OUT;
                    led2 = OUT;
                    led3 = OUT;
                    led4 = ONEHALF;
                    led5 = FULL;
                end                                

             STATE7A: 
                begin
                    led0 = OUT;
                    led1 = OUT;
                    led2 = OUT;
                    led3 = OUT;
                    led4 = OUT;
                    led5 = ONEHALF;
                end 
                
                          
                
            STATE1B: 
                begin
                    led0 = OUT;
                    led1 = OUT;
                    led2 = ONEHALF;
                    led3 = OUT;
                    led4 = OUT;
                    led5 = OUT;
                end
           

            STATE2B: 
                begin
                    led0 = OUT;
                    led1 = ONEHALF;
                    led2 = FULL;
                    led3 = OUT;
                    led4 = OUT;
                    led5 = OUT;
                end
            
            /*
   
             STATE3B: 
                begin
                    led0 = ONEHALF;
                    led1 = FULL;
                    intensity[8:6] = FULL;
                    intensity[11:9] = OUT;
                    intensity[14:12] = OUT;
                    intensity[17:15] = OUT;
                end

             STATE4B: 
                begin
                    intensity[2:0] = FULL;
                    intensity[5:3] = FULL;
                    intensity[8:6] = FULL;
                    intensity[11:9] = OUT;
                    intensity[14:12] = OUT;
                    intensity[17:15] = OUT;
                end 
                
             STATE5B: 
                begin
                    intensity[2:0] = FULL;
                    intensity[5:3] = FULL;
                    intensity[8:6] = ONEHALF;
                    intensity[11:9] = OUT;
                    intensity[14:12] = OUT;
                    intensity[17:15] = OUT;
                end
                
             STATE6B: 
                begin
                    led0 = FULL;
                    led1 = ONEHALF;
                    led2 = OUT;
                    led3 = OUT;
                    led4 = OUT;
                    led5 = OUT;
                end                                

             STATE7B: 
                begin
                    intensity[2:0] = ONEHALF;
                    intensity[5:3] = OUT;
                    intensity[8:6] = OUT;
                    intensity[11:9] = OUT;
                    intensity[14:12] = OUT;
                    intensity[17:15] = OUT;
                end   */
                               
           default: 
                begin
                    led0 = OUT;
                    led1  = OUT;
                    led2 = FULL;
                    led3 = FULL;
                    led4 = OUT;
                    led5 = OUT;
                end

       endcase
    end


/*
PMWLed pw1 (.clk(clk), .led(led1), .intensity(3'b100));
PMWLed pw2 (.clk(clk), .led(led2), .intensity(3'b010));
PMWLed pw3 (.clk(clk), .led(led3), .intensity(3'b001));
PMWLed pw4 (.clk(clk), .led(led4), .intensity(3'b111));
*/

    
endmodule
