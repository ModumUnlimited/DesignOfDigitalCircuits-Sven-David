module TopModule(
    input reset,
    input clk,
    input left,
    input right,
    output reg [5:0]leds
    );
    

wire clock;

// our clock:
clk_div cg(clk, reset, clock);


// we define all states:
parameter STATE0 = 4'b0000;
parameter STATE1 = 4'b0001;
parameter STATE2 = 4'b0011;
parameter STATE3 = 4'b0111;
parameter STATE4 = 4'b1100;
parameter STATE5 = 4'b1110;
parameter STATE6 = 4'b1111;



// this stores the current state 
// DO NOT REMOVE THE INITIALIZATION - IT IS VITAL.
reg[3:0] currentState = 4'b0000;
reg[3:0] nextState = 4'b0000;


// we define the reset action
always @(posedge reset or posedge clock)
    begin
    if(reset) currentState <= 4'b0000;
    else if (clock) currentState <= nextState;
    end



// determine next state: (yes this line should ideally be always @(*), but we want to check every cycle of the fast clock to detect if the left or right button have been pressed and then update the state
// this is more deterministic than always @(*) since this way we are independent of the "wobblyness" of a press on left or right and is how we have decided to implement it.
always @(clk)
    begin
        case (currentState)
            STATE0:
                begin // the following logic should not be changed -> it is here on purpose
                    if( ~(nextState == STATE1 | nextState == STATE4))
                    begin
                       if (left == 1'b1)
                            begin
                                nextState = STATE1;
                            end
    
                        else if (right == 1'b1)
                            begin
                                nextState = STATE4;
                            end
                        else if(right == 1'b0 & left == 1'b0) nextState = STATE0;  
                    end
                end
            STATE1: nextState = STATE2;
            STATE2: nextState = STATE3;
            STATE3: nextState = STATE0;
            STATE4: nextState = STATE5;
            STATE5: nextState = STATE6;
            STATE6: nextState = STATE0;
       endcase
    end

// output logic
always @(*)
    begin
    
        if (currentState[3] == 1)
            begin
                leds[2:0] = currentState[2:0];
                leds[5:3] = 3'b000;
            end
        else
            begin
                leds[5:3] = currentState[2:0];
                leds[2:0] = 3'b000;
            end 
    end

endmodule