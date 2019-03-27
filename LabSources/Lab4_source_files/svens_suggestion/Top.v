`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ETH Zuerich
// Engineer: Sven Pfiffner
// 
// Create Date: 26.03.2019 19:38:02
//////////////////////////////////////////////////////////////////////////////////


module Top(input clock, input reset, input [1:0]direction, output reg[5:0]out);

//Local parameters model the states of the machine
localparam left1 = 3'b001;
localparam left2 = 3'b010;
localparam left3 = 3'b011;
localparam right1 = 3'b100;
localparam right2 = 3'b101;
localparam right3 = 3'b110;
localparam neutral = 3'b111;

//Holds states
reg [2:0] currentState;
reg [2:0] nextState;

//Clock divider (slows down clock signal)
wire clock_en_signal;
clk_div slowClock(.clock(clock),.reset(reset),.clock_en(clock_en_signal));

//As soon as current state changes, determine next state based on input values
always @ (currentState)
    begin
        case(currentState)
        left1: //If we went into state left1
            begin
                if(direction == 2'b11)
                    nextState = neutral;
                else
                    nextState = left2;
            end
        left2: //If we went into state left2
            begin
                if(direction == 2'b11)
                    nextState = neutral;
                else
                    nextState = left3;
            end
        left3: //If we went into state left3
            nextState = neutral;
        right1: //If we went into state right1
            begin
                if(direction == 2'b11)
                    nextState = neutral;
                else
                    nextState = right2;
            end
        right2: //If we went into state right2
            begin
                if(direction == 2'b11)
                    nextState = neutral;
                else
                    nextState = right3;
            end
        right3: //If we went into state right3
            nextState = neutral;
        neutral: //If we went into state neutral
            begin
                if(direction == 2'b10)
                    nextState = left1;
                else if(direction == 2'b01)
                    nextState = right1;
                else
                    nextState = neutral;
            end
        endcase          
    end

//Do when positive clock edge or positive reset edge 
always @ (posedge clock_en_signal, posedge reset)
    begin
        if(reset) //If reset signal was given, reset state
            currentState = neutral;
        else //Else, update state
            currentState = nextState;
    end

//Do when positive clock edge
always @ (posedge clock_en_signal)
    //Maps the current state to output (Refer to lab exercise sheet)
    begin
        if(currentState == left1)
            out = 6'b100000;
        else if(currentState == left2)
            out = 6'b110000;
        else if(currentState == left3)
            out = 6'b111000;
        else if(currentState == right1)
            out = 6'b000100;
        else if(currentState == right2)
            out = 6'b000110;
        else if(currentState == right3)
            out = 6'b000111;
        else
            out = 6'b000000;
    end

endmodule
