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
reg[3:0] currentState;
reg[3:0] nextState;


// we define the reset action
always @(posedge reset or posedge clock)
    begin
    if(reset) currentState <= 4'b0000;
    else if (clock) currentState <= nextState;
    end



// determine next state: -> we always do this after we change the currentState
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
always @(negedge clk)
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