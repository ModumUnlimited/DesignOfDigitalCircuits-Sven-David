`timescale 1ns / 1ps



module TopModule(
    input clk,
    input reset,
    input left,
    input right,
    output reg [5:0] leds,
    //output reg [5:0] leds2,
    output reg LC,
    output reg LB,
    output reg LA,
    output reg RC,
    output reg RB,
    output reg RA);
    


wire clock;

// our clock:
clk_div cg(clk, reset, clock);


// all the different states we have
parameter STATE0 = 3'b000;
parameter STATE1 = 3'b001;
parameter STATE2 = 3'b010;
parameter STATE3 = 3'b011;
parameter STATE4 = 3'b100;
parameter STATE5 = 3'b101;
parameter STATE6 = 3'b110;
parameter STATE7 = 3'b111;

parameter dirNone = 2'b00;
parameter dirLeft = 2'b01;
parameter dirRight = 2'b10;


// led strengths
parameter FULL = 3'b111;
parameter ONEHALF = 3'b100;
parameter ONEQUARTER = 3'b010;
parameter ONEEIGHT = 3'b001;
parameter OFF = 3'b000;




// this stores the current state
reg[3:0] currentState;
reg[3:0] nextState;

reg [1:0] direction;
reg [1:0] nextDirection;


reg [2:0] led0 = 3'b000;
reg [2:0] led1  = 3'b000;
reg [2:0] led2  = 3'b000;
reg [2:0] led3  = 3'b000;
reg [2:0] led4 = 3'b000;
reg [2:0] led5 = 3'b000;

// we define the reset action
always @(posedge reset or posedge clock)
    begin
    if(reset)
        begin
            currentState <= STATE0;
            direction <= dirNone;/*
            led0 <= 3'b000;
            led1 <= 3'b000;
            led2 <= 3'b000;
            led3 <= 3'b000;
            led4 <= 3'b000;
            led5 <= 3'b000;*/
        end
    else if (clock) 
        begin
            currentState <= nextState;
            direction <= nextDirection;
        end
    end







// determine next state:
always @(*)
    begin
        nextState = STATE0; // this statements stops the verilog synthesizer of placing nextstate in a latch. (seen in UC Berkeley Verilog Tutorial)
        case (currentState)

            STATE0:
                begin
                   if(left==1'b1) 
                        begin
                            nextState = STATE1;
                            nextDirection = dirLeft;
                        end
                   else if(right==1'b1)
                        begin
                            nextState = STATE1;
                            nextDirection = dirRight;
                        end
                   else 
                        begin
                            nextState = STATE0;
                            nextDirection = dirNone;
                        end
                end
               
            STATE1: nextState = STATE2;
            STATE2: nextState = STATE3;
            STATE3: nextState = STATE4;
            STATE4: nextState = STATE5;
            STATE5: nextState = STATE6;
            STATE6: nextState = STATE7;
            STATE7:
                begin
                    nextState = STATE0;
                end

           
            default:
                begin
                    nextState = STATE0;
                    nextDirection = dirNone;
                end
            
       endcase
    end


/* old output logic
// output logic
always @(*)
    begin
    case (currentState)
            STATE0: leds = 6'b000000;
            
            STATE1A: leds = 6'b001000;
            STATE2A: leds = 6'b011000;
            STATE3A: leds = 6'b111000;
            STATE4A: leds = 6'b111000;
            STATE5A: leds = 6'b111000;
            STATE6A: leds = 6'b110000;
            STATE7A: leds = 6'b100000;
            
            STATE1B: leds = 6'b000100;
            STATE2B: leds = 6'b000110;
            STATE3B: leds = 6'b000111;
            STATE4B: leds = 6'b000111;
            STATE5B: leds = 6'b000111;
            STATE6B: leds = 6'b000011;
            STATE7B: leds = 6'b000001;

       endcase
    end
*/



// here we define our output logic

wire l0;
wire l1;
wire l2;
wire l3;
wire l4;
wire l5;

PMWLed pw0 (.clk(clk), .led(l0), .intensity(led0));
PMWLed pw1 (.clk(clk), .led(l1), .intensity(led1));
PMWLed pw2 (.clk(clk), .led(l2), .intensity(led2));
PMWLed pw3 (.clk(clk), .led(l3), .intensity(led3));
PMWLed pw4 (.clk(clk), .led(l4), .intensity(led4));
PMWLed pw5 (.clk(clk), .led(l5), .intensity(led5));


always @(clk)
    begin
        RC = l0;
        RB = l1;
        RA = l2;
        LA = l3;
        LB = l4;
        LC = l5;
    end


always @(*)
    begin
        case (currentState)
            STATE0: 
                begin
                    led0 = OFF; led1 = OFF; led2 = OFF; led3 = OFF; led4 = OFF; led5 = OFF; 
                    leds = 6'b000000;
                end
            STATE1: 
                begin
                    if(direction == dirLeft) 
                        begin
                            led0 = OFF; led1 = OFF; led2 = ONEHALF; led3 = OFF; led4 = OFF; led5=OFF;
                            leds = 6'b001000;
                        end
                    else
                        begin
                            led0 = OFF; led1 = OFF; led2 = OFF; led3 = ONEHALF; led4 = OFF; led5=OFF; 
                            leds = 6'b000100;
                        end
                end
            STATE2: 
                begin
                    if(direction == dirLeft) 
                        begin
                            led0 = OFF; led1 = ONEHALF; led2 = FULL; led3 = OFF; led4 = OFF; led5=OFF; 
                            leds = 6'b011000;
                        end
                    else
                        begin
                            led0 = OFF; led1 = OFF; led2 = OFF; led3 = FULL; led4 = ONEHALF; led5=OFF; 
                            leds = 6'b000110;
                        end
                end
            STATE3: 
                begin
                    if(direction == dirLeft) 
                        begin
                            led0 = ONEHALF; led1 = FULL; led2 = FULL; led3 = OFF; led4 = OFF; led5=OFF; 
                            leds = 6'b111000;
                        end
                    else
                        begin
                            led0 = OFF; led1 = OFF; led2 = OFF; led3 = FULL; led4 = FULL; led5=ONEHALF; 
                            leds = 6'b000111;
                        end
                end
            STATE4: 
                begin
                    if(direction == dirLeft) 
                        begin
                            led0 = FULL; led1 = FULL; led2 = FULL; led3 = OFF; led4 = OFF; led5=OFF; 
                            leds = 6'b111000;
                        end
                    else
                        begin
                            led0 = OFF; led1 = OFF; led2 = OFF; led3 = FULL; led4 = FULL; led5=FULL; 
                            leds = 6'b000111;
                        end
                end
            STATE5: 
                begin
                    if(direction == dirLeft) 
                        begin
                            led0 = FULL; led1 = FULL; led2 = ONEHALF; led3 = OFF; led4 = OFF; led5=OFF; 
                            leds = 6'b111000;
                        end
                    else
                        begin
                            led0 = OFF; led1 = OFF; led2 = OFF; led3 = ONEHALF; led4 = FULL; led5=FULL; 
                            leds = 6'b000111;
                        end
                end
            STATE6: 
                begin
                    if(direction == dirLeft) 
                        begin
                            led0 = FULL; led1 = ONEHALF; led2 = OFF; led3 = OFF; led4 = OFF; led5=OFF; 
                            leds = 6'b110000;
                        end
                    else
                        begin
                            led0 = OFF; led1 = OFF; led2 = OFF; led3 = OFF; led4 = ONEHALF; led5=FULL; 
                            leds = 6'b000011;
                        end
                end
            STATE7: 
                begin
                    if(direction == dirLeft) 
                        begin
                            led0 = ONEHALF; led1 = OFF; led2 = OFF; led3 = OFF; led4 = OFF; led5=OFF; 
                            leds = 6'b100000;
                        end
                    else
                        begin
                            led0 = OFF; led1 = OFF; led2 = OFF; led3 = OFF; led4 = OFF; led5=ONEHALF; 
                            leds = 6'b000001;
                        end
                end
            default: 
                begin
                    led0 = FULL; led1 = OFF; led2 = OFF; led3 = OFF; led4 = OFF; led5 = FULL; 
                    leds = 6'b101101;
                end
            
       endcase
    end




/* old logic: DO NOT USE


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
                    led1 = OUT;
                    led2 = ONEHALF;
                    led3 = OUT;
                    led4 = OUT;
                    led5 = OUT;
                end
           
            
    
                                 
             STATE3B: 
                begin
                    led0 = OUT;
                    led1 = OUT;
                    led2 = ONEHALF;
                    led3 = OUT;
                    led4 = OUT;
                    led5 = OUT;
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
                    led0 = FULL;
                    led1 = FULL;
                    led2 = ONEHALF;
                    led3 = OUT;
                    led4 = OUT;
                    led5 = OUT;
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
                end   
                               
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
*/


endmodule
