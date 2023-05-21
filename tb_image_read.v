`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2023 03:14:37 AM
// Design Name: 
// Module Name: tb_image_read
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


module tb_image_read;
    reg clk;
    wire outputValue;

    image_read y(.clk(clk), .channelOutput(outputValue));
    
    initial
    begin 
        clk = 1'b0;     // Initial assignment of the clock to zero
    end
    always #1 clk = ~clk;
    
endmodule
