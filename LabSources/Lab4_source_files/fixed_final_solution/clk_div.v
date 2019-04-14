`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2019 21:58:01
// Design Name: 
// Module Name: clk_div
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


module clk_div(input clock, input reset, output clock_en);
    reg [24:0] clk_count;
    always @ (posedge clock)
        begin
            if(reset)
                clk_count <= 0;
            else
                clk_count <= clk_count+1;
        end
        assign clock_en = &clk_count;
endmodule