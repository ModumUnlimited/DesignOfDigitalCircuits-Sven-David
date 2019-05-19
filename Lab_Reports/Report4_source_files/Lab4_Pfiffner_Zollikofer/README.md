This lab has been submitted by Sven Pfiffner and David Zollikofer

We have multiple files in this folder:

- finalresult.mp4 : A video demonstrating how it looks like on our FPGA.

- The TopModule.bit file is a compiled bit file that you can directly load onto your FPGA to see our circuit running.

- The PMW-LED file is an led driver which can let an led blink super fast. (reduce the brightness). 

The brightness can be set to one of the following:
FULL = 3'b111;
ONEHALF = 3'b100;
ONEQUARTER = 3'b010;
ONEEIGHT = 3'b001;
OFF = 3'b000;

- We also have the same clock divider we have already seen in the lab (we have taken the one that was supplied by you).

- The TopModule.v file defines the finite state machine and defines an LED driver for every LED. In order to reduce the number of states, we have 7 states and a direction in which the lights are going. 


To show what is happening more clearly we have mapped our state machine to non PWM leds onto the right 6 leds of our board and the PWM leds to the left 6 leds. When running the sequence one can therefore clearly see that the sequence on the left uses dimmed leds and the one on the right doesn't. 

Furthermore, we have just used led's that are 50% dimmed in our finite state machine. In theory we could have an even smoother transition (all the building blocks are already in our code) but this would just make the FSM more verbose and add a lot more states to it, therefore we decided to keep it simple.
